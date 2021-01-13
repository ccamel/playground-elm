module Page.Asteroids exposing (..)

import Browser.Events exposing (onAnimationFrameDelta)
import Ecs
import Ecs.Components2
import Ecs.Components3
import Ecs.EntityComponents exposing (foldFromRight2)
import GraphicSVG exposing (Shape, blue, group, move, outlined, polygon, red, solid, triangle)
import GraphicSVG.Widget as Widget
import Html exposing (Html, div, hr, p)
import Html.Attributes exposing (class)
import Markdown
import Page.Common
import Svg exposing (Svg)
import Svg.Attributes as Attributes exposing (height, viewBox, width)



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


type alias Sprite =
    Shape Msg


type alias Components =
    Ecs.Components2.Components2 EntityId Position Sprite



-- SINGLETONS
-- SPECS


type alias Specs =
    { all : AllComponentsSpec
    , position : ComponentSpec Position
    , sprite : ComponentSpec Sprite
    }


type alias AllComponentsSpec =
    Ecs.AllComponentsSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


specs : Specs
specs =
    Ecs.Components2.specs Specs



-- SYSTEMS
-- MODEL


type alias World =
    Ecs.World EntityId Components ()


type alias Model =
    { world : World
    , playground : Widget.Model
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
        -- entity id 0, the ship
        |> Ecs.insertEntity 0
        |> Ecs.insertComponent specs.position
            { x = constants.width / 2
            , y = constants.height / 2
            }
        |> Ecs.insertComponent specs.sprite
            (Debug.log "triangle: " (triangle 1.0)
                |> outlined (solid 5) blue
            )



-- UPDATE


type Msg
    = GotAnimationFrameDeltaMilliseconds Float
    | PlaygroundMessage Widget.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ world } as model) =
    case msg of
        GotAnimationFrameDeltaMilliseconds deltaMilliseconds ->
            ( model
            , Cmd.none
            )

        PlaygroundMessage msgw ->
            let
                ( playgroundModel, playgroundCmd ) =
                    Widget.update msgw model.playground
            in
            ( { model | playground = playgroundModel }, Cmd.map PlaygroundMessage playgroundCmd )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ onAnimationFrameDelta GotAnimationFrameDeltaMilliseconds
        , Sub.map PlaygroundMessage Widget.subscriptions
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
            [ foldFromRight2
                specs.sprite
                specs.position
                renderSprite
                []
                world
                |> group
                |> move ( -constants.width / 2.0, -constants.height / 2.0 )
            ]
        ]


renderSprite : EntityId -> Sprite -> Position -> List (Shape Msg) -> List (Shape Msg)
renderSprite entityId sprite position elements =
    (sprite
        |> move ( position.x, position.y )
    )
        :: elements
