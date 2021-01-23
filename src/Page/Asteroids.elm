module Page.Asteroids exposing (..)

import Browser.Events exposing (onAnimationFrameDelta)
import Ecs
import Ecs.Components5
import Ecs.EntityComponents exposing (foldFromRight3)
import GraphicSVG exposing (Shape, blue, group, isosceles, move, outlined, rotate, solid, triangle)
import GraphicSVG.Widget as Widget
import Html exposing (Html, div, hr, p)
import Html.Attributes exposing (class)
import Keyboard exposing (Key)
import Keyboard.Arrows as Keyboard exposing (Direction(..))
import List exposing (foldl)
import Markdown
import Page.Common



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


type alias Velocity =
    { dx : Float
    , dy : Float
    }

type alias Rotation = Float -- in degrees

type alias Sprite =
    Shape Msg


type alias PilotControl = List ShipCommand

type ShipCommand =
    TURN_RIGHT
  | TURN_LEFT
  | ACCELERATE

type alias Components =
    Ecs.Components5.Components5 EntityId Position Velocity Rotation Sprite PilotControl



-- SINGLETONS
-- SPECS


type alias Specs =
    { all : AllComponentsSpec
    , position : ComponentSpec Position
    , velocity : ComponentSpec Velocity
    , rotation : ComponentSpec Rotation
    , sprite : ComponentSpec Sprite
    , pilotControl : ComponentSpec PilotControl
    }


type alias AllComponentsSpec =
    Ecs.AllComponentsSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


specs : Specs
specs =
    Ecs.Components5.specs Specs



-- SYSTEMS


updateWorld : Float -> World -> World
updateWorld deltaSeconds world =
    world
        |> managePilotControls deltaSeconds
        |> applyVelocities deltaSeconds


managePilotControls : Float -> World -> World
managePilotControls deltaSeconds world =
    Ecs.EntityComponents.processFromLeft
        specs.pilotControl
        (managePilotControl deltaSeconds)
        world


managePilotControl : Float -> EntityId -> PilotControl  -> World -> World
managePilotControl deltaSeconds entityId pilotControl world =
    let
      rotate by old =
        case old of
          Just r -> Just (r + by)
          _ -> old
    in
    List.foldl
      (\e w ->
        case e of
            TURN_RIGHT -> Ecs.updateComponent specs.rotation (rotate -1.0) w
            TURN_LEFT -> Ecs.updateComponent specs.rotation (rotate 1.0) w
            ACCELERATE -> w
      )
      world
      pilotControl


applyVelocities : Float -> World -> World
applyVelocities deltaSeconds world =
    Ecs.EntityComponents.processFromLeft2
        specs.velocity
        specs.position
        (applyVelocity deltaSeconds)
        world


applyVelocity : Float -> EntityId -> Velocity -> Position -> World -> World
applyVelocity deltaSeconds _ velocity position world =
    Ecs.insertComponent specs.position
        { x = position.x + velocity.dx * deltaSeconds
        , y = position.y + velocity.dy * deltaSeconds
        }
        world



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
    , height = 232.0
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
        |> Ecs.insertComponent specs.rotation 0.0
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
                    Keyboard.arrowsDirection keys

                components : List ShipCommand
                components =
                  case direction of
                     North -> [ACCELERATE]
                     NorthEast -> [ACCELERATE, TURN_RIGHT]
                     East -> [TURN_RIGHT]
                     SouthEast -> [TURN_RIGHT]
                     South -> []
                     SouthWest -> [TURN_LEFT]
                     West -> [TURN_LEFT]
                     NorthWest -> [ACCELERATE, TURN_LEFT]
                     NoDirection -> []
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
        [
         onAnimationFrameDelta GotAnimationFrameDeltaMilliseconds
        , Sub.map PlaygroundMessage Widget.subscriptions
        ,Sub.map KeyboardMsg Keyboard.subscriptions
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
                specs.rotation
                renderSprite
                []
                world
                |> group
                |> move ( -constants.width / 2.0, -constants.height / 2.0 )
            ]
        ]


renderSprite : EntityId -> Sprite -> Position -> Rotation -> List (Shape Msg) -> List (Shape Msg)
renderSprite entityId sprite position rotation elements =
    (sprite
        |> rotate (degrees rotation)
        |> move ( position.x, position.y )
    )
        :: elements
