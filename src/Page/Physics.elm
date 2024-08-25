module Page.Physics exposing (Model, Msg, info, init, subscriptions, update, view)

import Array exposing (Array, foldl, fromList, get, map, set)
import Basics.Extra exposing (flip, uncurry)
import Browser.Events exposing (onAnimationFrameDelta)
import Canvas exposing (Renderable, arc, lineTo, path, rect, shapes)
import Canvas.Settings exposing (fill, stroke)
import Canvas.Settings.Advanced exposing (Transform, alpha, shadow, transform, translate)
import Canvas.Settings.Line exposing (LineCap(..), LineJoin(..), lineCap, lineJoin, lineWidth)
import Canvas.Settings.Text as TextAlign exposing (align, font)
import Color exposing (Color)
import Color.Interpolate as Color exposing (interpolate)
import Color.Manipulate exposing (darken, lighten)
import Html exposing (Html, button, div, i, input, label, option, section, select, span, text)
import Html.Attributes exposing (checked, class, disabled, selected, style, title, type_, value)
import Html.Events exposing (onClick, onInput)
import Html.Events.Extra.Pointer as Pointer
import Lib.Frame exposing (Frames, addFrame, createFrames, fpsText)
import Lib.Gfx exposing (withAlpha)
import Lib.Page
import List
import Markdown
import Maybe exposing (withDefault)
import String
import Vector2 exposing (Index(..), Vector2, map2)



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "physics-engine"
    , hash = "physics-engine"
    , date = "2020-12-27"
    , description = Markdown.toHtml [ class "content" ] """
Very simple physics engine using [Verlet Integration](https://en.wikipedia.org/wiki/Verlet_integration) algorithm and rendered through an HTML5 canvas.
       """
    , srcRel = "Page/Physics.elm"
    }



-- MODEL


type Simulation
    = PENDULUM
    | DOUBLE_PENDULUM
    | ROPE
    | NECKLACE
    | CLOTH


{-| list of available simulations
-}
simulations : List Simulation
simulations =
    [ PENDULUM, DOUBLE_PENDULUM, ROPE, NECKLACE, CLOTH ]


{-| constants
-}
constants : { height : number, width : number, physicsIteration : Int, interactionInfluence : Float, defaultSimulation : Simulation, backgroundColor : Color, textColor : Color, stickPalette : Float -> Color }
constants =
    { -- width of the canvas
      height = 400

    -- height of the canvas
    , width = 400

    -- number of iterations
    , physicsIteration = 3

    -- radius of the touch point when interacting with the entity
    , interactionInfluence = 10.0

    -- default simulation
    , defaultSimulation = NECKLACE

    -- background color
    , backgroundColor = Color.black

    -- text color
    , textColor = Color.lightBlue

    -- palette used to colorize sticks according to their tension
    , stickPalette = interpolate Color.RGB Color.darkGray Color.lightRed
    }


type alias ID =
    Int


type alias Vector2D =
    Vector2 Float


makeVector2D : ( Float, Float ) -> Vector2D
makeVector2D ( x, y ) =
    Vector2.from2 x y


getX : Vector2D -> Float
getX v =
    Vector2.get Index0 v


getY : Vector2D -> Float
getY v =
    Vector2.get Index1 v


getXY : Vector2D -> ( Float, Float )
getXY v =
    ( getX v, getY v )


apply : (Float -> Float -> a) -> Vector2D -> a
apply f v =
    uncurry f <| getXY v


distSq : Vector2D -> Vector2D -> Float
distSq v1 v2 =
    let
        ( dx, dy ) =
            sub v1 v2 |> getXY
    in
    dx * dx + dy * dy


dist : Vector2D -> Vector2D -> Float
dist v1 v2 =
    sqrt (distSq v1 v2)


add : Vector2D -> Vector2D -> Vector2D
add v1 v2 =
    map2 (+) v1 v2


sub : Vector2D -> Vector2D -> Vector2D
sub v1 v2 =
    map2 (-) v1 v2


mult : Float -> Vector2D -> Vector2D
mult a v =
    Vector2.map ((*) a) v


divide : Float -> Vector2D -> Vector2D
divide a v =
    Vector2.map (\b -> a / b) v


magSq : Vector2D -> Float
magSq v =
    Vector2.foldl (\x r -> x * x + r) 0 v


mag : Vector2D -> Float
mag v =
    sqrt (magSq v)


type alias Dot =
    { id : ID
    , pos : Vector2D
    , oldPos : Vector2D
    , friction : Float
    , groundFriction : Float
    , gravity : Vector2D
    , radius : Float
    , color : Color
    , mass : Float
    , pin : Maybe Vector2D
    }


type alias Stick =
    { p1Id : ID
    , p2Id : ID
    , stiffness : Float
    , color : Color
    , length : Float
    }


type alias Entity =
    { dots : Array Dot
    , sticks : List Stick
    , offset : Vector2D
    }


makeDot : ID -> Vector2D -> Dot
makeDot id p =
    { id = id
    , pos = p
    , oldPos = p
    , friction = 0.97
    , groundFriction = 0.7
    , gravity = makeVector2D ( 0, 1 )
    , radius = 2.0
    , color = Color.blue
    , mass = 1
    , pin = Nothing
    }


withDotVelocity : Vector2D -> Dot -> Dot
withDotVelocity v ({ pos } as dot) =
    { dot
        | oldPos = add pos v
    }


withDotColor : Color -> Dot -> Dot
withDotColor color dot =
    { dot
        | color = color
    }


withDotBrownColor : Dot -> Dot
withDotBrownColor =
    withDotColor Color.darkBrown


withDotRadius : Float -> Dot -> Dot
withDotRadius radius dot =
    { dot
        | radius = radius
    }


pinDotWith : Vector2D -> Dot -> Dot
pinDotWith pin p =
    { p | pin = Just pin }


pinDotPos : Dot -> Dot
pinDotPos ({ pos } as dot) =
    pinDotWith pos dot


updateDot : Dot -> Dot
updateDot ({ pos, gravity } as dot) =
    let
        velocity =
            velocityDot dot
    in
    { dot
        | oldPos = pos
        , pos = pos |> add velocity |> add gravity
    }


velocityDot : Dot -> Vector2D
velocityDot { pos, oldPos, friction, radius, groundFriction } =
    let
        vel =
            sub pos oldPos
                |> mult friction
    in
    if
        ((pos |> getY) >= (toFloat constants.height - radius))
            && (magSq vel > 0.000001)
    then
        let
            m =
                mag vel
        in
        divide m vel
            |> mult (m * groundFriction)

    else
        vel


interactWithEntity : Maybe Interaction -> Entity -> Entity
interactWithEntity maybeInteraction ({ dots, offset } as entity) =
    case maybeInteraction of
        Just interaction ->
            let
                ( pos, oldPos ) =
                    ( interaction.pos |> flip sub offset, interaction.oldPos |> flip sub offset )
            in
            { entity
                | dots =
                    dots
                        |> map
                            (\dot ->
                                let
                                    d =
                                        dist dot.pos pos
                                in
                                if d < constants.interactionInfluence then
                                    { dot
                                        | oldPos = sub pos oldPos |> mult 1.8 |> sub dot.pos
                                    }

                                else
                                    dot
                            )
            }

        _ ->
            entity


constraintDot : Vector2D -> Dot -> Dot
constraintDot offset ({ pos, radius, pin } as dot) =
    let
        d =
            radius * 2

        ( x, y ) =
            pos |> getXY

        ( limitHighW, limitHighH ) =
            makeVector2D ( constants.width - d, constants.height - d ) |> flip sub offset |> getXY

        ( limitLowW, limitLowH ) =
            makeVector2D ( d, d ) |> flip sub offset |> getXY

        p =
            case pin of
                Nothing ->
                    ( if x > limitHighW then
                        limitHighW

                      else if x < limitLowW then
                        limitLowW

                      else
                        x
                    , if y > limitHighH then
                        limitHighH

                      else if y < limitLowH then
                        limitLowH

                      else
                        y
                    )
                        |> makeVector2D

                Just apin ->
                    apin
    in
    { dot
        | pos = p
    }


renderDot : List Transform -> Dot -> Renderable
renderDot transforms { pos, radius, color } =
    let
        ( x, y ) =
            getXY pos

        lightColor =
            lighten 0.2 color
    in
    Canvas.group
        [ transform transforms ]
        [ shapes
            [ fill color
            , shadow { blur = radius * 0.5, offset = ( 1, 1 ), color = Color.rgba 0 0 0 0.3 }
            ]
            [ arc ( x, y ) radius { startAngle = 0, endAngle = 2 * pi, clockwise = False } ]
        , shapes
            [ fill lightColor
            , alpha 0.5
            ]
            [ arc ( x, y ) (radius * 0.8) { startAngle = 0, endAngle = pi, clockwise = False } ]
        , shapes
            [ fill (Color.rgb 1 1 1)
            , alpha 0.6
            ]
            [ arc ( x - radius * 0.3, y - radius * 0.3 ) (radius * 0.2) { startAngle = 0, endAngle = 2 * pi, clockwise = False } ]
        ]


makeStick : Dot -> Dot -> Maybe Float -> Stick
makeStick p1 p2 length =
    { p1Id = p1.id
    , p2Id = p2.id
    , stiffness = 2.5
    , color = darken 0.5 Color.darkGray
    , length =
        case length of
            Just alength ->
                alength

            Nothing ->
                dist p1.pos p2.pos
    }


addStick : ID -> ID -> Maybe Float -> Entity -> Entity
addStick p1Id p2Id length entity =
    let
        ( p1, p2 ) =
            ( getDot p1Id entity, getDot p2Id entity )
    in
    { entity
        | sticks = makeStick p1 p2 length :: entity.sticks
    }


updateStick : Entity -> Stick -> Entity
updateStick entity stick =
    let
        ( p1, p2 ) =
            ( getDot stick.p1Id entity, getDot stick.p2Id entity )

        delta =
            sub p2.pos p1.pos

        d =
            dist p1.pos p2.pos

        diff =
            (stick.length - d) / d * stick.stiffness

        offset =
            delta |> mult (diff * 0.5)

        m =
            p1.mass + p2.mass

        updatePosition pm dot op =
            if dot.pin == Nothing then
                let
                    mass =
                        pm / m
                in
                { dot | pos = dot.pos |> op (mult mass offset) }

            else
                dot

        p1u =
            updatePosition p2.mass p1 (flip sub)

        p2u =
            updatePosition p1.mass p2 add
    in
    entity
        |> setDot p1u
        |> setDot p2u


renderStick : List Transform -> Entity -> Stick -> Renderable
renderStick transforms entity { p1Id, p2Id, color } =
    let
        posLens =
            getXY << .pos << flip getDot entity

        ( pos1, pos2 ) =
            ( posLens p1Id, posLens p2Id )
    in
    Canvas.group
        [ transform transforms ]
        [ shapes
            [ stroke color
            , lineWidth 3
            , lineCap RoundCap
            , lineJoin RoundJoin
            ]
            [ path pos1 [ lineTo pos2 ] ]
        ]


renderStickTension : List Transform -> Entity -> Stick -> Renderable
renderStickTension transforms entity { p1Id, p2Id, length } =
    let
        posLens =
            .pos << flip getDot entity

        ( v1, v2 ) =
            ( posLens p1Id, posLens p2Id )

        ( p1, p2 ) =
            ( getXY v1, getXY v2 )

        tension =
            length / dist v1 v2

        alpha =
            if tension > 1.0 then
                0.0

            else
                1.0 - tension
    in
    shapes
        [ stroke (Color.darkRed |> withAlpha alpha)
        , lineWidth 5
        , transform transforms
        ]
        [ path p1 [ lineTo p2 ]
        ]


type alias EntityMaker =
    () -> Entity


{-| Factory witch produces a brand new cloth (with default values).
-}
clothEntityMaker : EntityMaker
clothEntityMaker () =
    makeCloth 25 20 15.0


{-| Creates a "cloth" entity with the given width, height and spacing.
-}
makeCloth : Int -> Int -> Float -> Entity
makeCloth w h spacing =
    let
        initDot n =
            let
                ( x, y ) =
                    ( remainderBy w n, n // w )

                coords =
                    makeVector2D ( spacing * toFloat x, spacing * toFloat y )

                baseDot =
                    makeDot n coords
            in
            if y == 0 then
                baseDot |> pinDotPos |> withDotBrownColor

            else if y == h - 1 then
                baseDot |> withDotVelocity (makeVector2D ( 5.0, 0.0 ))

            else
                baseDot

        addSticks dot acc =
            let
                n =
                    dot.id

                ( x, y ) =
                    ( remainderBy w n, n // w )

                withHorizontalStick =
                    if x /= 0 then
                        addStick n (n - 1) Nothing

                    else
                        identity

                withVerticalStick =
                    if y /= 0 then
                        addStick n (x + (y - 1) * w) Nothing

                    else
                        identity
            in
            acc |> withVerticalStick |> withHorizontalStick

        initialCloth =
            { dots = Array.initialize (w * h) initDot
            , sticks = []
            , offset = makeVector2D ( 20, 20 )
            }
    in
    Array.foldl addSticks initialCloth initialCloth.dots


{-| Factory witch produces a pendulum, i.e. a body suspended from a fixed support.
-}
pendulumEntityMaker : EntityMaker
pendulumEntityMaker () =
    let
        p0 =
            makeDot 0 (makeVector2D ( 0.0, 0.0 )) |> pinDotPos |> withDotBrownColor

        p1 =
            makeDot 1 (makeVector2D ( 0.0, 150.0 )) |> withDotRadius 10.0 |> withDotVelocity (makeVector2D ( 15.0, 0.0 ))
    in
    { dots = fromList [ p0, p1 ]
    , sticks =
        [ makeStick p0 p1 Nothing
        ]
    , offset = makeVector2D ( 200, 60 )
    }


{-| Factory which produces 2 pendulums linked by a stick.
-}
doublePendulumEntityMaker : EntityMaker
doublePendulumEntityMaker () =
    let
        p00 =
            makeDot 0 (makeVector2D ( 0.0, 0.0 )) |> pinDotPos |> withDotBrownColor

        p01 =
            makeDot 1 (makeVector2D ( 0.0, 50.0 ))

        p02 =
            makeDot 2 (makeVector2D ( 0.0, 100.0 )) |> withDotRadius 10.0

        p10 =
            makeDot 3 (makeVector2D ( 100.0, 0.0 )) |> pinDotPos |> withDotBrownColor

        p11 =
            makeDot 4 (makeVector2D ( 100.0, 50.0 ))

        p12 =
            makeDot 5 (makeVector2D ( 100.0, 100.0 )) |> withDotRadius 10.0 |> withDotVelocity (makeVector2D ( 15.0, 0.0 ))
    in
    { dots = fromList [ p00, p01, p02, p10, p11, p12 ]
    , sticks =
        [ makeStick p00 p01 Nothing
        , makeStick p01 p02 Nothing
        , makeStick p00 p02 Nothing
        , makeStick p10 p11 Nothing
        , makeStick p11 p12 Nothing
        , makeStick p10 p12 Nothing
        , makeStick p01 p11 Nothing
        ]
    , offset = makeVector2D ( 150, 60 )
    }


{-| Factory which produces a rope.
-}
ropeEntityMaker : EntityMaker
ropeEntityMaker () =
    let
        length =
            50

        initDot n =
            let
                coords =
                    makeVector2D ( 0.0, 3.0 * toFloat n )

                baseDot =
                    makeDot n coords
            in
            if n == 0 then
                baseDot |> pinDotPos |> withDotBrownColor

            else if n == length - 1 then
                baseDot |> withDotVelocity (makeVector2D ( 5.0, 0.0 ))

            else
                baseDot

        entity =
            { dots = Array.initialize length initDot
            , sticks = []
            , offset = makeVector2D ( 200, 20 )
            }

        addStickIfNotFirst : Dot -> Entity -> Entity
        addStickIfNotFirst dot acc =
            if dot.id /= 0 then
                addStick dot.id (dot.id - 1) Nothing acc

            else
                acc
    in
    Array.foldl addStickIfNotFirst entity entity.dots


{-| Factory which produces a necklace.
-}
necklaceEntityMaker : EntityMaker
necklaceEntityMaker () =
    let
        length =
            50

        initialSpacing =
            5.0

        spacing =
            10.0

        initDot n =
            let
                coords =
                    makeVector2D ( initialSpacing * toFloat n, 0 )

                baseDot =
                    makeDot n coords |> withDotRadius 3.0
            in
            if n == 0 || n == length - 1 then
                baseDot |> pinDotPos |> withDotBrownColor

            else
                baseDot

        entity =
            { dots = Array.initialize length initDot
            , sticks = []
            , offset = makeVector2D ( (constants.width - (initialSpacing * toFloat length)) / 2, 30 )
            }

        addStickIfNotFirst dot acc =
            if dot.id /= 0 then
                addStick dot.id (dot.id - 1) (Just spacing) acc

            else
                acc
    in
    foldl addStickIfNotFirst entity entity.dots


simulationFromString : String -> Maybe Simulation
simulationFromString name =
    case name of
        "pendulum" ->
            Just PENDULUM

        "double pendulum" ->
            Just DOUBLE_PENDULUM

        "rope" ->
            Just ROPE

        "necklace" ->
            Just NECKLACE

        "cloth" ->
            Just CLOTH

        _ ->
            Nothing


simulationToString : Simulation -> String
simulationToString simulation =
    case simulation of
        PENDULUM ->
            "pendulum"

        DOUBLE_PENDULUM ->
            "double pendulum"

        ROPE ->
            "rope"

        NECKLACE ->
            "necklace"

        CLOTH ->
            "cloth"


{-| Dictionary of available simulations (entities, with associated factory function)
-}
simulationMaker : Simulation -> EntityMaker
simulationMaker simulation =
    case simulation of
        PENDULUM ->
            pendulumEntityMaker

        DOUBLE_PENDULUM ->
            doublePendulumEntityMaker

        ROPE ->
            ropeEntityMaker

        NECKLACE ->
            necklaceEntityMaker

        CLOTH ->
            clothEntityMaker


updateEntity : Entity -> Entity
updateEntity entity =
    entity
        |> updateEntitySticksHelper constants.physicsIteration
        |> updateEntityDots
        |> updateEntitySticks


constraintEntityDots : Entity -> Entity
constraintEntityDots entity =
    { entity
        | dots = map (constraintDot entity.offset) entity.dots
    }


updateEntityDots : Entity -> Entity
updateEntityDots ({ dots } as entity) =
    { entity
        | dots = map updateDot dots
    }


updateEntitySticks : Entity -> Entity
updateEntitySticks ({ sticks } as entity) =
    List.foldl
        (flip updateStick)
        entity
        sticks


updateEntitySticksHelper : Int -> Entity -> Entity
updateEntitySticksHelper n entity =
    if n > 0 then
        updateEntitySticksHelper
            (n - 1)
            (entity
                |> constraintEntityDots
                |> updateEntitySticks
            )

    else
        entity


getDot : ID -> Entity -> Dot
getDot id { dots } =
    get id dots |> withDefault (makeDot id (makeVector2D ( 0.0, 0.0 )))


setDot : Dot -> Entity -> Entity
setDot ({ id } as p) entity =
    { entity
        | dots = set id p entity.dots
    }


type alias Interaction =
    { pos : Vector2D
    , oldPos : Vector2D
    }


initInteraction : Vector2D -> Interaction
initInteraction pos =
    { pos = pos
    , oldPos = pos
    }


updateInteraction : Interaction -> Vector2D -> Interaction
updateInteraction interaction pos =
    { interaction
        | oldPos = interaction.pos
        , pos = pos
    }


type alias ModelRecord =
    { -- the entity simulated
      entity : Entity

    -- the name (short) simulated
    , simulation : Simulation

    -- maintain the state of the interaction (old position, current position)
    , interaction : Maybe Interaction

    -- if simulation is started or not
    , started : Bool

    -- a list containing n last frames, used to compute the fps (frame per seconds)
    , frames : Frames

    -- tells if dots are displayed or not
    , showDots : Bool

    -- tells if sticks are displayed or not
    , showSticks : Bool

    -- tells if stick tension is displayed or not
    , showStickTension : Bool
    }


type Model
    = Model ModelRecord


init : ( Model, Cmd Msg )
init =
    ( Model
        { entity = simulationMaker constants.defaultSimulation ()
        , simulation = constants.defaultSimulation
        , interaction = Nothing
        , started = True
        , frames = createFrames 10 -- initial capacity
        , showDots = True
        , showSticks = True
        , showStickTension = False
        }
    , Cmd.none
    )



-- UPDATE


type Msg
    = PointerDown Vector2D
    | PointerMove Vector2D
    | PointerEnd
    | Start
    | Stop
    | Reset
    | ChangeSimulation Simulation
    | ToggleShowDots
    | ToggleShowSticks
    | ToggleShowStickTension
    | Frame Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    Tuple.mapFirst Model <|
        case msg of
            Frame diff ->
                ( { model
                    | entity = model.entity |> updateEntity |> interactWithEntity model.interaction
                    , frames = addFrame model.frames diff
                  }
                , Cmd.none
                )

            PointerDown pos ->
                ( { model | interaction = Just <| initInteraction pos }, Cmd.none )

            PointerMove pos ->
                case model.interaction of
                    Just state ->
                        ( { model | interaction = Just <| updateInteraction state pos }, Cmd.none )

                    Nothing ->
                        ( model, Cmd.none )

            PointerEnd ->
                ( { model | interaction = Nothing }, Cmd.none )

            Start ->
                ( { model | started = True }, Cmd.none )

            Stop ->
                ( { model | started = False }, Cmd.none )

            ChangeSimulation simulation ->
                if simulation /= model.simulation then
                    ( { model
                        | entity = simulationMaker simulation ()
                        , simulation = simulation
                      }
                    , Cmd.none
                    )

                else
                    ( model, Cmd.none )

            ToggleShowDots ->
                ( { model | showDots = not model.showDots }, Cmd.none )

            ToggleShowSticks ->
                ( { model | showSticks = not model.showSticks }, Cmd.none )

            ToggleShowStickTension ->
                ( { model | showStickTension = not model.showStickTension }, Cmd.none )

            Reset ->
                let
                    ( Model m, c ) =
                        init
                in
                ( m, c )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions (Model { started }) =
    if started then
        onAnimationFrameDelta Frame

    else
        Sub.none



-- VIEW


view : Model -> Html Msg
view (Model model) =
    section [ class "section pt-1 has-background-black-bis" ]
        [ div [ class "columns" ]
            [ div [ class "column is-8 is-offset-2" ]
                [ Markdown.toHtml [ class "content is-medium" ] """
Click on the left button of the mouse or touch the screen to interact with the simulation.
        """ ]
            ]
        , div [ class "block" ]
            [ div [ class "columns" ]
                [ div [ class "column is-8 is-offset-2" ]
                    [ controlView model ]
                ]
            ]
        , div [ class "block" ]
            [ simulationView model ]
        , div [ class "columns" ]
            [ div [ class "column is-8 is-offset-2" ]
                [ Markdown.toHtml [ class "content is-medium" ] """
💡 Demonstrates how [elm](https://elm-lang.org/) can deal with some basic mathematical and physical calculations, as well as basic rendering of objects in an HTML canvas,
using elementary functions from the fantastic [joakin/elm-canvas](https://package.elm-lang.org/packages/joakin/elm-canvas/latest/) package.
                """
                , Markdown.toHtml [ class "content is-medium" ] """
ℹ️ Implementation is inspired from [Making a Verlet Physics Engine in Javascript](https://anuraghazra.github.io/blog/making-a-verlet-physics-engine-in-javascript).
                """
                ]
            ]
        ]


simulationView : ModelRecord -> Html Msg
simulationView model =
    div ([ class "has-text-centered", style "touch-action" "none" ] |> withInteractionEvents)
        [ Canvas.toHtml
            ( constants.width, constants.height )
            [ class "physics"
            ]
            (List.concat
                [ [ backgroundShape ]
                , renderSticks model
                , renderStickTensions model
                , renderDots model
                , [ statsText model ]
                ]
            )
        ]


backgroundShape : Canvas.Renderable
backgroundShape =
    shapes [ fill constants.backgroundColor ]
        [ rect ( 0, 0 ) constants.width constants.height ]


renderSticks : ModelRecord -> List Canvas.Renderable
renderSticks { showSticks, entity } =
    if showSticks then
        entity.sticks
            |> List.map (renderStick [ apply translate entity.offset ] entity)

    else
        []


renderStickTensions : ModelRecord -> List Canvas.Renderable
renderStickTensions { showStickTension, entity } =
    if showStickTension then
        entity.sticks
            |> List.map (renderStickTension [ apply translate entity.offset ] entity)

    else
        []


renderDots : ModelRecord -> List Canvas.Renderable
renderDots { showDots, entity } =
    if showDots then
        entity.dots
            |> Array.map (renderDot [ apply translate entity.offset ])
            |> Array.toList

    else
        []


statsText : ModelRecord -> Canvas.Renderable
statsText model =
    [ fpsText model.frames
    , " - "
    , String.fromInt (Array.length model.entity.dots)
    , "dots"
    , " - "
    , String.fromInt (List.length model.entity.sticks)
    , "sticks"
    ]
        |> String.join " "
        |> Canvas.text
            [ font { size = 10, family = "serif" }
            , align TextAlign.Left
            , fill constants.textColor
            ]
            ( 15, 10 )


controlView : ModelRecord -> Html Msg
controlView model =
    div [ class "columns is-centered" ]
        [ div [ class "column is-narrow" ]
            [ div [ class "buttons has-addons is-centered are-small" ]
                [ button
                    [ class "button is-danger ml-2"
                    , type_ "button"
                    , title "reset the simulation"
                    , onClick Reset
                    ]
                    [ span [ class "icon is-small" ] [ i [ class "fa fa-repeat" ] [] ] ]
                , button
                    [ class "button is-success"
                    , disabled model.started
                    , type_ "button"
                    , title "start the simulation"
                    , onClick Start
                    ]
                    [ span [ class "icon is-small" ] [ i [ class "fa fa-play" ] [] ] ]
                , button
                    [ class "button"
                    , disabled (not model.started)
                    , type_ "button"
                    , title "pause the simulation"
                    , onClick Stop
                    ]
                    [ span [ class "icon is-small" ] [ i [ class "fa fa-pause" ] [] ] ]
                , div [ class "select is-info is-small ml-4" ]
                    [ select
                        [ onInput <|
                            ChangeSimulation
                                << Maybe.withDefault constants.defaultSimulation
                                << simulationFromString
                        ]
                        (simulations
                            |> List.map
                                (\name ->
                                    option
                                        [ selected (name == model.simulation)
                                        , value <| simulationToString name
                                        ]
                                        [ text <| simulationToString name ]
                                )
                        )
                    ]
                ]
            ]
        , div [ class "column is-narrow" ]
            [ label [ class "checkbox is-inline-flex is-align-items-center ml-4" ]
                [ input [ type_ "checkbox", checked model.showDots, onClick ToggleShowDots ] []
                , span [ class "is-size-7 ml-2" ] [ text "dots" ]
                ]
            , label [ class "checkbox is-inline-flex is-align-items-center ml-4" ]
                [ input [ type_ "checkbox", checked model.showSticks, onClick ToggleShowSticks ] []
                , span [ class "is-size-7 ml-2" ] [ text "sticks" ]
                ]
            , label [ class "checkbox is-inline-flex is-align-items-center ml-4" ]
                [ input [ type_ "checkbox", checked model.showStickTension, onClick ToggleShowStickTension ] []
                , span [ class "is-size-7 ml-2" ] [ text "tension" ]
                ]
            ]
        ]


withInteractionEvents : List (Html.Attribute Msg) -> List (Html.Attribute Msg)
withInteractionEvents attributes =
    let
        posLens =
            makeVector2D << .offsetPos << .pointer
    in
    Pointer.onWithOptions "pointerdown" { stopPropagation = True, preventDefault = True } (PointerDown << posLens)
        :: Pointer.onMove (PointerMove << posLens)
        :: Pointer.onUp (always PointerEnd)
        :: Pointer.onCancel (always PointerEnd)
        :: Pointer.onOut (always PointerEnd)
        :: attributes
