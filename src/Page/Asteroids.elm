module Page.Asteroids exposing (..)

import Browser.Events exposing (onAnimationFrameDelta)
import Ecs
import Ecs.Components6
import Ecs.EntityComponents exposing (foldFromRight3)
import GraphicSVG exposing (Shape, blue, group, isosceles, move, outlined, rotate, solid)
import GraphicSVG.Widget as Widget
import Html exposing (Html, div, hr, p)
import Html.Attributes exposing (class)
import Keyboard exposing (Key)
import Keyboard.Arrows as Keyboard exposing (Direction(..))
import List
import Markdown
import Page.Common exposing (limitRange, zero)



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



-- in degrees


type alias Orientation =
    Float


type alias Sprite =
    Shape Msg


type alias PilotControl =
    List ShipCommand


type ShipCommand
    = TURN_RIGHT
    | TURN_LEFT
    | ACCELERATE


type alias Components =
    Ecs.Components6.Components6
        EntityId
        Position
        PositionVelocity
        Orientation
        RotationVelocity
        Sprite
        PilotControl



-- SINGLETONS
-- SPECS


type alias Specs =
    { all : AllComponentsSpec
    , position : ComponentSpec Position
    , positionVelocity : ComponentSpec PositionVelocity
    , orientation : ComponentSpec Orientation
    , rotationVelocity : ComponentSpec RotationVelocity
    , sprite : ComponentSpec Sprite
    , pilotControl : ComponentSpec PilotControl
    }


type alias AllComponentsSpec =
    Ecs.AllComponentsSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


specs : Specs
specs =
    Ecs.Components6.specs Specs



-- SYSTEMS


updateWorld : Float -> World -> World
updateWorld deltaSeconds world =
    world
        |> managePilotControls deltaSeconds
        |> applyPositionVelocities deltaSeconds
        |> applyRotationVelocities deltaSeconds


managePilotControls : Float -> World -> World
managePilotControls deltaSeconds world =
    Ecs.EntityComponents.processFromLeft
        specs.pilotControl
        (managePilotControl deltaSeconds)
        world


managePilotControl : Float -> EntityId -> PilotControl -> World -> World
managePilotControl deltaSeconds entityId pilotControl world =
    List.foldl
        (\e w ->
            case e of
                TURN_RIGHT ->
                    Ecs.EntityComponents.processFromLeft
                        specs.rotationVelocity
                        (managePilotControlRotation -0.05 deltaSeconds)
                        w

                TURN_LEFT ->
                    Ecs.EntityComponents.processFromLeft
                        specs.rotationVelocity
                        (managePilotControlRotation 0.05 deltaSeconds)
                        w

                ACCELERATE ->
                    Ecs.EntityComponents.processFromLeft2
                        specs.orientation
                        specs.positionVelocity
                        (managePilotControlPosition 0.5 deltaSeconds)
                        w
        )
        world
        pilotControl


managePilotControlRotation : Float -> Float -> EntityId -> RotationVelocity -> World -> World
managePilotControlRotation by deltaSeconds entityId rotationVelocity world =
    Ecs.insertComponent specs.rotationVelocity
        { dr = limitRange ( -10, 10 ) (rotationVelocity.dr + by)
        }
        world


managePilotControlPosition : Float -> Float -> EntityId -> Orientation -> PositionVelocity -> World -> World
managePilotControlPosition by deltaSeconds entityId orientation positionVelocity world =
    Ecs.insertComponent specs.positionVelocity
        { dx = limitRange ( -10, 10 ) (positionVelocity.dx + by * -(sin <| degrees orientation))
        , dy = limitRange ( -10, 10 ) (positionVelocity.dy + by * (cos <| degrees orientation))
        }
        world


applyRotationVelocities : Float -> World -> World
applyRotationVelocities deltaSeconds world =
    Ecs.EntityComponents.processFromLeft
        specs.rotationVelocity
        (applyRotationVelocity deltaSeconds)
        world


applyRotationVelocity : Float -> EntityId -> RotationVelocity -> World -> World
applyRotationVelocity deltaSeconds _ velocity world =
    world
        |> Ecs.updateComponent
            specs.orientation
            (Maybe.map <| \r -> r + velocity.dr)
        |> Ecs.updateComponent
            specs.rotationVelocity
            (Maybe.map <|
                \v ->
                    { v
                        | dr = withFriction v.dr
                    }
            )


applyPositionVelocities : Float -> World -> World
applyPositionVelocities deltaSeconds world =
    Ecs.EntityComponents.processFromLeft
        specs.positionVelocity
        (applyPositionVelocity deltaSeconds)
        world


applyPositionVelocity : Float -> EntityId -> PositionVelocity -> World -> World
applyPositionVelocity deltaSeconds _ velocity world =
    world
        |> Ecs.updateComponent
            specs.position
            (Maybe.map <|
                \p ->
                    { x = p.x + velocity.dx * deltaSeconds
                    , y = p.y + velocity.dy * deltaSeconds
                    }
            )
        |> Ecs.updateComponent
            specs.positionVelocity
            (Maybe.map <|
                \v ->
                    { v
                        | dx = withFriction v.dx
                        , dy = withFriction v.dy
                    }
            )



-- MODEL


type alias World =
    Ecs.World EntityId Components ()


type alias Model =
    { world : World
    , playground : Widget.Model
    , keys : List Key
    }



-- INIT


constants : { width : Float, height : Float }
constants =
    { -- width of the canvas
      width = 384.0

    -- height of the canvas
    , height = 60.0
    }


init : ( Model, Cmd Msg )
init =
    let
        ( playgroundModel, playgroundCmd ) =
            Widget.init constants.width constants.height "asteroids"
    in
    ( { world = initEntities emptyWorld
      , playground = playgroundModel
      , keys = []
      }
    , Cmd.batch
        [ Cmd.map PlaygroundMessage playgroundCmd
        ]
    )


emptyWorld : World
emptyWorld =
    Ecs.emptyWorld specs.all ()


initEntities : World -> World
initEntities world =
    world
        -- entity id 0, the ship with a position and a sprite
        |> Ecs.insertEntity 0
        |> Ecs.insertComponent specs.position
            { x = constants.width / 2
            , y = constants.height / 2
            }
        |> Ecs.insertComponent specs.orientation 0.0
        |> Ecs.insertComponent specs.rotationVelocity { dr = 0 }
        |> Ecs.insertComponent specs.positionVelocity { dx = 0, dy = 0 }
        |> Ecs.insertComponent specs.sprite
            (isosceles 1.0 1.5
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
            ( { model | world = updateWorld (deltaMilliseconds / 1000) world }
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
                keys =
                    Keyboard.update keyMsg model.keys

                direction =
                    Keyboard.wasdDirection keys

                components : List ShipCommand
                components =
                    case direction of
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
            in
            ( { model
                | keys = keys
                , world =
                    -- add/update a component pilotControl for the ship
                    Ecs.onEntity 0 world
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
view { world, playground } =
    div [ class "container" ]
        [ hr [] []
        , p [ class "text-muted" ]
            [ Markdown.toHtml [ class "info" ] """
Simple Asteroids clone in [Elm](https://elm-lang.org/) .
"""
            ]
        , Widget.view playground
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


renderSprite : EntityId -> Sprite -> Position -> Orientation -> List (Shape Msg) -> List (Shape Msg)
renderSprite entityId sprite position rotation elements =
    (sprite
        |> rotate (degrees rotation)
        |> move ( position.x, position.y )
    )
        :: elements



-- UTILS


withFriction : Float -> Float -> Float
withFriction deltaSeconds v =
    let
        friction =
            0.99

        ndr =
            zero 0.001 (v * friction)
    in
    ndr
