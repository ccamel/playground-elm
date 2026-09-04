module Page.Euclid exposing (CircleExpr, Components, DragBehavior, EntityId, EvaluationError, Geometry, GeometryPartKind, GeometryPartRef, Interaction, Model, Msg, Node, PointExpr, SegmentExpr, Selectable, Singletons, Tool, World, info, init, subscriptions, update, view)

import Dict exposing (Dict)
import Ecs
import Ecs.Components4
import Ecs.EntityComponents
import Ecs.Singletons1
import Html exposing (Html, button, div, i, pre, span, text)
import Html.Attributes exposing (class, style, title, type_)
import Html.Events exposing (on, onClick)
import Json.Decode as Decode
import Lib.Page
import Markdown
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Svg
import Svg.Attributes as SvgAttr exposing (cursor, cx, cy, fill, height, opacity, r, stroke, strokeDasharray, strokeWidth, viewBox, width, x1, x2, y1, y2)



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
    | Segment SegmentExpr
    | Circle CircleExpr


type PointExpr
    = Literal Vec2
    | Midpoint GeometryPartRef
    | OnSegment GeometryPartRef Vec2
    | OnCircle GeometryPartRef Vec2


type SegmentExpr
    = Between GeometryPartRef GeometryPartRef


type CircleExpr
    = CenterThrough GeometryPartRef GeometryPartRef


type Geometry
    = GPoint Vec2
    | GSegment Vec2 Vec2
    | GCircle Vec2 Vec2


type EvaluationError
    = MissingGeometryOwner EntityId
    | MissingGeometryPart GeometryPartRef
    | ExpectedPointGeometryPart GeometryPartRef
    | CyclicGeometryReference (List EntityId)


type Selectable
    = Selectable


type DragBehavior
    = RewritePoint


type alias Components =
    Ecs.Components4.Components4 EntityId Node (Result EvaluationError Geometry) Selectable DragBehavior



-- SINGLETONS


type alias Singletons =
    Ecs.Singletons1.Singletons1 EntityId



-- SPECS


type alias Specs =
    { all : AllComponentsSpec
    , expression : ComponentSpec Node
    , evaluated : ComponentSpec (Result EvaluationError Geometry)
    , selectable : ComponentSpec Selectable
    , dragBehavior : ComponentSpec DragBehavior
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



-- GEOMETRY PARTS


type GeometryPartKind
    = PointLocation
    | SegmentStart
    | SegmentEnd
    | SegmentBody
    | CircleBody


type alias GeometryPartRef =
    { owner : EntityId
    , kind : GeometryPartKind
    }


type alias GeometryPart =
    { ref : GeometryPartRef
    , position : Vec2
    }


type Guide
    = VerticalGuide Float
    | HorizontalGuide Float



-- INTERACTION


type Tool
    = SelectTool
    | PointTool
    | SegmentTool
    | CircleTool
    | MidpointTool


type Interaction
    = Idle
    | Hovering GeometryPartRef
    | Dragging DragState


type alias DragState =
    { geometryPart : GeometryPartRef
    }



-- MODEL


type alias Model =
    { world : World
    , interaction : Interaction
    , activeTool : Maybe Tool
    , segmentStart : Maybe GeometryPartRef
    , segmentPreviewEnd : Maybe Vec2
    , circleCenter : Maybe GeometryPartRef
    , circlePreviewThrough : Maybe Vec2
    , pointerPosition : Vec2
    }



-- MESSAGES


type Msg
    = ToggleTool Tool
    | PointerMoved Vec2
    | PointerDown Vec2
    | PointerUp Vec2



-- INIT


init : ( Model, Cmd Msg )
init =
    ( { world = Ecs.emptyWorld specs.all (Ecs.Singletons1.init 0)
      , interaction = Idle
      , activeTool = Just SelectTool
      , segmentStart = Nothing
      , segmentPreviewEnd = Nothing
      , circleCenter = Nothing
      , circlePreviewThrough = Nothing
      , pointerPosition = vec2 0 0
      }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleTool tool ->
            ( { model
                | activeTool =
                    if model.activeTool == Just tool then
                        Nothing

                    else
                        Just tool
                , interaction = Idle
                , segmentStart = Nothing
                , segmentPreviewEnd = Nothing
                , circleCenter = Nothing
                , circlePreviewThrough = Nothing
              }
            , Cmd.none
            )

        PointerDown pointer ->
            ( startInteraction pointer { model | pointerPosition = pointer }, Cmd.none )

        PointerMoved pointer ->
            ( movePointer pointer model, Cmd.none )

        PointerUp pointer ->
            ( endInteraction pointer { model | pointerPosition = pointer }, Cmd.none )



-- SYSTEMS


startInteraction : Vec2 -> Model -> Model
startInteraction pointer model =
    case model.activeTool of
        Just SelectTool ->
            startSelection pointer model

        Just PointTool ->
            startPoint pointer model

        Just SegmentTool ->
            startSegment pointer model

        Just CircleTool ->
            startCircle pointer model

        Just MidpointTool ->
            startMidpoint pointer model

        Nothing ->
            model


startSelection : Vec2 -> Model -> Model
startSelection pointer model =
    case hitTest pointer model.world of
        Just geometryPart ->
            if
                model.world
                    |> Ecs.onEntity geometryPart.owner
                    |> Ecs.hasComponent specs.dragBehavior
            then
                { model | interaction = Dragging { geometryPart = geometryPart } }

            else
                { model | interaction = Hovering geometryPart }

        Nothing ->
            { model | interaction = Idle }


startPoint : Vec2 -> Model -> Model
startPoint pointer model =
    case hitTest pointer model.world of
        Just _ ->
            { model | interaction = Idle }

        Nothing ->
            let
                ( _, world ) =
                    addPoint pointer model.world
            in
            { model | world = world, interaction = Idle }


pointAtOrCreate : Vec2 -> World -> ( GeometryPartRef, World )
pointAtOrCreate pointer world =
    case hitTest pointer world of
        Just geometryPart ->
            ( geometryPart, world )

        Nothing ->
            let
                ( entityId, updatedWorld ) =
                    addPoint pointer world
            in
            ( { owner = entityId, kind = PointLocation }, updatedWorld )


startSegment : Vec2 -> Model -> Model
startSegment pointer model =
    let
        ( geometryPart, world ) =
            pointAtOrCreate pointer model.world
    in
    case model.segmentStart of
        Just start ->
            if start == geometryPart then
                { model
                    | world = world
                    , interaction = Hovering geometryPart
                    , segmentPreviewEnd = Just pointer
                }

            else
                { model
                    | world = addSegment start geometryPart world
                    , interaction = Hovering geometryPart
                    , segmentStart = Nothing
                    , segmentPreviewEnd = Nothing
                }

        Nothing ->
            { model
                | world = world
                , interaction = Hovering geometryPart
                , segmentStart = Just geometryPart
                , segmentPreviewEnd = Just pointer
            }


startCircle : Vec2 -> Model -> Model
startCircle pointer model =
    let
        ( geometryPart, world ) =
            pointAtOrCreate pointer model.world
    in
    case model.circleCenter of
        Just center ->
            if center == geometryPart then
                { model
                    | world = world
                    , interaction = Hovering geometryPart
                    , circlePreviewThrough = Just pointer
                }

            else
                { model
                    | world = addCircle center geometryPart world
                    , interaction = Hovering geometryPart
                    , circleCenter = Nothing
                    , circlePreviewThrough = Nothing
                }

        Nothing ->
            { model
                | world = world
                , interaction = Hovering geometryPart
                , circleCenter = Just geometryPart
                , circlePreviewThrough = Just pointer
            }


startMidpoint : Vec2 -> Model -> Model
startMidpoint pointer model =
    case segmentBodyAt pointer model.world of
        Just segment ->
            { model
                | world = addMidpoint segment model.world
                , interaction = Hovering segment
            }

        Nothing ->
            { model | interaction = Idle }


movePointer : Vec2 -> Model -> Model
movePointer pointer model =
    case model.interaction of
        Dragging drag ->
            { model
                | world = dragSystem drag.geometryPart pointer model.world
                , pointerPosition = pointer
            }

        _ ->
            case model.activeTool of
                Just SelectTool ->
                    { model
                        | interaction = interactionAt pointer model.world
                        , pointerPosition = pointer
                    }

                Just SegmentTool ->
                    { model
                        | interaction = interactionAt pointer model.world
                        , segmentPreviewEnd = Just pointer
                        , pointerPosition = pointer
                    }

                Just CircleTool ->
                    { model
                        | interaction = interactionAt pointer model.world
                        , circlePreviewThrough = Just pointer
                        , pointerPosition = pointer
                    }

                Just MidpointTool ->
                    { model
                        | interaction = midpointInteractionAt pointer model.world
                        , pointerPosition = pointer
                    }

                _ ->
                    { model | interaction = Idle, pointerPosition = pointer }


endInteraction : Vec2 -> Model -> Model
endInteraction pointer model =
    case model.activeTool of
        Just SelectTool ->
            { model | interaction = interactionAt pointer model.world }

        Just SegmentTool ->
            { model
                | interaction = interactionAt pointer model.world
                , segmentPreviewEnd = Just pointer
            }

        Just CircleTool ->
            { model
                | interaction = interactionAt pointer model.world
                , circlePreviewThrough = Just pointer
            }

        Just MidpointTool ->
            { model | interaction = midpointInteractionAt pointer model.world }

        _ ->
            { model | interaction = Idle }


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
        |> Ecs.updateSingleton specs.nextEntityId (\id -> id + 1)
        |> derivedComponentsSystem
    )


addMidpoint : GeometryPartRef -> World -> World
addMidpoint segment world =
    let
        entityId =
            Ecs.getSingleton specs.nextEntityId world
    in
    world
        |> Ecs.insertEntity entityId
        |> Ecs.insertComponent specs.expression (Point (Midpoint segment))
        |> Ecs.insertComponent specs.selectable Selectable
        |> Ecs.updateSingleton specs.nextEntityId (\id -> id + 1)
        |> derivedComponentsSystem


addSegment : GeometryPartRef -> GeometryPartRef -> World -> World
addSegment start end world =
    let
        entityId =
            Ecs.getSingleton specs.nextEntityId world
    in
    world
        |> Ecs.insertEntity entityId
        |> Ecs.insertComponent specs.expression (Segment (Between start end))
        |> Ecs.insertComponent specs.selectable Selectable
        |> Ecs.updateSingleton specs.nextEntityId (\id -> id + 1)
        |> derivedComponentsSystem


addCircle : GeometryPartRef -> GeometryPartRef -> World -> World
addCircle center through world =
    let
        entityId =
            Ecs.getSingleton specs.nextEntityId world
    in
    world
        |> Ecs.insertEntity entityId
        |> Ecs.insertComponent specs.expression (Circle (CenterThrough center through))
        |> Ecs.insertComponent specs.selectable Selectable
        |> Ecs.updateSingleton specs.nextEntityId (\id -> id + 1)
        |> derivedComponentsSystem


rewriteNode : DragBehavior -> GeometryPartRef -> Vec2 -> World -> Node -> Maybe Node
rewriteNode dragBehavior geometryPart pointer world node =
    case ( dragBehavior, geometryPart.kind, node ) of
        ( RewritePoint, PointLocation, Point _ ) ->
            Just (rewritePoint geometryPart pointer world)

        _ ->
            Nothing


rewritePoint : GeometryPartRef -> Vec2 -> World -> Node
rewritePoint geometryPart pointer world =
    case snapToCircle geometryPart pointer world of
        Just ( circle, position ) ->
            Point (OnCircle circle.ref position)

        Nothing ->
            case snapToSegment geometryPart pointer world of
                Just ( segment, position ) ->
                    Point (OnSegment segment.ref position)

                Nothing ->
                    Point (Literal (snapToGuides geometryPart pointer world))


dragSystem : GeometryPartRef -> Vec2 -> World -> World
dragSystem geometryPart pointer world =
    let
        activeWorld =
            Ecs.onEntity geometryPart.owner world
    in
    (case ( Ecs.hasEntity activeWorld, Ecs.getComponent specs.dragBehavior activeWorld, Ecs.getComponent specs.expression activeWorld ) of
        ( True, Just dragBehavior, Just node ) ->
            case rewriteNode dragBehavior geometryPart pointer world node of
                Just rewrittenNode ->
                    Ecs.insertComponent specs.expression rewrittenNode activeWorld

                Nothing ->
                    world

        _ ->
            world
    )
        |> derivedComponentsSystem


type alias EvaluationSnapshot =
    Dict EntityId Node


type alias EvaluationState =
    { snapshot : EvaluationSnapshot
    , resolving : List EntityId
    , memo : Dict EntityId (Result EvaluationError Geometry)
    }


type alias Evaluation a =
    ( Result EvaluationError a, EvaluationState )


type alias Resolver =
    { resolveGeometry : EvaluationState -> EntityId -> Evaluation Geometry
    , resolvePointPart : GeometryPartRef -> EvaluationState -> Evaluation Vec2
    }


resolver : Resolver
resolver =
    { resolveGeometry = evaluateEntity
    , resolvePointPart = resolvePointPart
    }


evaluateEntity : EvaluationState -> EntityId -> Evaluation Geometry
evaluateEntity state entityId =
    case Dict.get entityId state.memo of
        Just result ->
            ( result, state )

        Nothing ->
            if List.member entityId state.resolving then
                ( Err (CyclicGeometryReference (cyclePath entityId state.resolving)), state )

            else
                case Dict.get entityId state.snapshot of
                    Just node ->
                        let
                            evaluatingState =
                                { state | resolving = entityId :: state.resolving }

                            ( result, evaluatedState ) =
                                evaluateNode resolver evaluatingState node
                        in
                        ( result
                        , { evaluatedState
                            | resolving = state.resolving
                            , memo = Dict.insert entityId result evaluatedState.memo
                          }
                        )

                    Nothing ->
                        ( Err (MissingGeometryOwner entityId), state )


evaluateNode : Resolver -> EvaluationState -> Node -> Evaluation Geometry
evaluateNode activeResolver state node =
    case node of
        Point expression ->
            evaluatePoint activeResolver state expression
                |> Tuple.mapFirst (Result.map GPoint)

        Segment expression ->
            evaluateSegment activeResolver state expression

        Circle expression ->
            evaluateCircle activeResolver state expression


evaluateSegment : Resolver -> EvaluationState -> SegmentExpr -> Evaluation Geometry
evaluateSegment activeResolver state expression =
    case expression of
        Between startRef endRef ->
            let
                ( startResult, stateAfterStart ) =
                    activeResolver.resolvePointPart startRef state
            in
            case startResult of
                Ok start ->
                    let
                        ( endResult, stateAfterEnd ) =
                            activeResolver.resolvePointPart endRef stateAfterStart
                    in
                    ( Result.map (GSegment start) endResult, stateAfterEnd )

                Err error ->
                    ( Err error, stateAfterStart )


evaluateCircle : Resolver -> EvaluationState -> CircleExpr -> Evaluation Geometry
evaluateCircle activeResolver state expression =
    case expression of
        CenterThrough centerRef throughRef ->
            let
                ( centerResult, stateAfterCenter ) =
                    activeResolver.resolvePointPart centerRef state
            in
            case centerResult of
                Ok center ->
                    let
                        ( throughResult, stateAfterThrough ) =
                            activeResolver.resolvePointPart throughRef stateAfterCenter
                    in
                    ( Result.map (GCircle center) throughResult, stateAfterThrough )

                Err error ->
                    ( Err error, stateAfterCenter )


resolvePointPart : GeometryPartRef -> EvaluationState -> Evaluation Vec2
resolvePointPart geometryPart state =
    let
        ( geometryResult, evaluatedState ) =
            evaluateEntity state geometryPart.owner
    in
    ( Result.andThen (pointPosition geometryPart) geometryResult, evaluatedState )


pointPosition : GeometryPartRef -> Geometry -> Result EvaluationError Vec2
pointPosition geometryPart geometry =
    case ( geometryPart.kind, geometry ) of
        ( PointLocation, GPoint position ) ->
            Ok position

        ( SegmentStart, GSegment start _ ) ->
            Ok start

        ( SegmentEnd, GSegment _ end ) ->
            Ok end

        _ ->
            geometryPartError geometryPart geometry


midpointPosition : GeometryPartRef -> Geometry -> Result EvaluationError Vec2
midpointPosition geometryPart geometry =
    case ( geometryPart.kind, geometry ) of
        ( SegmentBody, GSegment start end ) ->
            Ok (midpoint start end)

        _ ->
            geometryPartError geometryPart geometry


onSegmentPosition : GeometryPartRef -> Vec2 -> Geometry -> Result EvaluationError Vec2
onSegmentPosition geometryPart position geometry =
    case ( geometryPart.kind, geometry ) of
        ( SegmentBody, GSegment start end ) ->
            Ok
                (nearestPointOnSegment position
                    { ref = geometryPart
                    , start = start
                    , end = end
                    }
                )

        _ ->
            geometryPartError geometryPart geometry


onCirclePosition : GeometryPartRef -> Vec2 -> Geometry -> Result EvaluationError Vec2
onCirclePosition geometryPart position geometry =
    case ( geometryPart.kind, geometry ) of
        ( CircleBody, GCircle center through ) ->
            Ok
                (nearestPointOnCircle position
                    { ref = geometryPart
                    , center = center
                    , through = through
                    }
                    |> Maybe.withDefault center
                )

        _ ->
            geometryPartError geometryPart geometry


geometryPartError : GeometryPartRef -> Geometry -> Result EvaluationError a
geometryPartError geometryPart geometry =
    if hasGeometryPart geometryPart.kind geometry then
        Err (ExpectedPointGeometryPart geometryPart)

    else
        Err (MissingGeometryPart geometryPart)


hasGeometryPart : GeometryPartKind -> Geometry -> Bool
hasGeometryPart geometryPartKind geometry =
    case geometry of
        GPoint _ ->
            geometryPartKind == PointLocation

        GSegment _ _ ->
            List.member geometryPartKind [ SegmentStart, SegmentEnd, SegmentBody ]

        GCircle _ _ ->
            geometryPartKind == CircleBody


cyclePath : EntityId -> List EntityId -> List EntityId
cyclePath entityId resolving =
    cyclePathFrom entityId (List.reverse resolving) ++ [ entityId ]


cyclePathFrom : EntityId -> List EntityId -> List EntityId
cyclePathFrom entityId entityIds =
    case entityIds of
        [] ->
            []

        current :: remaining ->
            if current == entityId then
                entityIds

            else
                cyclePathFrom entityId remaining


evaluatePoint : Resolver -> EvaluationState -> PointExpr -> Evaluation Vec2
evaluatePoint activeResolver state expression =
    case expression of
        Literal position ->
            ( Ok position, state )

        Midpoint segment ->
            let
                ( segmentResult, evaluatedState ) =
                    activeResolver.resolveGeometry state segment.owner
            in
            ( Result.andThen (midpointPosition segment) segmentResult, evaluatedState )

        OnSegment segment position ->
            let
                ( segmentResult, evaluatedState ) =
                    activeResolver.resolveGeometry state segment.owner
            in
            ( Result.andThen (onSegmentPosition segment position) segmentResult, evaluatedState )

        OnCircle circle position ->
            let
                ( circleResult, evaluatedState ) =
                    activeResolver.resolveGeometry state circle.owner
            in
            ( Result.andThen (onCirclePosition circle position) circleResult, evaluatedState )


evaluateExpressions : EvaluationSnapshot -> Dict EntityId (Result EvaluationError Geometry)
evaluateExpressions expressions =
    expressions
        |> Dict.foldl
            (\entityId _ state ->
                evaluateEntity state entityId
                    |> Tuple.second
            )
            { snapshot = expressions
            , resolving = []
            , memo = Dict.empty
            }
        |> .memo


evaluationSystem : World -> World
evaluationSystem world =
    Ecs.setComponents specs.evaluated
        (world
            |> Ecs.getComponents specs.expression
            |> evaluateExpressions
        )
        world


dragBehaviorFor : Node -> Maybe DragBehavior
dragBehaviorFor node =
    case node of
        Point (Literal _) ->
            Just RewritePoint

        Point (OnSegment _ _) ->
            Just RewritePoint

        Point (OnCircle _ _) ->
            Just RewritePoint

        Point (Midpoint _) ->
            Nothing

        Segment _ ->
            Nothing

        Circle _ ->
            Nothing


dragBehaviorSystem : World -> World
dragBehaviorSystem world =
    Ecs.setComponents specs.dragBehavior
        (world
            |> Ecs.getComponents specs.expression
            |> Dict.foldl
                (\entityId node dragBehaviors ->
                    case dragBehaviorFor node of
                        Just dragBehavior ->
                            Dict.insert entityId dragBehavior dragBehaviors

                        Nothing ->
                            dragBehaviors
                )
                Dict.empty
        )
        world


derivedComponentsSystem : World -> World
derivedComponentsSystem =
    evaluationSystem >> dragBehaviorSystem


geometryPartsOf : EntityId -> Geometry -> List GeometryPart
geometryPartsOf entityId geometry =
    case geometry of
        GPoint position ->
            [ { ref =
                    { owner = entityId
                    , kind = PointLocation
                    }
              , position = position
              }
            ]

        GSegment start end ->
            [ { ref =
                    { owner = entityId
                    , kind = SegmentStart
                    }
              , position = start
              }
            , { ref =
                    { owner = entityId
                    , kind = SegmentEnd
                    }
              , position = end
              }
            ]

        GCircle _ _ ->
            []


type alias SegmentHitTarget =
    { ref : GeometryPartRef
    , start : Vec2
    , end : Vec2
    }


type alias CircleHitTarget =
    { ref : GeometryPartRef
    , center : Vec2
    , through : Vec2
    }


segmentBodiesIn : World -> List SegmentHitTarget
segmentBodiesIn world =
    Ecs.EntityComponents.foldFromRight2
        specs.selectable
        specs.evaluated
        (\entityId _ evaluated accumulator ->
            case evaluated of
                Ok (GSegment start end) ->
                    { ref = { owner = entityId, kind = SegmentBody }
                    , start = start
                    , end = end
                    }
                        :: accumulator

                _ ->
                    accumulator
        )
        []
        world


circleBodiesIn : World -> List CircleHitTarget
circleBodiesIn world =
    Ecs.EntityComponents.foldFromRight2
        specs.selectable
        specs.evaluated
        (\entityId _ evaluated accumulator ->
            case evaluated of
                Ok (GCircle center through) ->
                    { ref = { owner = entityId, kind = CircleBody }
                    , center = center
                    , through = through
                    }
                        :: accumulator

                _ ->
                    accumulator
        )
        []
        world


geometryPartsIn : World -> List GeometryPart
geometryPartsIn world =
    Ecs.EntityComponents.foldFromRight2
        specs.selectable
        specs.evaluated
        (\entityId _ evaluated accumulator ->
            case evaluated of
                Ok geometry ->
                    geometryPartsOf entityId geometry ++ accumulator

                Err _ ->
                    accumulator
        )
        []
        world


pointGeometryPartsIn : World -> List GeometryPart
pointGeometryPartsIn world =
    geometryPartsIn world
        |> List.filter (\geometryPart -> geometryPart.ref.kind == PointLocation)


alignmentThreshold : Float
alignmentThreshold =
    12


isAligned : (Vec2 -> Float) -> GeometryPart -> GeometryPart -> Bool
isAligned coordinate draggedGeometryPart candidate =
    abs (coordinate candidate.position - coordinate draggedGeometryPart.position) <= alignmentThreshold


nearestGuide : (Float -> Guide) -> (Vec2 -> Float) -> GeometryPart -> List GeometryPart -> Maybe Guide
nearestGuide guide coordinate draggedGeometryPart candidates =
    candidates
        |> List.filter (isAligned coordinate draggedGeometryPart)
        |> List.sortBy (\candidate -> abs (coordinate candidate.position - coordinate draggedGeometryPart.position))
        |> List.head
        |> Maybe.map (\candidate -> guide (coordinate candidate.position))


alignmentGuides : GeometryPart -> List GeometryPart -> List Guide
alignmentGuides draggedGeometryPart candidates =
    List.filterMap identity
        [ nearestGuide VerticalGuide Vec2.getX draggedGeometryPart candidates
        , nearestGuide HorizontalGuide Vec2.getY draggedGeometryPart candidates
        ]


snapAlongGuide : Guide -> Vec2 -> Vec2
snapAlongGuide guide position =
    case guide of
        VerticalGuide x ->
            vec2 x (Vec2.getY position)

        HorizontalGuide y ->
            vec2 (Vec2.getX position) y


snapToGuides : GeometryPartRef -> Vec2 -> World -> Vec2
snapToGuides geometryPart pointer world =
    pointGeometryPartsIn world
        |> List.filter (\candidate -> candidate.ref /= geometryPart)
        |> alignmentGuides { ref = geometryPart, position = pointer }
        |> List.foldl snapAlongGuide pointer


snapToCircle : GeometryPartRef -> Vec2 -> World -> Maybe ( CircleHitTarget, Vec2 )
snapToCircle geometryPart pointer world =
    circleBodiesIn world
        |> List.filter (\circle -> not (circleUsesPoint geometryPart circle world))
        |> List.filter (isWithinCircleHitRadius pointer)
        |> List.sortBy (circleDistanceSquared pointer)
        |> List.head
        |> Maybe.andThen
            (\circle ->
                nearestPointOnCircle pointer circle
                    |> Maybe.map (\position -> ( circle, position ))
            )


circleUsesPoint : GeometryPartRef -> CircleHitTarget -> World -> Bool
circleUsesPoint geometryPart circle world =
    world
        |> Ecs.onEntity circle.ref.owner
        |> Ecs.getComponent specs.expression
        |> Maybe.map (nodeUsesPoint geometryPart)
        |> Maybe.withDefault False


snapToSegment : GeometryPartRef -> Vec2 -> World -> Maybe ( SegmentHitTarget, Vec2 )
snapToSegment geometryPart pointer world =
    segmentBodiesIn world
        |> List.filter (\segment -> not (segmentUsesPoint geometryPart segment world))
        |> List.filter (isWithinSegmentHitRadius pointer)
        |> List.sortBy (segmentDistanceSquared pointer)
        |> List.head
        |> Maybe.map (\segment -> ( segment, nearestPointOnSegment pointer segment ))


segmentUsesPoint : GeometryPartRef -> SegmentHitTarget -> World -> Bool
segmentUsesPoint geometryPart segment world =
    world
        |> Ecs.onEntity segment.ref.owner
        |> Ecs.getComponent specs.expression
        |> Maybe.map (nodeUsesPoint geometryPart)
        |> Maybe.withDefault False


nodeUsesPoint : GeometryPartRef -> Node -> Bool
nodeUsesPoint geometryPart node =
    case node of
        Segment (Between start end) ->
            geometryPart == start || geometryPart == end

        Circle (CenterThrough center through) ->
            geometryPart == center || geometryPart == through

        _ ->
            False


guidesFor : Model -> List Guide
guidesFor model =
    case model.interaction of
        Dragging drag ->
            let
                pointGeometryParts =
                    pointGeometryPartsIn model.world
            in
            pointGeometryParts
                |> List.filter (\geometryPart -> geometryPart.ref == drag.geometryPart)
                |> List.head
                |> Maybe.map
                    (\draggedGeometryPart ->
                        pointGeometryParts
                            |> List.filter (\geometryPart -> geometryPart.ref /= draggedGeometryPart.ref)
                            |> alignmentGuides draggedGeometryPart
                    )
                |> Maybe.withDefault []

        _ ->
            []


hitTest : Vec2 -> World -> Maybe GeometryPartRef
hitTest pointer world =
    geometryPartsIn world
        |> List.filter (isWithinHitRadius pointer)
        |> List.sortBy (Vec2.distanceSquared pointer << .position)
        |> List.head
        |> Maybe.map .ref


isWithinHitRadius : Vec2 -> GeometryPart -> Bool
isWithinHitRadius pointer geometryPart =
    Vec2.distanceSquared pointer geometryPart.position <= 196


segmentBodyAt : Vec2 -> World -> Maybe GeometryPartRef
segmentBodyAt pointer world =
    segmentBodiesIn world
        |> List.filter (isWithinSegmentHitRadius pointer)
        |> List.sortBy (segmentDistanceSquared pointer)
        |> List.head
        |> Maybe.map .ref


isWithinSegmentHitRadius : Vec2 -> SegmentHitTarget -> Bool
isWithinSegmentHitRadius pointer segment =
    segmentDistanceSquared pointer segment <= 196


nearestPointOnSegment : Vec2 -> SegmentHitTarget -> Vec2
nearestPointOnSegment pointer segment =
    let
        startX =
            Vec2.getX segment.start

        startY =
            Vec2.getY segment.start

        deltaX =
            Vec2.getX segment.end - startX

        deltaY =
            Vec2.getY segment.end - startY

        lengthSquared =
            deltaX * deltaX + deltaY * deltaY

        projection =
            if lengthSquared == 0 then
                0

            else
                clamp 0
                    1
                    (((Vec2.getX pointer - startX) * deltaX + (Vec2.getY pointer - startY) * deltaY) / lengthSquared)
    in
    vec2 (startX + projection * deltaX) (startY + projection * deltaY)


segmentDistanceSquared : Vec2 -> SegmentHitTarget -> Float
segmentDistanceSquared pointer segment =
    Vec2.distanceSquared pointer (nearestPointOnSegment pointer segment)


isWithinCircleHitRadius : Vec2 -> CircleHitTarget -> Bool
isWithinCircleHitRadius pointer circle =
    circleDistanceSquared pointer circle <= 196


circleDistanceSquared : Vec2 -> CircleHitTarget -> Float
circleDistanceSquared pointer circle =
    let
        distanceToCenter =
            sqrt (Vec2.distanceSquared pointer circle.center)

        radius =
            sqrt (Vec2.distanceSquared circle.center circle.through)

        difference =
            distanceToCenter - radius
    in
    difference * difference


nearestPointOnCircle : Vec2 -> CircleHitTarget -> Maybe Vec2
nearestPointOnCircle pointer circle =
    let
        centerX =
            Vec2.getX circle.center

        centerY =
            Vec2.getY circle.center

        deltaX =
            Vec2.getX pointer - centerX

        deltaY =
            Vec2.getY pointer - centerY

        distanceToCenter =
            sqrt (deltaX * deltaX + deltaY * deltaY)

        radius =
            sqrt (Vec2.distanceSquared circle.center circle.through)
    in
    if distanceToCenter == 0 || radius == 0 then
        Nothing

    else
        Just
            (vec2
                (centerX + radius * deltaX / distanceToCenter)
                (centerY + radius * deltaY / distanceToCenter)
            )


midpoint : Vec2 -> Vec2 -> Vec2
midpoint start end =
    vec2
        ((Vec2.getX start + Vec2.getX end) / 2)
        ((Vec2.getY start + Vec2.getY end) / 2)


midpointInteractionAt : Vec2 -> World -> Interaction
midpointInteractionAt pointer world =
    segmentBodyAt pointer world
        |> Maybe.map Hovering
        |> Maybe.withDefault Idle


interactionAt : Vec2 -> World -> Interaction
interactionAt pointer world =
    hitTest pointer world
        |> Maybe.map Hovering
        |> Maybe.withDefault Idle


isHighlighted : GeometryPartRef -> Model -> Bool
isHighlighted geometryPart model =
    model.segmentStart
        == Just geometryPart
        || (case model.interaction of
                Idle ->
                    False

                Hovering hovered ->
                    hovered == geometryPart

                Dragging drag ->
                    drag.geometryPart == geometryPart
           )


isDependencyHighlighted : GeometryPartRef -> Model -> Bool
isDependencyHighlighted geometryPart model =
    case ( geometryPart.kind, model.interaction ) of
        ( SegmentBody, Hovering hovered ) ->
            model.world
                |> Ecs.onEntity hovered.owner
                |> Ecs.getComponent specs.expression
                |> Maybe.map (isMidpointOf geometryPart)
                |> Maybe.withDefault False

        _ ->
            False


isMidpointPoint : EntityId -> World -> Bool
isMidpointPoint entityId world =
    world
        |> Ecs.onEntity entityId
        |> Ecs.getComponent specs.expression
        |> Maybe.map isMidpointOfPointExpression
        |> Maybe.withDefault False


isMidpointOf : GeometryPartRef -> Node -> Bool
isMidpointOf segment node =
    case node of
        Point (Midpoint source) ->
            source == segment

        _ ->
            False


isMidpointOfPointExpression : Node -> Bool
isMidpointOfPointExpression node =
    case node of
        Point (Midpoint _) ->
            True

        _ ->
            False


midpointHoverPosition : Model -> Maybe Vec2
midpointHoverPosition model =
    case model.interaction of
        Hovering geometryPart ->
            if isMidpointPoint geometryPart.owner model.world then
                geometryPartsIn model.world
                    |> List.filter (\geometryPart_ -> geometryPart_.ref == geometryPart)
                    |> List.head
                    |> Maybe.map .position

            else
                Nothing

        _ ->
            Nothing



-- EVENTS


canvasWidth : Float
canvasWidth =
    800


canvasHeight : Float
canvasHeight =
    600


pointerPositionDecoder : Decode.Decoder Vec2
pointerPositionDecoder =
    Decode.map4 pointerPositionInCanvas
        (Decode.field "offsetX" Decode.float)
        (Decode.field "offsetY" Decode.float)
        (Decode.field "currentTarget" (Decode.field "clientWidth" Decode.float))
        (Decode.field "currentTarget" (Decode.field "clientHeight" Decode.float))


pointerPositionInCanvas : Float -> Float -> Float -> Float -> Vec2
pointerPositionInCanvas offsetX offsetY renderedWidth renderedHeight =
    vec2
        (scalePointerCoordinate offsetX renderedWidth canvasWidth)
        (scalePointerCoordinate offsetY renderedHeight canvasHeight)


scalePointerCoordinate : Float -> Float -> Float -> Float
scalePointerCoordinate coordinate renderedSize canvasSize =
    if renderedSize > 0 then
        coordinate * canvasSize / renderedSize

    else
        coordinate


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
            [ geometryToolbar model
            , div [ class "box has-text-centered" ]
                [ Svg.svg
                    ([ SvgAttr.class "euclid-canvas mx-auto"
                     , width "100%"
                     , style "max-width" (String.fromFloat canvasWidth ++ "px")
                     , height "100%"
                     , viewBox
                        ("0 0 "
                            ++ String.fromFloat canvasWidth
                            ++ " "
                            ++ String.fromFloat canvasHeight
                        )
                     ]
                        ++ svgInteractionAttributes model
                    )
                    [ viewGridDefinitions
                    , viewCanvasBackground
                    , Svg.g [ SvgAttr.id "layers" ]
                        [ Svg.g
                            [ SvgAttr.id "layer-canvas"
                            , style "pointer-events" "none"
                            ]
                            (canvasLayers model)
                        , Svg.g
                            [ SvgAttr.id "layer-graphics"
                            , style "pointer-events" "none"
                            ]
                            [ viewPointerPosition model.pointerPosition
                            , viewMidpointHoverLabel model
                            ]
                        ]
                    ]
                , worldExpressionView model.world
                ]
            ]
        ]


worldExpressionView : World -> Html Msg
worldExpressionView world =
    pre
        [ class "has-text-left mt-4 p-3"
        , style "font-family" "monospace"
        , style "white-space" "pre-wrap"
        , style "overflow-wrap" "anywhere"
        ]
        [ text (worldExpressionText world) ]


worldExpressionText : World -> String
worldExpressionText world =
    world
        |> Ecs.EntityComponents.foldFromRight
            specs.expression
            (\entityId node expressions -> ( entityId, node ) :: expressions)
            []
        |> List.sortBy Tuple.first
        |> List.map worldExpressionEntryText
        |> String.join ", "


worldExpressionEntryText : ( EntityId, Node ) -> String
worldExpressionEntryText ( entityId, node ) =
    String.fromInt entityId ++ ":" ++ nodeExpressionText node


nodeExpressionText : Node -> String
nodeExpressionText node =
    case node of
        Point pointExpression ->
            "point(" ++ pointExpressionText pointExpression ++ ")"

        Segment segmentExpression ->
            "segment(" ++ segmentExpressionText segmentExpression ++ ")"

        Circle circleExpression ->
            "circle(" ++ circleExpressionText circleExpression ++ ")"


pointExpressionText : PointExpr -> String
pointExpressionText expression =
    case expression of
        Literal position ->
            "free(" ++ positionText position ++ ")"

        Midpoint segment ->
            "midpoint(" ++ geometryPartReferenceText segment ++ ")"

        OnSegment segment position ->
            "on-segment("
                ++ geometryPartReferenceText segment
                ++ ", "
                ++ positionText position
                ++ ")"

        OnCircle circle position ->
            "on-circle("
                ++ geometryPartReferenceText circle
                ++ ", "
                ++ positionText position
                ++ ")"


segmentExpressionText : SegmentExpr -> String
segmentExpressionText expression =
    case expression of
        Between start end ->
            "between("
                ++ geometryPartReferenceText start
                ++ ", "
                ++ geometryPartReferenceText end
                ++ ")"


circleExpressionText : CircleExpr -> String
circleExpressionText expression =
    case expression of
        CenterThrough center through ->
            "center-through("
                ++ geometryPartReferenceText center
                ++ ", "
                ++ geometryPartReferenceText through
                ++ ")"


geometryPartReferenceText : GeometryPartRef -> String
geometryPartReferenceText geometryPart =
    let
        entityReference =
            "#" ++ String.fromInt geometryPart.owner
    in
    case geometryPart.kind of
        PointLocation ->
            entityReference

        SegmentStart ->
            entityReference ++ ".start"

        SegmentEnd ->
            entityReference ++ ".end"

        SegmentBody ->
            entityReference

        CircleBody ->
            entityReference


positionText : Vec2 -> String
positionText position =
    String.fromFloat (Vec2.getX position)
        ++ ", "
        ++ String.fromFloat (Vec2.getY position)


canvasLayers : Model -> List (Html Msg)
canvasLayers model =
    let
        geometryLayers =
            model.world
                |> Ecs.EntityComponents.foldFromRight
                    specs.evaluated
                    (\entityId evaluated accumulator ->
                        case evaluated of
                            Ok geometry ->
                                viewGeometry model entityId geometry :: accumulator

                            Err error ->
                                viewEvaluationError error :: accumulator
                    )
                    []
    in
    List.map viewGuide (guidesFor model)
        ++ List.map viewSegmentPreview (segmentPreviews model)
        ++ List.map viewCirclePreview (circlePreviews model)
        ++ geometryLayers
        ++ (model
                |> midpointPreview
                |> Maybe.map viewMidpointPreview
                |> Maybe.withDefault []
           )


viewGridDefinitions : Html Msg
viewGridDefinitions =
    Svg.defs []
        [ Svg.pattern
            [ SvgAttr.id "euclid-small-grid"
            , SvgAttr.patternUnits "userSpaceOnUse"
            , width "10"
            , height "10"
            ]
            [ Svg.path
                [ SvgAttr.d "M 10 0 L 0 0 0 10"
                , fill "none"
                , stroke "#334155"
                , strokeWidth "0.5"
                , opacity "0.55"
                ]
                []
            ]
        , Svg.pattern
            [ SvgAttr.id "euclid-grid"
            , SvgAttr.patternUnits "userSpaceOnUse"
            , width "100"
            , height "100"
            ]
            [ Svg.rect [ width "100", height "100", fill "#0f172a" ] []
            , Svg.rect [ width "100", height "100", fill "url(#euclid-small-grid)" ] []
            , Svg.path
                [ SvgAttr.d "M 100 0 L 0 0 0 100"
                , fill "none"
                , stroke "#64748b"
                , strokeWidth "1"
                , opacity "0.7"
                ]
                []
            ]
        ]


viewCanvasBackground : Html Msg
viewCanvasBackground =
    Svg.rect
        [ width (String.fromFloat canvasWidth)
        , height (String.fromFloat canvasHeight)
        , fill "url(#euclid-grid)"
        ]
        []


viewPointerPosition : Vec2 -> Html Msg
viewPointerPosition position =
    Svg.g [ SvgAttr.id "coords" ]
        [ Svg.text_
            [ SvgAttr.x "10"
            , SvgAttr.y "20"
            , fill "#e2e8f0"
            , SvgAttr.fontFamily "monospace"
            , SvgAttr.fontSize "14"
            ]
            [ Svg.text <|
                "("
                    ++ String.fromInt (truncate (Vec2.getX position))
                    ++ ", "
                    ++ String.fromInt (truncate (Vec2.getY position))
                    ++ ")"
            ]
        ]


viewMidpointHoverLabel : Model -> Html Msg
viewMidpointHoverLabel model =
    case midpointHoverPosition model of
        Just position ->
            Svg.text_
                [ SvgAttr.x (String.fromFloat (Vec2.getX position + 12))
                , SvgAttr.y
                    (String.fromFloat
                        (if Vec2.getY position < 26 then
                            Vec2.getY position + 22

                         else
                            Vec2.getY position - 12
                        )
                    )
                , fill "#f5a623"
                , SvgAttr.fontFamily "monospace"
                , SvgAttr.fontSize "12"
                ]
                [ Svg.text "Midpoint of segment" ]

        Nothing ->
            Svg.g [] []


geometryToolbar : Model -> Html Msg
geometryToolbar model =
    div [ class "buttons has-addons mb-4", Html.Attributes.attribute "role" "toolbar" ]
        [ toolButton model SelectTool "fa fa-mouse-pointer" "Select & move" "Select and move existing points"
        , toolButton model PointTool "fa fa-crosshairs" "Add points" "Enable or disable point construction"
        , toolButton model SegmentTool "fa fa-minus" "Add segments" "Enable or disable segment construction"
        , toolButton model CircleTool "fa fa-circle-o" "Add circles" "Construct a circle from a center and a passing point"
        , toolButton model MidpointTool "fa fa-circle-o" "Midpoint" "Construct a point at the middle of a segment"
        ]


toolButton : Model -> Tool -> String -> String -> String -> Html Msg
toolButton model tool icon label tooltip =
    button
        [ class <|
            if model.activeTool == Just tool then
                "button is-link is-selected"

            else
                "button"
        , type_ "button"
        , title tooltip
        , Html.Attributes.attribute "aria-pressed"
            (if model.activeTool == Just tool then
                "true"

             else
                "false"
            )
        , onClick (ToggleTool tool)
        ]
        [ span [ class "icon is-small" ] [ i [ class icon ] [] ]
        , span [] [ text label ]
        ]


svgInteractionAttributes : Model -> List (Svg.Attribute Msg)
svgInteractionAttributes model =
    [ cursor (cursorFor model)
    , style "touch-action" "none"
    , onPointerDown
    , onPointerMove
    , onPointerUp
    ]


cursorFor : Model -> String
cursorFor model =
    case model.interaction of
        Dragging _ ->
            "grabbing"

        _ ->
            case model.activeTool of
                Just SelectTool ->
                    case model.interaction of
                        Hovering geometryPart ->
                            if isDraggable geometryPart model.world then
                                "grab"

                            else
                                "default"

                        _ ->
                            "default"

                Just PointTool ->
                    "crosshair"

                Just SegmentTool ->
                    case model.interaction of
                        Hovering _ ->
                            "pointer"

                        _ ->
                            "crosshair"

                Just CircleTool ->
                    case model.interaction of
                        Hovering _ ->
                            "pointer"

                        _ ->
                            "crosshair"

                Just MidpointTool ->
                    case model.interaction of
                        Hovering _ ->
                            "pointer"

                        _ ->
                            "crosshair"

                Nothing ->
                    "default"


isDraggable : GeometryPartRef -> World -> Bool
isDraggable geometryPart world =
    world
        |> Ecs.onEntity geometryPart.owner
        |> Ecs.hasComponent specs.dragBehavior


segmentPreviews : Model -> List ( Vec2, Vec2 )
segmentPreviews model =
    case ( model.segmentStart, model.segmentPreviewEnd ) of
        ( Just startRef, Just end ) ->
            geometryPartsIn model.world
                |> List.filter (\geometryPart -> geometryPart.ref == startRef)
                |> List.head
                |> Maybe.map (\start -> [ ( start.position, end ) ])
                |> Maybe.withDefault []

        _ ->
            []


viewSegmentPreview : ( Vec2, Vec2 ) -> Html Msg
viewSegmentPreview ( start, end ) =
    Svg.line
        [ x1 (String.fromFloat (Vec2.getX start))
        , y1 (String.fromFloat (Vec2.getY start))
        , x2 (String.fromFloat (Vec2.getX end))
        , y2 (String.fromFloat (Vec2.getY end))
        , stroke "#f5a623"
        , strokeWidth "2"
        , strokeDasharray "6 4"
        , opacity "0.8"
        ]
        []


circlePreviews : Model -> List ( Vec2, Vec2 )
circlePreviews model =
    case ( model.circleCenter, model.circlePreviewThrough ) of
        ( Just centerRef, Just through ) ->
            geometryPartsIn model.world
                |> List.filter (\geometryPart -> geometryPart.ref == centerRef)
                |> List.head
                |> Maybe.map (\center -> [ ( center.position, through ) ])
                |> Maybe.withDefault []

        _ ->
            []


viewCirclePreview : ( Vec2, Vec2 ) -> Html Msg
viewCirclePreview ( center, through ) =
    Svg.circle
        [ cx (String.fromFloat (Vec2.getX center))
        , cy (String.fromFloat (Vec2.getY center))
        , r (String.fromFloat (sqrt (Vec2.distanceSquared center through)))
        , fill "none"
        , stroke "#f5a623"
        , strokeWidth "2"
        , strokeDasharray "6 4"
        , opacity "0.8"
        ]
        []


midpointPreview : Model -> Maybe Vec2
midpointPreview model =
    case ( model.activeTool, model.interaction ) of
        ( Just MidpointTool, Hovering segment ) ->
            model.world
                |> Ecs.onEntity segment.owner
                |> Ecs.getComponent specs.evaluated
                |> Maybe.andThen
                    (\evaluated ->
                        case evaluated of
                            Ok geometry ->
                                midpointPosition segment geometry
                                    |> Result.toMaybe

                            Err _ ->
                                Nothing
                    )

        _ ->
            Nothing


viewMidpointPreview : Vec2 -> List (Html Msg)
viewMidpointPreview point =
    [ Svg.circle
        [ cx (String.fromFloat (Vec2.getX point))
        , cy (String.fromFloat (Vec2.getY point))
        , r "6"
        , fill "none"
        , stroke "#f5a623"
        , strokeWidth "2"
        , strokeDasharray "3 2"
        , opacity "0.9"
        ]
        []
    ]


viewGuide : Guide -> Html Msg
viewGuide guide =
    let
        coordinate =
            case guide of
                VerticalGuide value ->
                    String.fromFloat value

                HorizontalGuide value ->
                    String.fromFloat value
    in
    case guide of
        VerticalGuide _ ->
            Svg.line
                [ x1 coordinate
                , y1 "0"
                , x2 coordinate
                , y2 (String.fromFloat canvasHeight)
                , stroke "#94a3b8"
                , strokeWidth "1"
                , strokeDasharray "4 6"
                , opacity "0.45"
                ]
                []

        HorizontalGuide _ ->
            Svg.line
                [ x1 "0"
                , y1 coordinate
                , x2 (String.fromFloat canvasWidth)
                , y2 coordinate
                , stroke "#94a3b8"
                , strokeWidth "1"
                , strokeDasharray "4 6"
                , opacity "0.45"
                ]
                []


viewEvaluationError : EvaluationError -> Html Msg
viewEvaluationError error =
    Svg.g []
        [ Svg.title [] [ Svg.text (evaluationErrorDescription error) ] ]


evaluationErrorDescription : EvaluationError -> String
evaluationErrorDescription error =
    case error of
        MissingGeometryOwner entityId ->
            "Missing geometry owner #" ++ String.fromInt entityId

        MissingGeometryPart geometryPart ->
            "Missing geometry part " ++ geometryPartRefDescription geometryPart

        ExpectedPointGeometryPart geometryPart ->
            "Expected point geometry part " ++ geometryPartRefDescription geometryPart

        CyclicGeometryReference entityIds ->
            "Cyclic geometry reference "
                ++ (entityIds
                        |> List.map String.fromInt
                        |> String.join " -> "
                   )


geometryPartRefDescription : GeometryPartRef -> String
geometryPartRefDescription geometryPart =
    geometryPartKindName geometryPart.kind
        ++ "(#"
        ++ String.fromInt geometryPart.owner
        ++ ")"


geometryPartKindName : GeometryPartKind -> String
geometryPartKindName geometryPartKind =
    case geometryPartKind of
        PointLocation ->
            "PointLocation"

        SegmentStart ->
            "SegmentStart"

        SegmentEnd ->
            "SegmentEnd"

        SegmentBody ->
            "SegmentBody"

        CircleBody ->
            "CircleBody"


viewGeometry : Model -> EntityId -> Geometry -> Html Msg
viewGeometry model entityId geometry =
    case geometry of
        GPoint point ->
            let
                geometryPart =
                    { owner = entityId, kind = PointLocation }

                isMidpoint =
                    isMidpointPoint entityId model.world
            in
            Svg.g []
                (Svg.circle
                    [ cx (String.fromFloat (Vec2.getX point))
                    , cy (String.fromFloat (Vec2.getY point))
                    , r "7"
                    , fill
                        (if isHighlighted geometryPart model then
                            "#f5a623"

                         else
                            "#3273dc"
                        )
                    , stroke "#1f2933"
                    , strokeWidth "2"
                    ]
                    []
                    :: (if isMidpoint then
                            [ Svg.title [] [ Svg.text "Midpoint of segment" ]
                            , Svg.circle
                                [ cx (String.fromFloat (Vec2.getX point))
                                , cy (String.fromFloat (Vec2.getY point))
                                , r "2"
                                , fill "#e2e8f0"
                                , stroke "#1f2933"
                                , strokeWidth "1"
                                ]
                                []
                            ]

                        else
                            []
                       )
                )

        GSegment start end ->
            let
                geometryPart =
                    { owner = entityId, kind = SegmentBody }
            in
            Svg.line
                [ x1 (String.fromFloat (Vec2.getX start))
                , y1 (String.fromFloat (Vec2.getY start))
                , x2 (String.fromFloat (Vec2.getX end))
                , y2 (String.fromFloat (Vec2.getY end))
                , stroke
                    (if isHighlighted geometryPart model then
                        "#f5a623"

                     else if isDependencyHighlighted geometryPart model then
                        "#cbd5e1"

                     else
                        "#94a3b8"
                    )
                , strokeWidth
                    (if isHighlighted geometryPart model then
                        "4"

                     else if isDependencyHighlighted geometryPart model then
                        "3"

                     else
                        "2"
                    )
                ]
                []

        GCircle center through ->
            Svg.circle
                [ cx (String.fromFloat (Vec2.getX center))
                , cy (String.fromFloat (Vec2.getY center))
                , r (String.fromFloat (sqrt (Vec2.distanceSquared center through)))
                , fill "none"
                , stroke "#94a3b8"
                , strokeWidth "2"
                ]
                []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
