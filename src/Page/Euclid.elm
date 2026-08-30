module Page.Euclid exposing (Model, Msg, info, init, subscriptions, update, view)

import Dict exposing (Dict)
import Html exposing (Html, div)
import Html.Attributes exposing (class, style)
import Html.Events exposing (on)
import Json.Decode as Decode
import Lib.Page
import Markdown
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Svg
import Svg.Attributes exposing (cursor, cx, cy, fill, height, r, stroke, strokeWidth, viewBox, width)


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


type alias NodeId =
    Int


type Node
    = Point PointExpr


type PointExpr
    = Literal Vec2


type alias Document =
    { nodes : Dict NodeId Node
    , nextId : Int
    }


type Geometry
    = GPoint Vec2


type alias EvaluatedNode =
    { id : NodeId
    , geometry : Geometry
    }


type FeatureKind
    = PointLocation


type alias FeatureRef =
    { owner : NodeId
    , kind : FeatureKind
    }


type alias Feature =
    { ref : FeatureRef
    , position : Vec2
    }


type Interaction
    = Idle
    | Hovering FeatureRef
    | Dragging DragState


type alias DragState =
    { feature : FeatureRef
    }


type alias Model =
    { document : Document
    , interaction : Interaction
    , pointer : Vec2
    }


type Msg
    = PointerMoved Vec2
    | PointerDown Vec2
    | PointerUp Vec2


init : ( Model, Cmd Msg )
init =
    ( { document = { nodes = Dict.empty, nextId = 0 }
      , interaction = Idle
      , pointer = vec2 0 0
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PointerDown pointer ->
            ( startDrag pointer { model | pointer = pointer }, Cmd.none )

        PointerMoved pointer ->
            ( movePointer pointer { model | pointer = pointer }, Cmd.none )

        PointerUp pointer ->
            ( { model
                | pointer = pointer
                , interaction = interactionAt pointer model.document
              }
            , Cmd.none
            )


startDrag : Vec2 -> Model -> Model
startDrag pointer model =
    case hitTest pointer model.document of
        Just feature ->
            { model | interaction = Dragging { feature = feature } }

        Nothing ->
            let
                ( nodeId, document ) =
                    addPoint pointer model.document
            in
            { model
                | document = document
                , interaction = Dragging { feature = { owner = nodeId, kind = PointLocation } }
            }


movePointer : Vec2 -> Model -> Model
movePointer pointer model =
    case model.interaction of
        Dragging drag ->
            { model | document = rewriteDocument drag.feature pointer model.document }

        _ ->
            { model | interaction = interactionAt pointer model.document }


addPoint : Vec2 -> Document -> ( NodeId, Document )
addPoint point document =
    let
        nodeId =
            document.nextId
    in
    ( nodeId
    , { document
        | nodes = Dict.insert nodeId (Point (Literal point)) document.nodes
        , nextId = document.nextId + 1
      }
    )


rewriteDocument : FeatureRef -> Vec2 -> Document -> Document
rewriteDocument feature point document =
    case feature.kind of
        PointLocation ->
            { document
                | nodes =
                    Dict.update feature.owner
                        (Maybe.map (rewriteNode point))
                        document.nodes
            }


rewriteNode : Vec2 -> Node -> Node
rewriteNode point node =
    case node of
        Point _ ->
            Point (Literal point)


evaluateNode : NodeId -> Node -> EvaluatedNode
evaluateNode nodeId node =
    case node of
        Point expression ->
            { id = nodeId
            , geometry = GPoint (evaluatePoint expression)
            }


evaluatePoint : PointExpr -> Vec2
evaluatePoint expression =
    case expression of
        Literal position ->
            position


evaluateDocument : Document -> List EvaluatedNode
evaluateDocument document =
    document.nodes
        |> Dict.toList
        |> List.map (\( nodeId, node ) -> evaluateNode nodeId node)


featuresOf : EvaluatedNode -> List Feature
featuresOf evaluated =
    case evaluated.geometry of
        GPoint position ->
            [ { ref =
                    { owner = evaluated.id
                    , kind = PointLocation
                    }
              , position = position
              }
            ]


allFeatures : Document -> List Feature
allFeatures document =
    document.nodes
        |> Dict.toList
        |> List.concatMap (\( nodeId, node ) -> node |> evaluateNode nodeId |> featuresOf)


hitTest : Vec2 -> Document -> Maybe FeatureRef
hitTest pointer document =
    allFeatures document
        |> List.filter (isWithinHitRadius pointer)
        |> List.sortBy (Vec2.distanceSquared pointer << .position)
        |> List.head
        |> Maybe.map .ref


isWithinHitRadius : Vec2 -> Feature -> Bool
isWithinHitRadius pointer feature =
    Vec2.distanceSquared pointer feature.position <= 196


interactionAt : Vec2 -> Document -> Interaction
interactionAt pointer document =
    hitTest pointer document
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


view : Model -> Html Msg
view model =
    div [ class "columns is-centered mt-1" ]
        [ div [ class "column is-four-fifths" ]
            [ div [ class "box has-text-centered" ]
                [ Svg.svg
                    [ width "800"
                    , height "600"
                    , viewBox "0 0 800 600"
                    , cursor (cursorFor model.interaction)
                    , style "touch-action" "none"
                    , onPointerDown
                    , onPointerMove
                    , onPointerUp
                    ]
                    (Svg.rect
                        [ width "800"
                        , height "600"
                        , fill "#000000"
                        ]
                        []
                        :: (model.document
                                |> evaluateDocument
                                |> List.map (viewGeometry model)
                           )
                    )
                ]
            ]
        ]


cursorFor : Interaction -> String
cursorFor interaction =
    case interaction of
        Idle ->
            "crosshair"

        Hovering _ ->
            "grab"

        Dragging _ ->
            "grabbing"


viewGeometry : Model -> EvaluatedNode -> Html Msg
viewGeometry model evaluated =
    case evaluated.geometry of
        GPoint point ->
            let
                feature =
                    { owner = evaluated.id, kind = PointLocation }
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


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
