module Page.Asteroids exposing (..)

import Browser.Events exposing (onAnimationFrameDelta)
import Ecs
import Ecs.Components10
import Ecs.EntityComponents exposing (foldFromRight3)
import Ecs.Singletons3
import GraphicSVG exposing (Shape, blue, group, isosceles, line, move, outlined, red, rotate, solid)
import GraphicSVG.Widget as Widget
import Html exposing (Html, div, hr, p)
import Html.Attributes as Attributes exposing (class)
import Keyboard exposing (Key(..), KeyChange(..))
import Keyboard.Arrows as Keyboard exposing (Direction(..))
import List exposing (foldl)
import Markdown
import Page.Common exposing (Frames, addFrame, createFrames, fpsText, limitRange, zero)
import Tuple exposing (first)



-- PAGE INFO


info : Page.Common.PageInfo Msg
info =
    { name = "asteroids"
    , hash = "asteroids"
    , description = Markdown.toHtml [ class "info" ] """

A simple Asteroids clone in [Elm](https://elm-lang.org/).
       """
    , srcRel = "Page/Asteroids.elm"
    }



-- ENTITY


type alias EntityId =
    Int



-- COMPONENTS


type alias Position =
    { x : Float
    , y : Float
    }


type alias PositionVelocity =
    { dx : Float
    , dy : Float
    }


type alias RotationVelocity =
    { dr : Float
    }


type alias Orientation =
    Float


type alias Friction =
    { f : Float -- in degrees
    }


type alias Sprite =
    Shape Msg


type alias ThrustCommand =
    Float


type alias SideThrustCommand =
    Float


type alias FireCommand =
    ()


type alias Ttl =
    { durationTime : Float -- in ms
    , remainingTime : Float -- in ms
    }


newTtl : Float -> Ttl
newTtl durationTime =
    { durationTime = 0, remainingTime = durationTime }


type alias Components =
    Ecs.Components10.Components10
        EntityId
        Position
        PositionVelocity
        Orientation
        RotationVelocity
        Sprite
        ThrustCommand
        SideThrustCommand
        FireCommand
        Friction
        Ttl



-- SINGLETONS


type alias Singletons =
    Ecs.Singletons3.Singletons3 Frame EntityId Keys


type alias Frame =
    { deltaTime : Float -- in ms
    , totalTime : Float -- in ms
    }


type alias Keys =
    ( List Key, Maybe KeyChange )



-- SPECS


type alias Specs =
    { all : AllComponentsSpec
    , position : ComponentSpec Position
    , positionVelocity : ComponentSpec PositionVelocity
    , orientation : ComponentSpec Orientation
    , rotationVelocity : ComponentSpec RotationVelocity
    , sprite : ComponentSpec Sprite
    , thrustCommand : ComponentSpec ThrustCommand
    , sideThrustCommand : ComponentSpec SideThrustCommand
    , fireCommand : ComponentSpec FireCommand
    , friction : ComponentSpec Friction
    , ttl : ComponentSpec Ttl
    , frame : SingletonSpec Frame
    , nextEntityId : SingletonSpec EntityId
    , keys : SingletonSpec Keys
    }


type alias AllComponentsSpec =
    Ecs.AllComponentsSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


type alias SingletonSpec a =
    Ecs.SingletonSpec a Singletons


specs : Specs
specs =
    Specs |> Ecs.Components10.specs |> Ecs.Singletons3.specs



-- SYSTEMS


systems : Float -> ( List Key, Maybe KeyChange ) -> List (World -> World)
systems deltaMillis keys =
    [ frameSystem deltaMillis
    , ttlSystem
    , keyboardInputSystem keys
    , controlCommandSystem
    , firingCommandSystem
    , forwardThrustSystem
    , sideThrustSystem
    , firingSystem
    , positionVelocitySystem
    , rotationVelocitySystem
    , applyFrictions
    , worldBoundsSystem
    ]


theSystem : Float -> ( List Key, Maybe KeyChange ) -> World -> World
theSystem deltaMillis keys =
    foldl (>>) identity (systems deltaMillis keys)


keyboardInputSystem : ( List Key, Maybe KeyChange ) -> World -> World
keyboardInputSystem keys world =
    Ecs.setSingleton specs.keys
        keys
        world


controlCommandSystem : World -> World
controlCommandSystem world =
    let
        keys =
            Ecs.getSingleton specs.keys world |> Tuple.first |> Keyboard.wasdDirection
    in
    world
        |> Ecs.onEntity shipEntityId
        |> (case keys of
                North ->
                    Ecs.insertComponent specs.thrustCommand 5.0

                NorthEast ->
                    Ecs.insertComponent specs.thrustCommand 5.0 >> Ecs.insertComponent specs.sideThrustCommand -5.0

                East ->
                    Ecs.insertComponent specs.sideThrustCommand -5.0

                SouthEast ->
                    Ecs.insertComponent specs.sideThrustCommand -5.0

                SouthWest ->
                    Ecs.insertComponent specs.sideThrustCommand 5.0

                West ->
                    Ecs.insertComponent specs.sideThrustCommand 5.0

                NorthWest ->
                    Ecs.insertComponent specs.thrustCommand 5.0 >> Ecs.insertComponent specs.sideThrustCommand 5.0

                _ ->
                    Ecs.removeComponent specs.thrustCommand >> Ecs.removeComponent specs.sideThrustCommand
           )


firingCommandSystem : World -> World
firingCommandSystem world =
    let
        ( keys, maybeKeyChange ) =
            Ecs.getSingleton specs.keys world
    in
    world
        |> Ecs.onEntity shipEntityId
        |> (case maybeKeyChange of
                Just (KeyDown Spacebar) ->
                    Ecs.insertComponent specs.fireCommand () >> Ecs.setSingleton specs.keys ( keys, Nothing )

                _ ->
                    Ecs.removeComponent specs.fireCommand
           )


frameSystem : Float -> World -> World
frameSystem dt world =
    Ecs.updateSingleton specs.frame
        (\frame ->
            { totalTime = frame.totalTime + dt
            , deltaTime = dt
            }
        )
        world


forwardThrustSystem : World -> World
forwardThrustSystem world =
    Ecs.EntityComponents.processFromLeft3
        specs.thrustCommand
        specs.positionVelocity
        specs.orientation
        (\_ thrust pv o w ->
            let
                bounds =
                    ( -100, 100 )

                ( dx, dy ) =
                    vFromOrientation o |> vMult thrust
            in
            Ecs.insertComponent specs.positionVelocity
                { dx = limitRange bounds (pv.dx + dx)
                , dy = limitRange bounds (pv.dy + dy)
                }
                w
        )
        world


sideThrustSystem : World -> World
sideThrustSystem world =
    Ecs.EntityComponents.processFromLeft2
        specs.sideThrustCommand
        specs.rotationVelocity
        (\_ thrust rv w ->
            Ecs.insertComponent specs.rotationVelocity
                { dr = limitRange ( -100, 100 ) (rv.dr + thrust)
                }
                w
        )
        world


firingSystem : World -> World
firingSystem world =
    Ecs.EntityComponents.processFromLeft3
        specs.fireCommand
        specs.orientation
        specs.position
        (\_ _ o p ->
            newBulletEntity o p >> Ecs.removeComponent specs.fireCommand
        )
        world


rotationVelocitySystem : World -> World
rotationVelocitySystem world =
    let
        dt =
            deltaTime world / 1000
    in
    Ecs.EntityComponents.processFromLeft
        specs.rotationVelocity
        (\_ velocity w ->
            w
                |> Ecs.updateComponent
                    specs.orientation
                    (Maybe.map <| \r -> r + velocity.dr * dt)
        )
        world


positionVelocitySystem : World -> World
positionVelocitySystem world =
    let
        dt =
            deltaTime world / 1000
    in
    Ecs.EntityComponents.processFromLeft
        specs.positionVelocity
        (\_ velocity w ->
            w
                |> Ecs.updateComponent
                    specs.position
                    (Maybe.map <|
                        \p ->
                            { x = p.x + velocity.dx * dt
                            , y = p.y + velocity.dy * dt
                            }
                    )
        )
        world


applyFrictions : World -> World
applyFrictions world =
    Ecs.EntityComponents.processFromLeft
        specs.friction
        applyFriction
        world


applyFriction : EntityId -> Friction -> World -> World
applyFriction _ { f } world =
    world
        |> Ecs.updateComponent
            specs.positionVelocity
            (Maybe.map <|
                \v ->
                    let
                        ( dx, dy ) =
                            ( v.dx, v.dy )
                                |> vApply ((*) f)
                                |> vApply (zero 0.001)
                    in
                    { v
                        | dx = dx
                        , dy = dy
                    }
            )
        |> Ecs.updateComponent
            specs.rotationVelocity
            (Maybe.map <|
                \v ->
                    let
                        dr =
                            zero 0.001 (v.dr * f)
                    in
                    { v
                        | dr = dr
                    }
            )


worldBoundsSystem : World -> World
worldBoundsSystem world =
    Ecs.EntityComponents.processFromLeft
        specs.positionVelocity
        (\_ _ w ->
            w
                |> Ecs.updateComponent
                    specs.position
                    (Maybe.map <|
                        \p ->
                            { p
                                | x =
                                    if p.x < 0 then
                                        constants.width + p.x

                                    else if p.x > constants.width then
                                        p.x - constants.width

                                    else
                                        p.x
                                , y =
                                    if p.y < 0 then
                                        constants.height + p.y

                                    else if p.y > constants.height then
                                        p.y - constants.height

                                    else
                                        p.y
                            }
                    )
        )
        world


ttlSystem : World -> World
ttlSystem world =
    let
        dt =
            deltaTime world
    in
    world
        |> Ecs.EntityComponents.processFromLeft
            specs.ttl
            (\_ ttl w ->
                Ecs.insertComponent specs.ttl
                    { ttl
                        | durationTime = ttl.durationTime + dt
                        , remainingTime = ttl.remainingTime - dt
                    }
                    w
            )
        |> Ecs.EntityComponents.processFromLeft
            specs.ttl
            (\_ { remainingTime } w ->
                if remainingTime < 0 then
                    Ecs.removeEntity specs.all w

                else
                    w
            )



-- MODEL


type alias World =
    Ecs.World EntityId Components Singletons


type alias Model =
    { world : World
    , playground : Widget.Model
    , keys : ( List Key, Maybe KeyChange )

    -- a list containing n last frames, used to compute the fps (frame per seconds)
    , frames : Frames
    }



-- INIT


constants : { width : Float, height : Float }
constants =
    { -- width of the canvas
      width = 320.0

    -- height of the canvas
    , height = 240.0
    }


init : ( Model, Cmd Msg )
init =
    let
        ( playgroundModel, playgroundCmd ) =
            Widget.init constants.width constants.height "asteroids-game"
    in
    ( { world = initEntities emptyWorld
      , playground = playgroundModel
      , keys = ( [], Nothing )
      , frames = createFrames 10 -- initial capacity
      }
    , Cmd.batch
        [ Cmd.map PlaygroundMessage playgroundCmd
        ]
    )


emptyWorld : World
emptyWorld =
    Ecs.emptyWorld specs.all initSingletons


initSingletons : Singletons
initSingletons =
    Ecs.Singletons3.init
        { deltaTime = 0
        , totalTime = 0
        }
        1
        ( [], Nothing )


initEntities : World -> World
initEntities world =
    world
        |> newShipEntity


newEntity : World -> World
newEntity world =
    world
        |> Ecs.insertEntity (Ecs.getSingleton specs.nextEntityId world)
        |> Ecs.updateSingleton specs.nextEntityId (\id -> id + 1)


shipEntityId : Int
shipEntityId =
    0


newShipEntity : World -> World
newShipEntity world =
    world
        |> Ecs.insertEntity shipEntityId
        |> Ecs.insertComponent specs.position
            { x = constants.width / 2
            , y = constants.height / 2
            }
        |> Ecs.insertComponent specs.orientation 0.0
        |> Ecs.insertComponent specs.rotationVelocity { dr = 0 }
        |> Ecs.insertComponent specs.positionVelocity { dx = 0, dy = 0 }
        |> Ecs.insertComponent specs.friction { f = 0.99 }
        |> Ecs.insertComponent specs.sprite
            (isosceles 1.0 1.5
                |> outlined (solid 5) blue
            )


newBulletEntity : Orientation -> Position -> World -> World
newBulletEntity orientation position world =
    let
        ( vx, vy ) =
            orientation |> vFromOrientation |> vMult 150.0
    in
    world
        |> newEntity
        |> Ecs.insertComponent specs.position position
        |> Ecs.insertComponent specs.orientation orientation
        |> Ecs.insertComponent specs.positionVelocity { dx = vx, dy = vy }
        |> Ecs.insertComponent specs.ttl (newTtl 5000)
        |> Ecs.insertComponent specs.sprite
            (line ( 0, 0 ) ( -0.7, 0 )
                |> outlined (solid 5) red
            )



-- UPDATE


type Msg
    = GotAnimationFrameDeltaMilliseconds Float
    | PlaygroundMessage Widget.Msg
    | KeyboardMsg Keyboard.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ world, keys } as model) =
    case msg of
        GotAnimationFrameDeltaMilliseconds deltaMilliseconds ->
            ( { model
                | world = updateWorld deltaMilliseconds model.keys world
                , frames = addFrame model.frames deltaMilliseconds
                , keys = ( first model.keys, Nothing )
              }
            , Cmd.none
            )

        PlaygroundMessage svgMsg ->
            let
                ( playgroundModel, playgroundCmd ) =
                    Widget.update svgMsg model.playground
            in
            ( { model | playground = playgroundModel }, Cmd.map PlaygroundMessage playgroundCmd )

        KeyboardMsg keyMsg ->
            ( { model
                | keys = Keyboard.updateWithKeyChange Keyboard.anyKeyUpper keyMsg (first model.keys)
                , world = world
              }
            , Cmd.none
            )


updateWorld : Float -> ( List Key, Maybe KeyChange ) -> World -> World
updateWorld deltaMillis keys world =
    theSystem deltaMillis keys world



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ onAnimationFrameDelta GotAnimationFrameDeltaMilliseconds
        , Sub.map PlaygroundMessage Widget.subscriptions
        , Sub.map KeyboardMsg Keyboard.subscriptions
        ]



-- VIEW


view : Model -> Html Msg
view { world, playground, frames } =
    div [ class "container" ]
        [ hr [] []
        , p [ class "text-muted" ]
            [ Markdown.toHtml [ class "info" ] """
Simple Asteroids clone in [Elm](https://elm-lang.org/) .
"""
            ]
        , div [ class "asteroids" ]
            [ div
                [ Attributes.style "font-family" "monospace"
                ]
                [ Html.text ("entities: " ++ (Ecs.worldEntityCount world |> String.fromInt))
                , Html.text " - "
                , Html.text ("components: " ++ (Ecs.worldComponentCount specs.all world |> String.fromInt))
                , Html.text " - "
                , Html.text <| fpsText frames
                ]
            , div [ class "world" ]
                [ Widget.view
                    playground
                    [ foldFromRight3
                        specs.sprite
                        specs.position
                        specs.orientation
                        renderSprite
                        []
                        world
                        |> group
                        |> move ( -constants.width / 2.0, -constants.height / 2.0 )
                    ]
                ]
            ]
        ]


renderSprite : EntityId -> Sprite -> Position -> Orientation -> List (Shape Msg) -> List (Shape Msg)
renderSprite _ sprite position rotation elements =
    (sprite
        |> rotate (degrees rotation)
        |> move ( position.x, position.y )
    )
        :: elements



-- CONVENIENT FUNS


deltaTime : World -> Float
deltaTime world =
    Ecs.getSingleton specs.frame world |> .deltaTime



-- HELPERS


vFromOrientation : Orientation -> ( Float, Float )
vFromOrientation orientation =
    orientation
        |> degrees
        |> (\v ->
                ( v, v )
                    |> vApply2 (sin >> (*) -1) cos
           )


vMagSq : ( Float, Float ) -> Float
vMagSq ( a, b ) =
    a * a + b * b


vApply : (Float -> Float) -> ( Float, Float ) -> ( Float, Float )
vApply f ( a, b ) =
    ( f a, f b )


vApply2 : (Float -> Float) -> (Float -> Float) -> ( Float, Float ) -> ( Float, Float )
vApply2 fa fb ( a, b ) =
    ( fa a, fb b )


vMult : Float -> ( Float, Float ) -> ( Float, Float )
vMult by =
    vApply <| (*) by


vMag : ( Float, Float ) -> Float
vMag v =
    sqrt (vMagSq v)
