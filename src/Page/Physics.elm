module Page.Physics exposing (Dot, Entity, EntityMaker, ID, Model, MouseButton(..), MouseState, Msg(..), Stick, Vector2D, info, init, subscriptions, update, view)

import Array exposing (Array, foldr, fromList, get, map, set, toList)
import Basics.Extra exposing (flip, uncurry)
import Browser.Events exposing (onAnimationFrameDelta)
import Canvas exposing (Renderable, arc, lineTo, path, rect, shapes)
import Canvas.Settings exposing (fill, stroke)
import Canvas.Settings.Advanced exposing (Transform, transform, translate)
import Canvas.Settings.Line exposing (lineWidth)
import Canvas.Settings.Text as TextAlign exposing (align, font)
import Color exposing (Color, rgb255)
import Color.Interpolate as Color exposing (interpolate)
import Html exposing (Html, a, br, button, div, hr, input, label, p, text)
import Html.Attributes exposing (attribute, checked, class, classList, for, href, id, style, type_)
import Html.Events exposing (onClick)
import Html.Events.Extra.Mouse as Mouse exposing (Button(..))
import List exposing (head, length)
import Markdown
import Maybe exposing (withDefault)
import Page.Common exposing (Frames, addFrame, createFrames, fpsText, onClickNotPropagate, withAlpha)
import String exposing (fromInt)
import Vector2 exposing (Index(..), Vector2, map2)



-- PAGE INFO


info : Page.Common.PageInfo Msg
info =
    { name = "physics-engine"
    , hash = "physics-engine"
    , description = Markdown.toHtml [ class "info" ] """
Some physics simulation computed with simple [Verlet](https://en.wikipedia.org/wiki/Verlet_integration)
integration and rendered using HTML5 canvas.
       """
    , srcRel = "Page/Physics.elm"
    }



-- MODEL


{-| constants
-}
constants : { height : number, width : number, physics_iteration : Int, mouse_influence : Float, stickPalette : Float -> Color }
constants =
    { -- width of the canvas
      height = 400

    -- height of the canvas
    , width = 400

    -- number of iterations
    , physics_iteration = 3

    -- radius of the mouse when interacting with the entity
    , mouse_influence = 10.0

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


origin : Vector2D
origin =
    makeVector2D ( 0, 0 )


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
    , color = Color.darkGray
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


interactWithEntity : Maybe MouseState -> Entity -> Entity
interactWithEntity mouseState ({ dots, offset } as entity) =
    case mouseState of
        Just aMouseState ->
            let
                ( pos, oldPos ) =
                    ( aMouseState.pos |> flip sub offset, aMouseState.oldPos |> flip sub offset )
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
                                if d < constants.mouse_influence then
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
    shapes
        [ fill color, transform transforms ]
        [ arc (getXY pos) radius { startAngle = degrees 0, endAngle = degrees 360, clockwise = True }
        ]


makeStick : Dot -> Dot -> Maybe Float -> Stick
makeStick p1 p2 length =
    { p1Id = p1.id
    , p2Id = p2.id
    , stiffness = 2.5
    , color = Color.darkGray
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

        p1u =
            if p1.pin == Nothing then
                let
                    m1 =
                        p2.mass / m
                in
                { p1 | pos = p1.pos |> flip sub (mult m1 offset) }

            else
                p1

        p2u =
            if p2.pin == Nothing then
                let
                    m2 =
                        p1.mass / m
                in
                { p2 | pos = p2.pos |> add (mult m2 offset) }

            else
                p2
    in
    entity
        |> setDot p1u
        |> setDot p2u


renderStick : List Transform -> Entity -> Stick -> Renderable
renderStick transforms entity { p1Id, p2Id, color } =
    let
        lens =
            getXY << .pos << flip getDot entity

        ( pos1, pos2 ) =
            ( lens p1Id, lens p2Id )
    in
    shapes
        [ stroke color
        , transform transforms
        ]
        [ path pos1 [ lineTo pos2 ]
        ]


renderStickTension : List Transform -> Entity -> Stick -> Renderable
renderStickTension transforms entity { p1Id, p2Id, length } =
    let
        lens =
            .pos << flip getDot entity

        ( v1, v2 ) =
            ( lens p1Id, lens p2Id )

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


emptyEntityMaker : EntityMaker
emptyEntityMaker () =
    { dots = Array.empty
    , sticks = []
    , offset = origin
    }


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
        initializer n =
            let
                ( x, y ) =
                    ( remainderBy w n, n // w )

                coords =
                    makeVector2D ( spacing * toFloat x, spacing * toFloat y )
            in
            makeDot n coords
                |> (if y == 0 then
                        pinDotPos >> withDotBrownColor

                    else
                        identity
                   )
                |> (if y == h - 1 then
                        withDotVelocity <| makeVector2D ( 5.0, 0.0 )

                    else
                        identity
                   )

        cloth =
            { dots = Array.initialize (w * h) initializer
            , sticks = []
            , offset = makeVector2D ( 20, 20 )
            }
    in
    foldr
        (\d acc ->
            let
                n =
                    d.id

                ( x, y ) =
                    ( remainderBy w n, n // w )

                step1 =
                    if x /= 0 then
                        addStick n (n - 1) Nothing acc

                    else
                        acc
            in
            if y /= 0 then
                addStick n (x + (y - 1) * w) Nothing step1

            else
                step1
        )
        cloth
        cloth.dots


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

        initializer n =
            let
                coords =
                    makeVector2D ( 0.0, 3.0 * toFloat n )
            in
            makeDot n coords
                |> (if n == 0 then
                        pinDotPos >> withDotBrownColor

                    else
                        identity
                   )
                |> (if n == length - 1 then
                        withDotVelocity (makeVector2D ( 5.0, 0.0 ))

                    else
                        identity
                   )

        entity =
            { dots = Array.initialize length initializer
            , sticks = []
            , offset = makeVector2D ( 200, 20 )
            }
    in
    foldr
        (\d acc ->
            let
                n =
                    d.id
            in
            if n /= 0 then
                addStick n (n - 1) Nothing acc

            else
                acc
        )
        entity
        entity.dots


{-| Factory which produces a necklace.
-}
necklaceEntityMaker : EntityMaker
necklaceEntityMaker () =
    let
        length =
            50

        initialspacing =
            5.0

        spacing =
            10.0

        initializer n =
            let
                coords =
                    makeVector2D ( initialspacing * toFloat n, 0 )
            in
            makeDot n coords
                |> withDotRadius 3.0
                |> (if n == 0 then
                        pinDotPos >> withDotBrownColor

                    else
                        identity
                   )
                |> (if n == length - 1 then
                        pinDotPos >> withDotBrownColor

                    else
                        identity
                   )

        entity =
            { dots = Array.initialize length initializer
            , sticks = []
            , offset = makeVector2D ( (constants.width - (initialspacing * length)) / 2, 30 )
            }
    in
    foldr
        (\d acc ->
            let
                n =
                    d.id
            in
            if n /= 0 then
                addStick n (n - 1) (Just spacing) acc

            else
                acc
        )
        entity
        entity.dots


{-| List of available simulations (entities, with associated factory function)
-}
simulations : List ( String, EntityMaker )
simulations =
    [ ( "pendulum", pendulumEntityMaker )
    , ( "double pendulum", doublePendulumEntityMaker )
    , ( "rope", ropeEntityMaker )
    , ( "necklace", necklaceEntityMaker )
    , ( "cloth", clothEntityMaker )
    ]


updateEntity : Entity -> Entity
updateEntity entity =
    entity
        |> updateEntitySticksHelper constants.physics_iteration
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


type MouseButton
    = Left
    | Right


type alias MouseState =
    { pos : Vector2D
    , oldPos : Vector2D
    , button : MouseButton
    }


initMouseState : Vector2D -> MouseButton -> MouseState
initMouseState pos button =
    { pos = pos
    , oldPos = pos
    , button = button
    }


updateMousePos : MouseState -> Vector2D -> MouseState
updateMousePos mouse pos =
    { mouse
        | oldPos = mouse.pos
        , pos = pos
    }


type alias Model =
    { -- the entity simulated
      entity : Entity

    -- the name (short) simulated
    , entityName : String

    -- maintain the state of the mouse (old position, current position and mouse button clicks)
    , mouse : Maybe MouseState

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


init : ( Model, Cmd Msg )
init =
    let
        ( simulationName, simulationMaker ) =
            head simulations |> withDefault ( "empty", emptyEntityMaker )
    in
    ( { entity = simulationMaker ()
      , entityName = simulationName
      , mouse = Nothing
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
    = MouseDown Button Vector2D
    | MouseMove Vector2D
    | MouseUp
    | Start
    | Stop
    | Reset
    | ChangeSimulation String EntityMaker
    | ToggleShowDots
    | ToggleShowSticks
    | ToggleShowStickTension
    | Frame Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Frame diff ->
            ( { model
                | entity = model.entity |> updateEntity |> interactWithEntity model.mouse
                , frames = addFrame model.frames diff
              }
            , Cmd.none
            )

        MouseDown b pos ->
            case b of
                MainButton ->
                    ( { model | mouse = Just <| initMouseState pos Left }, Cmd.none )

                SecondButton ->
                    ( { model | mouse = Just <| initMouseState pos Right }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        MouseUp ->
            ( { model | mouse = Nothing }, Cmd.none )

        MouseMove pos ->
            case model.mouse of
                Just state ->
                    ( { model | mouse = Just <| updateMousePos state pos }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        Start ->
            ( { model | started = True }, Cmd.none )

        Stop ->
            ( { model | started = False }, Cmd.none )

        ChangeSimulation name factory ->
            if name /= model.entityName then
                ( { model
                    | entity = factory ()
                    , entityName = name
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
            init



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.started then
        onAnimationFrameDelta Frame

    else
        Sub.none



-- VIEW


view : Model -> Html Msg
view ({ entity } as model) =
    div [ class "container animated flipInX" ]
        [ hr [] []
        , Markdown.toHtml [ class "info" ] """
##### Physics Verlet engine (simple)

Using [Verlet Integration](https://en.wikipedia.org/wiki/Verlet_integration) algorithm and rendered through an HTML5 canvas.

Click on the left button of the mouse to interact with the simulation.
        """
        , br [] []
        , div [ class "row display" ]
            [ --- canvas for the simulation
              Canvas.toHtml
                ( constants.width, constants.height )
                [ style "display" "block"
                , Mouse.onDown (\e -> MouseDown e.button (makeVector2D e.offsetPos))
                , Mouse.onMove (.offsetPos >> makeVector2D >> MouseMove)
                , Mouse.onUp (\_ -> MouseUp)
                ]
                (List.concat
                    [ [ shapes [ fill (rgb255 242 242 242) ] [ rect ( 0, 0 ) constants.width constants.height ]
                      ]
                    , if model.showSticks then
                        entity
                            |> .sticks
                            |> List.map (renderStick [ apply translate entity.offset ] entity)

                      else
                        []
                    , if model.showStickTension then
                        entity
                            |> .sticks
                            |> List.map (renderStickTension [ apply translate entity.offset ] entity)

                      else
                        []
                    , if model.showDots then
                        entity
                            |> .dots
                            |> map (renderDot [ apply translate entity.offset ])
                            |> toList

                      else
                        []
                    , [ String.join " "
                            [ fpsText model.frames
                            , " - "
                            , entity.dots |> Array.length |> fromInt
                            , "dots"
                            , " - "
                            , entity.sticks |> length |> fromInt
                            , "sticks"
                            ]
                            |> Canvas.text
                                [ font { size = 10, family = "serif" }
                                , align TextAlign.Left
                                , fill Color.darkBlue
                                ]
                                ( 15, 10 )
                      ]
                    ]
                )
            , div [ class "description col-sm-6" ]
                [ p []
                    [ text "You can "
                    , if model.started then
                        a [ class "action", href "", onClickNotPropagate Start ] [ text "start" ]

                      else
                        a [ class "action", href "", onClickNotPropagate Stop ] [ text "stop" ]
                    , text " the simulation. You can also "
                    , a [ class "action", href "", onClickNotPropagate Reset ] [ text "reset" ]
                    , text " the values to default."
                    ]
                , p []
                    [ text "You can change the simulated entity: " ]
                , div [ class "dropdown" ]
                    [ button
                        [ attribute "aria-expanded" "false"
                        , attribute "aria-haspopup" "true"
                        , class "btn btn-info dropdown-toggle"
                        , attribute "data-toggle" "dropdown"
                        , id "dropdownEntitySimulated"
                        , type_ "button"
                        ]
                        [ text model.entityName ]
                    , div [ attribute "aria-labelledby" "dropdownEntitySimulated", class "dropdown-menu" ]
                        (simulations
                            |> List.map
                                (\( name, factory ) ->
                                    a
                                        [ classList
                                            [ ( "dropdown-item", True )
                                            , ( "selected", name == model.entityName )
                                            ]
                                        , onClick (ChangeSimulation name factory)
                                        , href "#"
                                        ]
                                        [ text name ]
                                )
                        )
                    ]
                , p []
                    [ text "You can show/hide the following elements:" ]
                , div [ class "form-check form-check-inline mb-2" ]
                    [ input [ class "form-check-input", id "toggleShowDots", type_ "checkbox", checked model.showDots, onClick ToggleShowDots ]
                        []
                    , label [ class "form-check-label", for "toggleShowDots" ]
                        [ text "Show dots" ]
                    ]
                , div [ class "form-check form-check-inline mb-2" ]
                    [ input [ class "form-check-input", id "toggleShowTicks", type_ "checkbox", checked model.showSticks, onClick ToggleShowSticks ]
                        []
                    , label [ class "form-check-label", for "toggleShowTicks" ]
                        [ text "Show sticks" ]
                    ]
                , div [ class "form-check form-check-inline mb-2" ]
                    [ input [ class "form-check-input", id "toggleShowTickTension", type_ "checkbox", checked model.showStickTension, onClick ToggleShowStickTension ]
                        []
                    , label [ class "form-check-label", for "toggleShowTickTension" ]
                        [ text "Show stick tension" ]
                    ]
                ]
            ]
        ]
