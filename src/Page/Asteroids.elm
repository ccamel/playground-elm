module Page.Asteroids exposing (..)

import Browser.Events exposing (onAnimationFrameDelta)
import Ecs
import Ecs.Components6
import Ecs.Components7
import Ecs.EntityComponents exposing (foldFromRight3)
import Ecs.Singletons2
import GraphicSVG exposing (Shape, blue, group, isosceles, move, outlined, rotate, solid, square)
import GraphicSVG.Widget as Widget
import Html exposing (Html, div, hr, p)
import Html.Attributes as Attributes exposing (class)
import Keyboard exposing (Key(..), KeyChange(..))
import Keyboard.Arrows as Keyboard exposing (Direction(..))
import List
import List.Extra exposing (remove)
import Markdown
import Page.Common exposing (Frames, addFrame, createFrames, fpsText, limitRange, zero)



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
    { f : Float
    }



-- in degrees


type alias Sprite =
    Shape Msg


type alias PilotControl =
    List ShipCommand


type ShipCommand
    = TURN_RIGHT
    | TURN_LEFT
    | ACCELERATE
    | FIRE


type alias Components =
    Ecs.Components7.Components7
        EntityId
        Position
        PositionVelocity
        Orientation
        RotationVelocity
        Sprite
        PilotControl
        Friction



-- SINGLETONS


type alias Singletons =
    Ecs.Singletons2.Singletons2 Frame EntityId


type alias Frame =
    { deltaTime : Float
    , totalTime : Float
    }



-- SPECS


type alias Specs =
    { all : AllComponentsSpec
    , position : ComponentSpec Position
    , positionVelocity : ComponentSpec PositionVelocity
    , orientation : ComponentSpec Orientation
    , rotationVelocity : ComponentSpec RotationVelocity
    , sprite : ComponentSpec Sprite
    , pilotControl : ComponentSpec PilotControl
    , friction : ComponentSpec Friction
    , frame : SingletonSpec Frame
    , nextEntityId : SingletonSpec EntityId
    }


type alias AllComponentsSpec =
    Ecs.AllComponentsSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


type alias SingletonSpec a =
    Ecs.SingletonSpec a Singletons


specs : Specs
specs =
    Specs |> Ecs.Components7.specs |> Ecs.Singletons2.specs



-- SYSTEMS


updateWorld : Float -> World -> World
updateWorld deltaMillis world =
    world
        |> updateFrame deltaMillis
        |> managePilotControls
        |> applyPositionVelocities
        |> applyRotationVelocities
        |> applyFrictions
        |> manageWorldBounds


updateFrame : Float -> World -> World
updateFrame deltaTime world =
    Ecs.updateSingleton specs.frame
        (\frame ->
            { totalTime = frame.totalTime + deltaTime
            , deltaTime = deltaTime
            }
        )
        world


managePilotControls : World -> World
managePilotControls world =
    Ecs.EntityComponents.processFromLeft
        specs.pilotControl
        managePilotControl
        world


managePilotControl : EntityId -> PilotControl -> World -> World
managePilotControl entityId pilotControl world =
    let
        maybeRotationVelocity =
            Ecs.getComponent specs.rotationVelocity world

        maybeOrientation =
            Ecs.getComponent specs.orientation world

        maybePositionVelocity =
            Ecs.getComponent specs.positionVelocity world

        maybePosition =
            Ecs.getComponent specs.position world
    in
    List.foldl
        (\e w ->
            case e of
                TURN_RIGHT ->
                    w
                        |> (case maybeRotationVelocity of
                                Just rotationVelocity ->
                                    managePilotControlRotation -5 rotationVelocity

                                _ ->
                                    identity
                           )

                TURN_LEFT ->
                    w
                        |> (case maybeRotationVelocity of
                                Just rotationVelocity ->
                                    managePilotControlRotation 5 rotationVelocity

                                _ ->
                                    identity
                           )

                ACCELERATE ->
                    w
                        |> (case ( maybeOrientation, maybePositionVelocity ) of
                                ( Just orientation, Just positionVelocity ) ->
                                    managePilotControlPosition 5 orientation positionVelocity

                                _ ->
                                    identity
                           )

                FIRE ->
                    w
                        |> Ecs.insertComponent specs.pilotControl (remove FIRE pilotControl)
                        |> (case ( maybeOrientation, maybePosition ) of
                                ( Just orientation, Just position ) ->
                                    newBulletEntity orientation position

                                _ ->
                                    identity
                           )
                        |> Ecs.onEntity entityId
        )
        world
        pilotControl


managePilotControlRotation : Float -> RotationVelocity -> World -> World
managePilotControlRotation by rotationVelocity world =
    Ecs.insertComponent specs.rotationVelocity
        { dr = limitRange ( -100, 100 ) (rotationVelocity.dr + by)
        }
        world


managePilotControlPosition : Float -> Orientation -> PositionVelocity -> World -> World
managePilotControlPosition by orientation positionVelocity world =
    let
        bounds =
            ( -100, 100 )

        ( dx, dy ) =
            vFromOrientation orientation |> vMult by
    in
    Ecs.insertComponent specs.positionVelocity
        { dx = limitRange bounds (positionVelocity.dx + dx)
        , dy = limitRange bounds (positionVelocity.dy + dy)
        }
        world


applyRotationVelocities : World -> World
applyRotationVelocities world =
    Ecs.EntityComponents.processFromLeft
        specs.rotationVelocity
        applyRotationVelocity
        world


applyRotationVelocity : EntityId -> RotationVelocity -> World -> World
applyRotationVelocity _ velocity world =
    let
        deltaTime =
            (Ecs.getSingleton specs.frame world |> .deltaTime) / 1000.0
    in
    world
        |> Ecs.updateComponent
            specs.orientation
            (Maybe.map <| \r -> r + velocity.dr * deltaTime)


applyPositionVelocities : World -> World
applyPositionVelocities world =
    Ecs.EntityComponents.processFromLeft
        specs.positionVelocity
        applyPositionVelocity
        world


applyPositionVelocity : EntityId -> PositionVelocity -> World -> World
applyPositionVelocity _ velocity world =
    let
        deltaTime =
            (Ecs.getSingleton specs.frame world |> .deltaTime) / 1000.0
    in
    world
        |> Ecs.updateComponent
            specs.position
            (Maybe.map <|
                \p ->
                    { x = p.x + velocity.dx * deltaTime
                    , y = p.y + velocity.dy * deltaTime
                    }
            )


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


manageWorldBounds : World -> World
manageWorldBounds world =
    let
        applyWorldBounds _ _ w =
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
    in
    Ecs.EntityComponents.processFromLeft
        specs.positionVelocity
        applyWorldBounds
        world



-- MODEL


type alias World =
    Ecs.World EntityId Components Singletons


type alias Model =
    { world : World
    , playground : Widget.Model
    , keys : List Key

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
      , keys = []
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
    Ecs.Singletons2.init
        { deltaTime = 0
        , totalTime = 0
        }
        1


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
        |> Ecs.insertComponent specs.sprite
            (square 1.0
                |> outlined (solid 5) blue
            )



-- UPDATE


type Msg
    = GotAnimationFrameDeltaMilliseconds Float
    | PlaygroundMessage Widget.Msg
    | KeyboardMsg Keyboard.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ world } as model) =
    case msg of
        GotAnimationFrameDeltaMilliseconds deltaMilliseconds ->
            ( { model
                | world = updateWorld deltaMilliseconds world
                , frames = addFrame model.frames deltaMilliseconds
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
            let
                ( keys, maybeKeyChange ) =
                    Keyboard.updateWithKeyChange Keyboard.anyKeyUpper keyMsg model.keys

                direction =
                    Debug.log "//" (Keyboard.wasdDirection keys)

                components : List ShipCommand
                components =
                    (case direction of
                        North ->
                            [ ACCELERATE ]

                        NorthEast ->
                            [ ACCELERATE, TURN_RIGHT ]

                        East ->
                            [ TURN_RIGHT ]

                        SouthEast ->
                            [ TURN_RIGHT ]

                        South ->
                            []

                        SouthWest ->
                            [ TURN_LEFT ]

                        West ->
                            [ TURN_LEFT ]

                        NorthWest ->
                            [ ACCELERATE, TURN_LEFT ]

                        NoDirection ->
                            []
                    )
                        ++ (case maybeKeyChange of
                                Just (KeyDown Spacebar) ->
                                    [ FIRE ]

                                _ ->
                                    []
                           )
            in
            ( { model
                | keys = keys
                , world =
                    -- add/update a component pilotControl for the ship
                    Ecs.onEntity shipEntityId world
                        |> Ecs.insertComponent specs.pilotControl components
              }
            , Cmd.none
            )



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



-- HELPERS


vFromOrientation : Orientation -> ( Float, Float )
vFromOrientation orientation =
    ( sin <| (*) -1 <| degrees orientation, cos <| degrees orientation )


vMagSq : ( Float, Float ) -> Float
vMagSq ( a, b ) =
    a * a + b * b


vApply : (Float -> Float) -> ( Float, Float ) -> ( Float, Float )
vApply f ( a, b ) =
    ( f a, f b )


vMult : Float -> ( Float, Float ) -> ( Float, Float )
vMult by =
    vApply <| (*) by


vMag : ( Float, Float ) -> Float
vMag v =
    sqrt (vMagSq v)
