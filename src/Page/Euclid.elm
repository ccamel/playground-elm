module Page.Euclid exposing (Components, Draggable, EntityId, FeatureKind, FeatureRef, Geometry, Interaction, Model, Msg, Node, PointExpr, Selectable, Singletons, World, info, init, subscriptions, update, view)

import Dict exposing (Dict)
import Ecs
import Ecs.Components4
import Ecs.EntityComponents
import Ecs.Singletons1
import Html exposing (Html, button, div, i, span, text)
import Html.Attributes exposing (class, style, title, type_)
import Html.Events exposing (on, onClick)
import Json.Decode as Decode
import Lib.Page
import Markdown
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Svg
import Svg.Attributes exposing (cursor, cx, cy, fill, height, r, stroke, strokeWidth, viewBox, width)



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "euclid"
    , hash = "euclid"
    , date = "2026-08-30"
    , description = Markdown.toHtml [] """
An experimental 2D vector playground for geometric construction, manipulation, and composable geometric expressions.
       """
    , srcRel = "Page/Euclid.elm"
    }



-- ENTITY


type alias EntityId =
    Int



-- COMPONENTS


type Node
    = Point PointExpr


type PointExpr
    = Literal Vec2


type Geometry
    = GPoint Vec2


type Selectable
    = Selectable


type Draggable
    = Draggable


type alias Components =
    Ecs.Components4.Components4 EntityId Node Geometry Selectable Draggable



-- SINGLETONS


type alias Singletons =
    Ecs.Singletons1.Singletons1 EntityId



-- SPECS


type alias Specs =
    { all : AllComponentsSpec
    , expression : ComponentSpec Node
    , evaluated : ComponentSpec Geometry
    , selectable : ComponentSpec Selectable
    , draggable : ComponentSpec Draggable
    , nextEntityId : SingletonSpec EntityId
    }


type alias AllComponentsSpec =
    Ecs.AllComponentsSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


type alias SingletonSpec a =
    Ecs.SingletonSpec a Singletons



-- WORLD


type alias World =
    Ecs.World EntityId Components Singletons


specs : Specs
specs =
    Specs |> Ecs.Components4.specs |> Ecs.Singletons1.specs



-- FEATURES


type FeatureKind
    = PointLocation


type alias FeatureRef =
    { owner : EntityId
    , kind : FeatureKind
    }


type alias Feature =
    { ref : FeatureRef
    , position : Vec2
    }



-- INTERACTION


type Interaction
    = Idle
    | Hovering FeatureRef
    | Dragging DragState


type alias DragState =
    { feature : FeatureRef
    }



-- MODEL


type alias Model =
    { world : World
    , interaction : Interaction
    , pointToolActive : Bool
    }



-- MESSAGES


type Msg
    = TogglePointTool
    | PointerMoved Vec2
    | PointerDown Vec2
    | PointerUp Vec2



-- INIT


init : ( Model, Cmd Msg )
init =
    ( { world = Ecs.emptyWorld specs.all (Ecs.Singletons1.init 0)
      , interaction = Idle
      , pointToolActive = False
      }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TogglePointTool ->
            ( { model
                | pointToolActive = not model.pointToolActive
                , interaction = Idle
              }
            , Cmd.none
            )

        PointerDown pointer ->
            ( startDrag pointer model, Cmd.none )

        PointerMoved pointer ->
            ( movePointer pointer model, Cmd.none )

        PointerUp pointer ->
            ( { model | interaction = interactionAt pointer model.world }, Cmd.none )



-- SYSTEMS


startDrag : Vec2 -> Model -> Model
startDrag pointer model =
    case hitTest pointer model.world of
        Just feature ->
            if
                model.world
                    |> Ecs.onEntity feature.owner
                    |> Ecs.hasComponent specs.draggable
            then
                { model | interaction = Dragging { feature = feature } }

            else
                { model | interaction = Hovering feature }

        Nothing ->
            let
                ( entityId, world ) =
                    addPoint pointer model.world
            in
            { model
                | world = world
                , interaction = Dragging { feature = { owner = entityId, kind = PointLocation } }
            }


movePointer : Vec2 -> Model -> Model
movePointer pointer model =
    case model.interaction of
        Dragging drag ->
            { model | world = dragSystem drag.feature pointer model.world }

        _ ->
            { model | interaction = interactionAt pointer model.world }


addPoint : Vec2 -> World -> ( EntityId, World )
addPoint position world =
    let
        entityId =
            Ecs.getSingleton specs.nextEntityId world
    in
    ( entityId
    , world
        |> Ecs.insertEntity entityId
        |> Ecs.insertComponent specs.expression (Point (Literal position))
        |> Ecs.insertComponent specs.selectable Selectable
        |> Ecs.insertComponent specs.draggable Draggable
        |> Ecs.updateSingleton specs.nextEntityId (\id -> id + 1)
        |> evaluationSystem
    )


rewriteNode : FeatureKind -> Vec2 -> Node -> Maybe Node
rewriteNode PointLocation position (Point (Literal _)) =
    Just (Point (Literal position))


dragSystem : FeatureRef -> Vec2 -> World -> World
dragSystem feature position world =
    let
        activeWorld =
            Ecs.onEntity feature.owner world
    in
    (case ( Ecs.hasEntity activeWorld, Ecs.hasComponent specs.draggable activeWorld, Ecs.getComponent specs.expression activeWorld ) of
        ( True, True, Just node ) ->
            case rewriteNode feature.kind position node of
                Just rewrittenNode ->
                    Ecs.insertComponent specs.expression rewrittenNode activeWorld

                Nothing ->
                    world

        _ ->
            world
    )
        |> evaluationSystem


evaluateNode : Node -> Geometry
evaluateNode node =
    case node of
        Point expression ->
            GPoint (evaluatePoint expression)


evaluatePoint : PointExpr -> Vec2
evaluatePoint expression =
    case expression of
        Literal position ->
            position


evaluateExpressions : Dict EntityId Node -> Dict EntityId Geometry
evaluateExpressions =
    Dict.map (\_ node -> evaluateNode node)


evaluationSystem : World -> World
evaluationSystem world =
    Ecs.setComponents specs.evaluated
        (world
            |> Ecs.getComponents specs.expression
            |> evaluateExpressions
        )
        world


featuresOf : EntityId -> Geometry -> List Feature
featuresOf entityId geometry =
    case geometry of
        GPoint position ->
            [ { ref =
                    { owner = entityId
                    , kind = PointLocation
                    }
              , position = position
              }
            ]


hitTest : Vec2 -> World -> Maybe FeatureRef
hitTest pointer world =
    Ecs.EntityComponents.foldFromRight2
        specs.selectable
        specs.evaluated
        (\entityId _ geometry accumulator ->
            featuresOf entityId geometry ++ accumulator
        )
        []
        world
        |> List.filter (isWithinHitRadius pointer)
        |> List.sortBy (Vec2.distanceSquared pointer << .position)
        |> List.head
        |> Maybe.map .ref


isWithinHitRadius : Vec2 -> Feature -> Bool
isWithinHitRadius pointer feature =
    Vec2.distanceSquared pointer feature.position <= 196


interactionAt : Vec2 -> World -> Interaction
interactionAt pointer world =
    hitTest pointer world
        |> Maybe.map Hovering
        |> Maybe.withDefault Idle


isHighlighted : FeatureRef -> Model -> Bool
isHighlighted feature model =
    case model.interaction of
        Idle ->
            False

        Hovering hovered ->
            hovered == feature

        Dragging drag ->
            drag.feature == feature



-- EVENTS


pointerPositionDecoder : Decode.Decoder Vec2
pointerPositionDecoder =
    Decode.map2 vec2
        (Decode.field "offsetX" Decode.float)
        (Decode.field "offsetY" Decode.float)


onPointerDown : Html.Attribute Msg
onPointerDown =
    on "pointerdown" (Decode.map PointerDown pointerPositionDecoder)


onPointerMove : Html.Attribute Msg
onPointerMove =
    on "pointermove" (Decode.map PointerMoved pointerPositionDecoder)


onPointerUp : Html.Attribute Msg
onPointerUp =
    on "pointerup" (Decode.map PointerUp pointerPositionDecoder)



-- VIEWS


view : Model -> Html Msg
view model =
    div [ class "columns is-centered mt-1" ]
        [ div [ class "column is-four-fifths" ]
            [ pointToolToolbar model
            , div [ class "box has-text-centered" ]
                [ Svg.svg
                    ([ width "800"
                     , height "600"
                     , viewBox "0 0 800 600"
                     ]
                        ++ svgInteractionAttributes model
                    )
                    (Svg.rect
                        [ width "800"
                        , height "600"
                        , fill "#000000"
                        ]
                        []
                        :: (model.world
                                |> Ecs.EntityComponents.foldFromRight
                                    specs.evaluated
                                    (\entityId geometry accumulator ->
                                        viewGeometry model entityId geometry :: accumulator
                                    )
                                    []
                           )
                    )
                ]
            ]
        ]


pointToolToolbar : Model -> Html Msg
pointToolToolbar model =
    div [ class "buttons has-addons mb-4", Html.Attributes.attribute "role" "toolbar" ]
        [ button
            [ class <|
                if model.pointToolActive then
                    "button is-link is-selected"

                else
                    "button"
            , type_ "button"
            , title "Enable or disable points addition"
            , Html.Attributes.attribute "aria-pressed"
                (if model.pointToolActive then
                    "true"

                 else
                    "false"
                )
            , onClick TogglePointTool
            ]
            [ span [ class "icon is-small" ] [ i [ class "fa fa-crosshairs" ] [] ]
            , span [] [ text "Add points" ]
            ]
        ]


svgInteractionAttributes : Model -> List (Svg.Attribute Msg)
svgInteractionAttributes model =
    if model.pointToolActive then
        [ cursor (cursorFor model.interaction)
        , style "touch-action" "none"
        , onPointerDown
        , onPointerMove
        , onPointerUp
        ]

    else
        []


cursorFor : Interaction -> String
cursorFor interaction =
    case interaction of
        Idle ->
            "crosshair"

        Hovering _ ->
            "grab"

        Dragging _ ->
            "grabbing"


viewGeometry : Model -> EntityId -> Geometry -> Html Msg
viewGeometry model entityId geometry =
    case geometry of
        GPoint point ->
            let
                feature =
                    { owner = entityId, kind = PointLocation }
            in
            Svg.circle
                [ cx (String.fromFloat (Vec2.getX point))
                , cy (String.fromFloat (Vec2.getY point))
                , r "7"
                , fill
                    (if isHighlighted feature model then
                        "#f5a623"

                     else
                        "#3273dc"
                    )
                , stroke "#1f2933"
                , strokeWidth "2"
                ]
                []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
