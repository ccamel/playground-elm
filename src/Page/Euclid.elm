module Page.Euclid exposing (CircleExpr, CircleIntersectionBranch, Components, DragBehavior, EntityId, EvaluationError, Geometry, GeometryPartKind, GeometryPartRef, Interaction, LineExpr, Model, Msg, Node, PlacementCandidate, PointExpr, SegmentExpr, Selectable, Singletons, Tool, World, info, init, subscriptions, update, view)

import Dict exposing (Dict)
import Ecs
import Ecs.Components4
import Ecs.EntityComponents
import Ecs.Singletons1
import Html exposing (Html, button, div, i, pre, span, text)
import Html.Attributes exposing (class, disabled, style, title, type_)
import Html.Events exposing (on, onClick)
import Json.Decode as Decode
import Lib.Page
import Markdown
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Svg
import Svg.Attributes as SvgAttr exposing (cursor, cx, cy, fill, height, opacity, r, stroke, strokeDasharray, strokeWidth, viewBox, width, x1, x2, y1, y2)
import Time



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "euclid"
    , hash = "euclid"
    , date = "2026-08-30"
    , description = Markdown.toHtml [] """
An experimental, GeoGebra-inspired 2D construction playground: place, attach, and compose live geometric expressions.
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
    | Line LineExpr
    | Circle CircleExpr


type PointExpr
    = Literal Vec2
    | Midpoint GeometryPartRef
    | SegmentIntersection GeometryPartRef GeometryPartRef
    | SegmentLineIntersection GeometryPartRef GeometryPartRef
    | SegmentCircleIntersection GeometryPartRef GeometryPartRef CircleIntersectionBranch
    | LineIntersection GeometryPartRef GeometryPartRef
    | CircleIntersection GeometryPartRef GeometryPartRef CircleIntersectionBranch
    | OnSegment GeometryPartRef Float
    | OnCircle GeometryPartRef Float


type CircleIntersectionBranch
    = FirstCircleIntersection
    | SecondCircleIntersection


type SegmentExpr
    = Between GeometryPartRef GeometryPartRef


type LineExpr
    = Through GeometryPartRef GeometryPartRef


type CircleExpr
    = CenterThrough GeometryPartRef GeometryPartRef


type Geometry
    = GPoint Vec2
    | GSegment Vec2 Vec2
    | GLine Vec2 Vec2
    | GCircle Vec2 Vec2


type EvaluationError
    = MissingGeometryOwner EntityId
    | MissingGeometryPart GeometryPartRef
    | ExpectedPointGeometryPart GeometryPartRef
    | ExpectedSegmentGeometryPart GeometryPartRef
    | ExpectedLineGeometryPart GeometryPartRef
    | ExpectedCircleGeometryPart GeometryPartRef
    | ParallelSegments GeometryPartRef GeometryPartRef
    | CoincidentSegments GeometryPartRef GeometryPartRef
    | IntersectionOutsideSegments GeometryPartRef GeometryPartRef
    | ParallelLines GeometryPartRef GeometryPartRef
    | CoincidentLines GeometryPartRef GeometryPartRef
    | ParallelSegmentAndLine GeometryPartRef GeometryPartRef
    | CoincidentSegmentAndLine GeometryPartRef GeometryPartRef
    | IntersectionOutsideSegment GeometryPartRef GeometryPartRef
    | DisjointCircles GeometryPartRef GeometryPartRef
    | ContainedCircle GeometryPartRef GeometryPartRef
    | ConcentricCircles GeometryPartRef GeometryPartRef
    | CoincidentCircles GeometryPartRef GeometryPartRef
    | SegmentDoesNotMeetCircle GeometryPartRef GeometryPartRef
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
    | LineBody
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
    | LineTool
    | CircleTool
    | MidpointTool
    | IntersectionTool


type Interaction
    = Idle
    | Hovering GeometryPartRef
    | Holding AttachmentHold
    | AttachmentNotice AttachmentNoticeState
    | Dragging DragState


type alias AttachmentHold =
    { geometryPart : GeometryPartRef
    , start : Vec2
    , initialWorld : World
    , elapsed : Float
    , action : Maybe AttachmentAction
    , committed : Bool
    }


type alias AttachmentNoticeState =
    { geometryPart : GeometryPartRef
    , outcome : AttachmentOutcome
    , elapsed : Float
    }


type AttachmentOutcome
    = Attached
    | Detached


type AttachmentAction
    = Attach PlacementCandidate
    | Detach Vec2


type alias DragState =
    { geometryPart : GeometryPartRef
    , initialWorld : World
    }



-- MODEL


type alias Model =
    { world : World
    , undoHistory : List World
    , redoHistory : List World
    , interaction : Interaction
    , activeTool : Maybe Tool
    , segmentStart : Maybe GeometryPartRef
    , segmentPreviewEnd : Maybe Vec2
    , lineStart : Maybe GeometryPartRef
    , linePreviewEnd : Maybe Vec2
    , circleCenter : Maybe GeometryPartRef
    , circlePreviewThrough : Maybe Vec2
    , intersectionStart : Maybe GeometryPartRef
    , pointerPosition : Vec2
    }



-- MESSAGES


type Msg
    = ToggleTool Tool
    | Undo
    | Redo
    | PointerMoved Vec2
    | PointerDown Vec2
    | PointerUp Vec2
    | PointerCancelled
    | AttachmentTick



-- INIT


init : ( Model, Cmd Msg )
init =
    ( { world = Ecs.emptyWorld specs.all (Ecs.Singletons1.init 0)
      , undoHistory = []
      , redoHistory = []
      , interaction = Idle
      , activeTool = Just SelectTool
      , segmentStart = Nothing
      , segmentPreviewEnd = Nothing
      , lineStart = Nothing
      , linePreviewEnd = Nothing
      , circleCenter = Nothing
      , circlePreviewThrough = Nothing
      , intersectionStart = Nothing
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
                , lineStart = Nothing
                , linePreviewEnd = Nothing
                , circleCenter = Nothing
                , circlePreviewThrough = Nothing
                , intersectionStart = Nothing
              }
            , Cmd.none
            )

        Undo ->
            ( undo model, Cmd.none )

        Redo ->
            ( redo model, Cmd.none )

        PointerDown pointer ->
            ( model
                |> (\current -> startInteraction pointer { current | pointerPosition = pointer })
                |> checkpointConstruction model.world
            , Cmd.none
            )

        PointerMoved pointer ->
            ( movePointer pointer model, Cmd.none )

        PointerUp pointer ->
            ( model
                |> (\current -> endInteraction pointer { current | pointerPosition = pointer })
                |> checkpointCompletedGesture model
            , Cmd.none
            )

        PointerCancelled ->
            ( cancelPointerGesture model, Cmd.none )

        AttachmentTick ->
            ( advanceAttachmentAnimation model, Cmd.none )


recordUndoSnapshot : World -> Model -> Model
recordUndoSnapshot previousWorld model =
    { model
        | undoHistory = previousWorld :: model.undoHistory
        , redoHistory = []
    }


checkpointConstruction : World -> Model -> Model
checkpointConstruction previousWorld model =
    if
        Ecs.getSingleton specs.nextEntityId previousWorld
            /= Ecs.getSingleton specs.nextEntityId model.world
    then
        recordUndoSnapshot previousWorld model

    else
        model


checkpointCompletedGesture : Model -> Model -> Model
checkpointCompletedGesture previousModel model =
    case previousModel.interaction of
        Dragging drag ->
            recordUndoSnapshot drag.initialWorld model

        Holding hold ->
            if hold.committed then
                recordUndoSnapshot hold.initialWorld model

            else
                model

        _ ->
            model


cancelPointerGesture : Model -> Model
cancelPointerGesture model =
    checkpointCompletedGesture model { model | interaction = Idle }


clearTransientInteraction : Model -> Model
clearTransientInteraction model =
    { model
        | interaction = Idle
        , segmentStart = Nothing
        , segmentPreviewEnd = Nothing
        , lineStart = Nothing
        , linePreviewEnd = Nothing
        , circleCenter = Nothing
        , circlePreviewThrough = Nothing
        , intersectionStart = Nothing
    }


undo : Model -> Model
undo model =
    case model.undoHistory of
        previousWorld :: remainingHistory ->
            { model
                | world = derivedComponentsSystem previousWorld
                , undoHistory = remainingHistory
                , redoHistory = model.world :: model.redoHistory
            }
                |> clearTransientInteraction

        [] ->
            model


redo : Model -> Model
redo model =
    case model.redoHistory of
        nextWorld :: remainingHistory ->
            { model
                | world = derivedComponentsSystem nextWorld
                , undoHistory = model.world :: model.undoHistory
                , redoHistory = remainingHistory
            }
                |> clearTransientInteraction

        [] ->
            model



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

        Just LineTool ->
            startLine pointer model

        Just CircleTool ->
            startCircle pointer model

        Just MidpointTool ->
            startMidpoint pointer model

        Just IntersectionTool ->
            startIntersection pointer model

        Nothing ->
            model


startSelection : Vec2 -> Model -> Model
startSelection pointer model =
    case hitTest pointer model.world of
        Just geometryPart ->
            if isDraggable geometryPart model.world then
                { model
                    | interaction = Holding (attachmentHold geometryPart pointer model.world)
                }

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


startLine : Vec2 -> Model -> Model
startLine pointer model =
    let
        ( geometryPart, world ) =
            pointAtOrCreate pointer model.world
    in
    case model.lineStart of
        Just start ->
            if start == geometryPart then
                { model
                    | world = world
                    , interaction = Hovering geometryPart
                    , linePreviewEnd = Just pointer
                }

            else
                { model
                    | world = addLine start geometryPart world
                    , interaction = Hovering geometryPart
                    , lineStart = Nothing
                    , linePreviewEnd = Nothing
                }

        Nothing ->
            { model
                | world = world
                , interaction = Hovering geometryPart
                , lineStart = Just geometryPart
                , linePreviewEnd = Just pointer
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


startIntersection : Vec2 -> Model -> Model
startIntersection pointer model =
    case intersectionSupportAt pointer model.world of
        Just support ->
            case model.intersectionStart of
                Just first ->
                    if first == support then
                        { model | interaction = Hovering support }

                    else
                        case intersectionExpression first support pointer model.world of
                            Just expression ->
                                { model
                                    | world = addIntersection expression model.world
                                    , interaction = Hovering support
                                    , intersectionStart = Nothing
                                }

                            Nothing ->
                                { model
                                    | interaction = Hovering support
                                    , intersectionStart = Just support
                                }

                Nothing ->
                    { model
                        | interaction = Hovering support
                        , intersectionStart = Just support
                    }

        Nothing ->
            { model | interaction = Idle }


movePointer : Vec2 -> Model -> Model
movePointer pointer model =
    case model.interaction of
        Holding hold ->
            if movedBeyondDragTolerance pointer hold.start then
                if hold.committed && attachmentOutcome hold == Detached then
                    { model
                        | interaction =
                            Dragging
                                { geometryPart = hold.geometryPart
                                , initialWorld = hold.initialWorld
                                }
                        , world = dragSystem hold.geometryPart pointer model.world
                        , pointerPosition = pointer
                    }

                else if hold.committed then
                    recordUndoSnapshot hold.initialWorld
                        { model
                            | interaction = interactionAt pointer model.world
                            , pointerPosition = pointer
                        }

                else
                    { model
                        | interaction =
                            Dragging
                                { geometryPart = hold.geometryPart
                                , initialWorld = hold.initialWorld
                                }
                        , world = dragSystem hold.geometryPart pointer model.world
                        , pointerPosition = pointer
                    }

            else
                { model | pointerPosition = pointer }

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

                Just LineTool ->
                    { model
                        | interaction = interactionAt pointer model.world
                        , linePreviewEnd = Just pointer
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

                Just IntersectionTool ->
                    { model
                        | interaction = intersectionInteractionAt pointer model.world
                        , pointerPosition = pointer
                    }

                _ ->
                    { model | interaction = Idle, pointerPosition = pointer }


endInteraction : Vec2 -> Model -> Model
endInteraction pointer model =
    case model.activeTool of
        Just SelectTool ->
            case model.interaction of
                Holding hold ->
                    if hold.committed then
                        { model
                            | interaction =
                                AttachmentNotice
                                    { geometryPart = hold.geometryPart
                                    , outcome = attachmentOutcome hold
                                    , elapsed = 0
                                    }
                        }

                    else
                        { model | interaction = interactionAt pointer model.world }

                _ ->
                    { model | interaction = interactionAt pointer model.world }

        Just SegmentTool ->
            { model
                | interaction = interactionAt pointer model.world
                , segmentPreviewEnd = Just pointer
            }

        Just LineTool ->
            { model
                | interaction = interactionAt pointer model.world
                , linePreviewEnd = Just pointer
            }

        Just CircleTool ->
            { model
                | interaction = interactionAt pointer model.world
                , circlePreviewThrough = Just pointer
            }

        Just MidpointTool ->
            { model | interaction = midpointInteractionAt pointer model.world }

        Just IntersectionTool ->
            { model | interaction = intersectionInteractionAt pointer model.world }

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


intersectionExpression : GeometryPartRef -> GeometryPartRef -> Vec2 -> World -> Maybe PointExpr
intersectionExpression first second pointer world =
    case ( first.kind, second.kind ) of
        ( SegmentBody, SegmentBody ) ->
            Just (SegmentIntersection first second)

        ( SegmentBody, LineBody ) ->
            Just (SegmentLineIntersection first second)

        ( SegmentBody, CircleBody ) ->
            Just
                (SegmentCircleIntersection
                    first
                    second
                    (segmentCircleIntersectionBranchAt pointer first second world)
                )

        ( CircleBody, SegmentBody ) ->
            Just
                (SegmentCircleIntersection
                    second
                    first
                    (segmentCircleIntersectionBranchAt pointer second first world)
                )

        ( LineBody, SegmentBody ) ->
            Just (SegmentLineIntersection second first)

        ( LineBody, LineBody ) ->
            Just (LineIntersection first second)

        ( CircleBody, CircleBody ) ->
            Just
                (CircleIntersection
                    first
                    second
                    (circleIntersectionBranchAt pointer first second world)
                )

        _ ->
            Nothing


addIntersection : PointExpr -> World -> World
addIntersection expression world =
    let
        entityId =
            Ecs.getSingleton specs.nextEntityId world
    in
    world
        |> Ecs.insertEntity entityId
        |> Ecs.insertComponent specs.expression (Point expression)
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


addLine : GeometryPartRef -> GeometryPartRef -> World -> World
addLine start end world =
    let
        entityId =
            Ecs.getSingleton specs.nextEntityId world
    in
    world
        |> Ecs.insertEntity entityId
        |> Ecs.insertComponent specs.expression (Line (Through start end))
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
        ( RewritePoint, PointLocation, Point expression ) ->
            Just (Point (rewritePoint geometryPart pointer world expression))

        _ ->
            Nothing


rewritePoint : GeometryPartRef -> Vec2 -> World -> PointExpr -> PointExpr
rewritePoint geometryPart pointer world expression =
    case expression of
        Literal _ ->
            Literal (freePointPosition geometryPart pointer world)

        OnSegment support parameter ->
            segmentBodyFor support world
                |> Maybe.map (\segment -> OnSegment support (segmentParameter pointer segment))
                |> Maybe.withDefault (OnSegment support parameter)

        OnCircle support angle ->
            circleBodyFor support world
                |> Maybe.andThen
                    (\circle ->
                        nearestPointOnCircle pointer circle
                            |> Maybe.map
                                (\position ->
                                    let
                                        snappedPosition =
                                            snapCircleToGuides geometryPart circle position world
                                    in
                                    OnCircle support (circleAngle circle.center snappedPosition)
                                )
                    )
                |> Maybe.withDefault (OnCircle support angle)

        Midpoint support ->
            Midpoint support

        SegmentIntersection first second ->
            SegmentIntersection first second

        SegmentLineIntersection segment line ->
            SegmentLineIntersection segment line

        SegmentCircleIntersection segment circle branch ->
            SegmentCircleIntersection segment circle branch

        LineIntersection first second ->
            LineIntersection first second

        CircleIntersection first second branch ->
            CircleIntersection first second branch


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

        Line expression ->
            evaluateLine activeResolver state expression

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


evaluateLine : Resolver -> EvaluationState -> LineExpr -> Evaluation Geometry
evaluateLine activeResolver state expression =
    case expression of
        Through startRef endRef ->
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
                    ( Result.map (GLine start) endResult, stateAfterEnd )

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


segmentIntersectionTarget : GeometryPartRef -> Geometry -> Result EvaluationError SegmentHitTarget
segmentIntersectionTarget geometryPart geometry =
    case ( geometryPart.kind, geometry ) of
        ( SegmentBody, GSegment start end ) ->
            Ok { ref = geometryPart, start = start, end = end }

        _ ->
            if hasGeometryPart geometryPart.kind geometry then
                Err (ExpectedSegmentGeometryPart geometryPart)

            else
                Err (MissingGeometryPart geometryPart)


lineIntersectionTarget : GeometryPartRef -> Geometry -> Result EvaluationError LineHitTarget
lineIntersectionTarget geometryPart geometry =
    case ( geometryPart.kind, geometry ) of
        ( LineBody, GLine start end ) ->
            Ok { ref = geometryPart, start = start, end = end }

        _ ->
            if hasGeometryPart geometryPart.kind geometry then
                Err (ExpectedLineGeometryPart geometryPart)

            else
                Err (MissingGeometryPart geometryPart)


lineIntersection : LineHitTarget -> LineHitTarget -> Result EvaluationError Vec2
lineIntersection first second =
    let
        firstDeltaX =
            Vec2.getX first.end - Vec2.getX first.start

        firstDeltaY =
            Vec2.getY first.end - Vec2.getY first.start

        secondDeltaX =
            Vec2.getX second.end - Vec2.getX second.start

        secondDeltaY =
            Vec2.getY second.end - Vec2.getY second.start

        offsetX =
            Vec2.getX second.start - Vec2.getX first.start

        offsetY =
            Vec2.getY second.start - Vec2.getY first.start

        denominator =
            crossProduct firstDeltaX firstDeltaY secondDeltaX secondDeltaY
    in
    if abs denominator <= intersectionTolerance then
        let
            colinearity =
                crossProduct offsetX offsetY firstDeltaX firstDeltaY
        in
        if abs colinearity <= intersectionTolerance then
            Err (CoincidentLines first.ref second.ref)

        else
            Err (ParallelLines first.ref second.ref)

    else
        let
            parameter =
                crossProduct offsetX offsetY secondDeltaX secondDeltaY / denominator
        in
        Ok
            (vec2
                (Vec2.getX first.start + parameter * firstDeltaX)
                (Vec2.getY first.start + parameter * firstDeltaY)
            )


segmentLineIntersection : SegmentHitTarget -> LineHitTarget -> Result EvaluationError Vec2
segmentLineIntersection segment line =
    let
        segmentDeltaX =
            Vec2.getX segment.end - Vec2.getX segment.start

        segmentDeltaY =
            Vec2.getY segment.end - Vec2.getY segment.start

        lineDeltaX =
            Vec2.getX line.end - Vec2.getX line.start

        lineDeltaY =
            Vec2.getY line.end - Vec2.getY line.start

        offsetX =
            Vec2.getX line.start - Vec2.getX segment.start

        offsetY =
            Vec2.getY line.start - Vec2.getY segment.start

        denominator =
            crossProduct segmentDeltaX segmentDeltaY lineDeltaX lineDeltaY
    in
    if abs denominator <= intersectionTolerance then
        let
            colinearity =
                crossProduct offsetX offsetY segmentDeltaX segmentDeltaY
        in
        if abs colinearity <= intersectionTolerance then
            Err (CoincidentSegmentAndLine segment.ref line.ref)

        else
            Err (ParallelSegmentAndLine segment.ref line.ref)

    else
        let
            intersectionParameter =
                crossProduct offsetX offsetY lineDeltaX lineDeltaY / denominator
        in
        if isWithinSegmentParameter intersectionParameter then
            Ok (pointOnSegment (clamp 0 1 intersectionParameter) segment.start segment.end)

        else
            Err (IntersectionOutsideSegment segment.ref line.ref)


circleIntersectionTarget : GeometryPartRef -> Geometry -> Result EvaluationError CircleHitTarget
circleIntersectionTarget geometryPart geometry =
    case ( geometryPart.kind, geometry ) of
        ( CircleBody, GCircle center through ) ->
            Ok { ref = geometryPart, center = center, through = through }

        _ ->
            if hasGeometryPart geometryPart.kind geometry then
                Err (ExpectedCircleGeometryPart geometryPart)

            else
                Err (MissingGeometryPart geometryPart)


intersectionTolerance : Float
intersectionTolerance =
    0.000001


isWithinSegmentParameter : Float -> Bool
isWithinSegmentParameter parameter =
    parameter >= -intersectionTolerance && parameter <= 1 + intersectionTolerance


crossProduct : Float -> Float -> Float -> Float -> Float
crossProduct firstX firstY secondX secondY =
    firstX * secondY - firstY * secondX


segmentIntersection : SegmentHitTarget -> SegmentHitTarget -> Result EvaluationError Vec2
segmentIntersection first second =
    let
        firstDeltaX =
            Vec2.getX first.end - Vec2.getX first.start

        firstDeltaY =
            Vec2.getY first.end - Vec2.getY first.start

        secondDeltaX =
            Vec2.getX second.end - Vec2.getX second.start

        secondDeltaY =
            Vec2.getY second.end - Vec2.getY second.start

        offsetX =
            Vec2.getX second.start - Vec2.getX first.start

        offsetY =
            Vec2.getY second.start - Vec2.getY first.start

        denominator =
            crossProduct firstDeltaX firstDeltaY secondDeltaX secondDeltaY
    in
    if abs denominator <= intersectionTolerance then
        let
            colinearity =
                crossProduct offsetX offsetY firstDeltaX firstDeltaY
        in
        if abs colinearity <= intersectionTolerance then
            Err (CoincidentSegments first.ref second.ref)

        else
            Err (ParallelSegments first.ref second.ref)

    else
        let
            firstParameter =
                crossProduct offsetX offsetY secondDeltaX secondDeltaY / denominator

            secondParameter =
                crossProduct offsetX offsetY firstDeltaX firstDeltaY / denominator
        in
        if isWithinSegmentParameter firstParameter && isWithinSegmentParameter secondParameter then
            Ok
                (pointOnSegment
                    (clamp 0 1 firstParameter)
                    first.start
                    first.end
                )

        else
            Err (IntersectionOutsideSegments first.ref second.ref)


circleIntersectionPoints : CircleHitTarget -> CircleHitTarget -> Result EvaluationError (List Vec2)
circleIntersectionPoints first second =
    let
        firstRadius =
            sqrt (Vec2.distanceSquared first.center first.through)

        secondRadius =
            sqrt (Vec2.distanceSquared second.center second.through)

        deltaX =
            Vec2.getX second.center - Vec2.getX first.center

        deltaY =
            Vec2.getY second.center - Vec2.getY first.center

        centerDistance =
            sqrt (deltaX * deltaX + deltaY * deltaY)

        radiusDifference =
            abs (firstRadius - secondRadius)
    in
    if centerDistance <= intersectionTolerance then
        if radiusDifference <= intersectionTolerance then
            Err (CoincidentCircles first.ref second.ref)

        else
            Err (ConcentricCircles first.ref second.ref)

    else if centerDistance > firstRadius + secondRadius + intersectionTolerance then
        Err (DisjointCircles first.ref second.ref)

    else if centerDistance < radiusDifference - intersectionTolerance then
        Err (ContainedCircle first.ref second.ref)

    else
        let
            distanceToChord =
                (firstRadius * firstRadius - secondRadius * secondRadius + centerDistance * centerDistance)
                    / (2 * centerDistance)

            chordHeight =
                sqrt (max 0 (firstRadius * firstRadius - distanceToChord * distanceToChord))

            chordCenter =
                vec2
                    (Vec2.getX first.center + distanceToChord * deltaX / centerDistance)
                    (Vec2.getY first.center + distanceToChord * deltaY / centerDistance)
        in
        if chordHeight <= intersectionTolerance then
            Ok [ chordCenter ]

        else
            let
                firstPoint =
                    vec2
                        (Vec2.getX chordCenter - chordHeight * deltaY / centerDistance)
                        (Vec2.getY chordCenter + chordHeight * deltaX / centerDistance)

                secondPoint =
                    vec2
                        (Vec2.getX chordCenter + chordHeight * deltaY / centerDistance)
                        (Vec2.getY chordCenter - chordHeight * deltaX / centerDistance)
            in
            Ok [ firstPoint, secondPoint ]


circleIntersectionPoint : CircleIntersectionBranch -> CircleHitTarget -> CircleHitTarget -> Result EvaluationError Vec2
circleIntersectionPoint branch first second =
    case circleIntersectionPoints first second of
        Ok (firstPoint :: remainingPoints) ->
            case branch of
                FirstCircleIntersection ->
                    Ok firstPoint

                SecondCircleIntersection ->
                    Ok (Maybe.withDefault firstPoint (List.head remainingPoints))

        Ok [] ->
            Err (DisjointCircles first.ref second.ref)

        Err error ->
            Err error


segmentCircleIntersectionPoints : SegmentHitTarget -> CircleHitTarget -> Result EvaluationError (List Vec2)
segmentCircleIntersectionPoints segment circle =
    let
        deltaX =
            Vec2.getX segment.end - Vec2.getX segment.start

        deltaY =
            Vec2.getY segment.end - Vec2.getY segment.start

        radiusSquared =
            Vec2.distanceSquared circle.center circle.through

        squaredSegmentLength =
            deltaX * deltaX + deltaY * deltaY
    in
    if squaredSegmentLength <= intersectionTolerance then
        if abs (Vec2.distanceSquared segment.start circle.center - radiusSquared) <= intersectionTolerance then
            Ok [ segment.start ]

        else
            Err (SegmentDoesNotMeetCircle segment.ref circle.ref)

    else
        let
            offsetX =
                Vec2.getX segment.start - Vec2.getX circle.center

            offsetY =
                Vec2.getY segment.start - Vec2.getY circle.center

            linearCoefficient =
                2 * (offsetX * deltaX + offsetY * deltaY)

            constant =
                offsetX * offsetX + offsetY * offsetY - radiusSquared

            discriminant =
                linearCoefficient * linearCoefficient - 4 * squaredSegmentLength * constant
        in
        if discriminant < -intersectionTolerance then
            Err (SegmentDoesNotMeetCircle segment.ref circle.ref)

        else
            let
                discriminantRoot =
                    sqrt (max 0 discriminant)

                firstParameter =
                    (-linearCoefficient - discriminantRoot) / (2 * squaredSegmentLength)

                parameters =
                    if discriminantRoot <= intersectionTolerance then
                        [ firstParameter ]
                            |> List.filter isWithinSegmentParameter

                    else
                        let
                            secondParameter =
                                (-linearCoefficient + discriminantRoot) / (2 * squaredSegmentLength)
                        in
                        [ firstParameter, secondParameter ]
                            |> List.filter isWithinSegmentParameter
            in
            case parameters of
                [] ->
                    Err (SegmentDoesNotMeetCircle segment.ref circle.ref)

                _ ->
                    Ok
                        (parameters
                            |> List.map (\parameter -> pointOnSegment (clamp 0 1 parameter) segment.start segment.end)
                        )


segmentCircleIntersectionPoint : CircleIntersectionBranch -> SegmentHitTarget -> CircleHitTarget -> Result EvaluationError Vec2
segmentCircleIntersectionPoint branch segment circle =
    case segmentCircleIntersectionPoints segment circle of
        Ok (firstPoint :: remainingPoints) ->
            case branch of
                FirstCircleIntersection ->
                    Ok firstPoint

                SecondCircleIntersection ->
                    Ok (Maybe.withDefault firstPoint (List.head remainingPoints))

        Ok [] ->
            Err (SegmentDoesNotMeetCircle segment.ref circle.ref)

        Err error ->
            Err error


onSegmentPosition : GeometryPartRef -> Float -> Geometry -> Result EvaluationError Vec2
onSegmentPosition geometryPart parameter geometry =
    case ( geometryPart.kind, geometry ) of
        ( SegmentBody, GSegment start end ) ->
            Ok (pointOnSegment (clamp 0 1 parameter) start end)

        _ ->
            geometryPartError geometryPart geometry


onCirclePosition : GeometryPartRef -> Float -> Geometry -> Result EvaluationError Vec2
onCirclePosition geometryPart angle geometry =
    case ( geometryPart.kind, geometry ) of
        ( CircleBody, GCircle center through ) ->
            Ok (pointOnCircle angle center through)

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

        GLine _ _ ->
            geometryPartKind == LineBody

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


evaluateSegmentIntersection : Resolver -> EvaluationState -> GeometryPartRef -> GeometryPartRef -> Evaluation Vec2
evaluateSegmentIntersection activeResolver state first second =
    let
        ( firstResult, stateAfterFirst ) =
            activeResolver.resolveGeometry state first.owner
    in
    case firstResult of
        Ok firstGeometry ->
            let
                ( secondResult, stateAfterSecond ) =
                    activeResolver.resolveGeometry stateAfterFirst second.owner
            in
            ( Result.map2 Tuple.pair
                (segmentIntersectionTarget first firstGeometry)
                (Result.andThen (segmentIntersectionTarget second) secondResult)
                |> Result.andThen (\( firstSegment, secondSegment ) -> segmentIntersection firstSegment secondSegment)
            , stateAfterSecond
            )

        Err error ->
            ( Err error, stateAfterFirst )


evaluateSegmentLineIntersection : Resolver -> EvaluationState -> GeometryPartRef -> GeometryPartRef -> Evaluation Vec2
evaluateSegmentLineIntersection activeResolver state segment line =
    let
        ( segmentResult, stateAfterSegment ) =
            activeResolver.resolveGeometry state segment.owner
    in
    case segmentResult of
        Ok segmentGeometry ->
            let
                ( lineResult, stateAfterLine ) =
                    activeResolver.resolveGeometry stateAfterSegment line.owner
            in
            ( Result.map2 Tuple.pair
                (segmentIntersectionTarget segment segmentGeometry)
                (Result.andThen (lineIntersectionTarget line) lineResult)
                |> Result.andThen (\( currentSegment, currentLine ) -> segmentLineIntersection currentSegment currentLine)
            , stateAfterLine
            )

        Err error ->
            ( Err error, stateAfterSegment )


evaluateSegmentCircleIntersection : Resolver -> EvaluationState -> GeometryPartRef -> GeometryPartRef -> CircleIntersectionBranch -> Evaluation Vec2
evaluateSegmentCircleIntersection activeResolver state segment circle branch =
    let
        ( segmentResult, stateAfterSegment ) =
            activeResolver.resolveGeometry state segment.owner
    in
    case segmentResult of
        Ok segmentGeometry ->
            let
                ( circleResult, stateAfterCircle ) =
                    activeResolver.resolveGeometry stateAfterSegment circle.owner
            in
            ( Result.map2 Tuple.pair
                (segmentIntersectionTarget segment segmentGeometry)
                (Result.andThen (circleIntersectionTarget circle) circleResult)
                |> Result.andThen (\( currentSegment, currentCircle ) -> segmentCircleIntersectionPoint branch currentSegment currentCircle)
            , stateAfterCircle
            )

        Err error ->
            ( Err error, stateAfterSegment )


evaluateLineIntersection : Resolver -> EvaluationState -> GeometryPartRef -> GeometryPartRef -> Evaluation Vec2
evaluateLineIntersection activeResolver state first second =
    let
        ( firstResult, stateAfterFirst ) =
            activeResolver.resolveGeometry state first.owner
    in
    case firstResult of
        Ok firstGeometry ->
            let
                ( secondResult, stateAfterSecond ) =
                    activeResolver.resolveGeometry stateAfterFirst second.owner
            in
            ( Result.map2 Tuple.pair
                (lineIntersectionTarget first firstGeometry)
                (Result.andThen (lineIntersectionTarget second) secondResult)
                |> Result.andThen (\( firstLine, secondLine ) -> lineIntersection firstLine secondLine)
            , stateAfterSecond
            )

        Err error ->
            ( Err error, stateAfterFirst )


evaluateCircleIntersection : Resolver -> EvaluationState -> GeometryPartRef -> GeometryPartRef -> CircleIntersectionBranch -> Evaluation Vec2
evaluateCircleIntersection activeResolver state first second branch =
    let
        ( firstResult, stateAfterFirst ) =
            activeResolver.resolveGeometry state first.owner
    in
    case firstResult of
        Ok firstGeometry ->
            let
                ( secondResult, stateAfterSecond ) =
                    activeResolver.resolveGeometry stateAfterFirst second.owner
            in
            ( Result.map2 Tuple.pair
                (circleIntersectionTarget first firstGeometry)
                (Result.andThen (circleIntersectionTarget second) secondResult)
                |> Result.andThen (\( firstCircle, secondCircle ) -> circleIntersectionPoint branch firstCircle secondCircle)
            , stateAfterSecond
            )

        Err error ->
            ( Err error, stateAfterFirst )


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

        SegmentIntersection first second ->
            evaluateSegmentIntersection activeResolver state first second

        SegmentLineIntersection segment line ->
            evaluateSegmentLineIntersection activeResolver state segment line

        SegmentCircleIntersection segment circle branch ->
            evaluateSegmentCircleIntersection activeResolver state segment circle branch

        LineIntersection first second ->
            evaluateLineIntersection activeResolver state first second

        CircleIntersection first second branch ->
            evaluateCircleIntersection activeResolver state first second branch

        OnSegment segment parameter ->
            let
                ( segmentResult, evaluatedState ) =
                    activeResolver.resolveGeometry state segment.owner
            in
            ( Result.andThen (onSegmentPosition segment parameter) segmentResult, evaluatedState )

        OnCircle circle angle ->
            let
                ( circleResult, evaluatedState ) =
                    activeResolver.resolveGeometry state circle.owner
            in
            ( Result.andThen (onCirclePosition circle angle) circleResult, evaluatedState )


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

        Point (SegmentIntersection _ _) ->
            Nothing

        Point (SegmentLineIntersection _ _) ->
            Nothing

        Point (SegmentCircleIntersection _ _ _) ->
            Nothing

        Point (CircleIntersection _ _ _) ->
            Nothing

        Point (LineIntersection _ _) ->
            Nothing

        Segment _ ->
            Nothing

        Line _ ->
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

        GLine _ _ ->
            []

        GCircle _ _ ->
            []


type alias SegmentHitTarget =
    { ref : GeometryPartRef
    , start : Vec2
    , end : Vec2
    }


type alias LineHitTarget =
    { ref : GeometryPartRef
    , start : Vec2
    , end : Vec2
    }


type alias CircleHitTarget =
    { ref : GeometryPartRef
    , center : Vec2
    , through : Vec2
    }


type PlacementCandidate
    = SegmentPlacement
        { support : GeometryPartRef
        , parameter : Float
        , position : Vec2
        , distanceSquared : Float
        }
    | CirclePlacement
        { support : GeometryPartRef
        , angle : Float
        , position : Vec2
        , distanceSquared : Float
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


lineBodiesIn : World -> List LineHitTarget
lineBodiesIn world =
    Ecs.EntityComponents.foldFromRight2
        specs.selectable
        specs.evaluated
        (\entityId _ evaluated accumulator ->
            case evaluated of
                Ok (GLine start end) ->
                    { ref = { owner = entityId, kind = LineBody }
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


placementCandidates : GeometryPartRef -> Vec2 -> World -> List PlacementCandidate
placementCandidates geometryPart pointer world =
    let
        segmentCandidates =
            segmentBodiesIn world
                |> List.filter (\segment -> not (segmentUsesPoint geometryPart segment world))
                |> List.filter (isWithinSegmentHitRadius pointer)
                |> List.map (segmentPlacementCandidate pointer)

        circleCandidates =
            circleBodiesIn world
                |> List.filter (\circle -> not (circleUsesPoint geometryPart circle world))
                |> List.filter (isWithinCircleHitRadius pointer)
                |> List.filterMap (circlePlacementCandidate geometryPart pointer world)
    in
    (segmentCandidates ++ circleCandidates)
        |> List.sortBy placementSortKey


nearestPlacementCandidate : GeometryPartRef -> Vec2 -> World -> Maybe PlacementCandidate
nearestPlacementCandidate geometryPart pointer world =
    placementCandidates geometryPart pointer world
        |> List.head


segmentPlacementCandidate : Vec2 -> SegmentHitTarget -> PlacementCandidate
segmentPlacementCandidate pointer segment =
    let
        parameter =
            segmentParameter pointer segment

        position =
            pointOnSegment parameter segment.start segment.end
    in
    SegmentPlacement
        { support = segment.ref
        , parameter = parameter
        , position = position
        , distanceSquared = Vec2.distanceSquared pointer position
        }


circlePlacementCandidate : GeometryPartRef -> Vec2 -> World -> CircleHitTarget -> Maybe PlacementCandidate
circlePlacementCandidate geometryPart pointer world circle =
    nearestPointOnCircle pointer circle
        |> Maybe.map
            (\position ->
                let
                    snappedPosition =
                        snapCircleToGuides geometryPart circle position world
                in
                CirclePlacement
                    { support = circle.ref
                    , angle = circleAngle circle.center snappedPosition
                    , position = snappedPosition
                    , distanceSquared = Vec2.distanceSquared pointer position
                    }
            )


placementDistanceSquared : PlacementCandidate -> Float
placementDistanceSquared placement =
    case placement of
        SegmentPlacement candidate ->
            candidate.distanceSquared

        CirclePlacement candidate ->
            candidate.distanceSquared


placementSupport : PlacementCandidate -> GeometryPartRef
placementSupport placement =
    case placement of
        SegmentPlacement candidate ->
            candidate.support

        CirclePlacement candidate ->
            candidate.support


placementSortKey : PlacementCandidate -> ( Float, EntityId, Int )
placementSortKey placement =
    let
        support =
            placementSupport placement
    in
    ( placementDistanceSquared placement
    , support.owner
    , geometryPartKindOrder support.kind
    )


geometryPartKindOrder : GeometryPartKind -> Int
geometryPartKindOrder kind =
    case kind of
        PointLocation ->
            0

        SegmentStart ->
            1

        SegmentEnd ->
            2

        SegmentBody ->
            3

        LineBody ->
            4

        CircleBody ->
            5


placementPosition : PlacementCandidate -> Vec2
placementPosition placement =
    case placement of
        SegmentPlacement candidate ->
            candidate.position

        CirclePlacement candidate ->
            candidate.position


freePointPosition : GeometryPartRef -> Vec2 -> World -> Vec2
freePointPosition geometryPart pointer world =
    nearestPlacementCandidate geometryPart pointer world
        |> Maybe.map placementPosition
        |> Maybe.withDefault (snapToGuides geometryPart pointer world)


segmentBodyFor : GeometryPartRef -> World -> Maybe SegmentHitTarget
segmentBodyFor support world =
    segmentBodiesIn world
        |> List.filter (\segment -> segment.ref == support)
        |> List.head


lineBodyFor : GeometryPartRef -> World -> Maybe LineHitTarget
lineBodyFor support world =
    lineBodiesIn world
        |> List.filter (\line -> line.ref == support)
        |> List.head


circleBodyFor : GeometryPartRef -> World -> Maybe CircleHitTarget
circleBodyFor support world =
    circleBodiesIn world
        |> List.filter (\circle -> circle.ref == support)
        |> List.head


circleIntersectionBranchAt : Vec2 -> GeometryPartRef -> GeometryPartRef -> World -> CircleIntersectionBranch
circleIntersectionBranchAt pointer first second world =
    case
        Maybe.map2 circleIntersectionPoints
            (circleBodyFor first world)
            (circleBodyFor second world)
    of
        Just (Ok (firstPoint :: secondPoint :: _)) ->
            if Vec2.distanceSquared pointer secondPoint < Vec2.distanceSquared pointer firstPoint then
                SecondCircleIntersection

            else
                FirstCircleIntersection

        _ ->
            FirstCircleIntersection


segmentCircleIntersectionBranchAt : Vec2 -> GeometryPartRef -> GeometryPartRef -> World -> CircleIntersectionBranch
segmentCircleIntersectionBranchAt pointer segment circle world =
    case
        Maybe.map2 segmentCircleIntersectionPoints
            (segmentBodyFor segment world)
            (circleBodyFor circle world)
    of
        Just (Ok (firstPoint :: secondPoint :: _)) ->
            if Vec2.distanceSquared pointer secondPoint < Vec2.distanceSquared pointer firstPoint then
                SecondCircleIntersection

            else
                FirstCircleIntersection

        _ ->
            FirstCircleIntersection


intersectionSupportAt : Vec2 -> World -> Maybe GeometryPartRef
intersectionSupportAt pointer world =
    let
        segmentCandidates =
            segmentBodiesIn world
                |> List.filter (isWithinSegmentHitRadius pointer)
                |> List.map
                    (\segment ->
                        { ref = segment.ref
                        , distanceSquared = segmentDistanceSquared pointer segment
                        }
                    )

        lineCandidates =
            lineBodiesIn world
                |> List.filter (isWithinLineHitRadius pointer)
                |> List.map
                    (\line ->
                        { ref = line.ref
                        , distanceSquared = lineDistanceSquared pointer line
                        }
                    )

        circleCandidates =
            circleBodiesIn world
                |> List.filter (isWithinCircleHitRadius pointer)
                |> List.map
                    (\circle ->
                        { ref = circle.ref
                        , distanceSquared = circleDistanceSquared pointer circle
                        }
                    )
    in
    segmentCandidates
        ++ lineCandidates
        ++ circleCandidates
        |> List.sortBy
            (\candidate ->
                ( candidate.distanceSquared
                , candidate.ref.owner
                , geometryPartKindOrder candidate.ref.kind
                )
            )
        |> List.head
        |> Maybe.map .ref


attachmentTickInterval : Float
attachmentTickInterval =
    16


attachmentPreviewDelay : Float
attachmentPreviewDelay =
    500


attachmentProgressDuration : Float
attachmentProgressDuration =
    500


attachmentNoticeDuration : Float
attachmentNoticeDuration =
    600


attachmentCompletionDelay : Float
attachmentCompletionDelay =
    attachmentPreviewDelay + attachmentProgressDuration


dragToleranceSquared : Float
dragToleranceSquared =
    64


attachmentHold : GeometryPartRef -> Vec2 -> World -> AttachmentHold
attachmentHold geometryPart start world =
    { geometryPart = geometryPart
    , start = start
    , initialWorld = world
    , elapsed = 0
    , action = attachmentAction geometryPart world
    , committed = False
    }


movedBeyondDragTolerance : Vec2 -> Vec2 -> Bool
movedBeyondDragTolerance pointer start =
    Vec2.distanceSquared pointer start > dragToleranceSquared


attachmentCandidate : GeometryPartRef -> World -> Maybe PlacementCandidate
attachmentCandidate geometryPart world =
    currentPointPosition geometryPart world
        |> Maybe.andThen
            (\position ->
                nearestPlacementCandidate geometryPart position world
            )


attachmentAction : GeometryPartRef -> World -> Maybe AttachmentAction
attachmentAction geometryPart world =
    currentPointExpression geometryPart world
        |> Maybe.andThen
            (\expression ->
                case expression of
                    Literal _ ->
                        attachmentCandidate geometryPart world
                            |> Maybe.map Attach

                    OnSegment _ _ ->
                        currentPointPosition geometryPart world
                            |> Maybe.map Detach

                    OnCircle _ _ ->
                        currentPointPosition geometryPart world
                            |> Maybe.map Detach

                    Midpoint _ ->
                        Nothing

                    SegmentIntersection _ _ ->
                        Nothing

                    SegmentLineIntersection _ _ ->
                        Nothing

                    SegmentCircleIntersection _ _ _ ->
                        Nothing

                    CircleIntersection _ _ _ ->
                        Nothing

                    LineIntersection _ _ ->
                        Nothing
            )


currentPointExpression : GeometryPartRef -> World -> Maybe PointExpr
currentPointExpression geometryPart world =
    world
        |> Ecs.onEntity geometryPart.owner
        |> Ecs.getComponent specs.expression
        |> Maybe.andThen
            (\node ->
                case node of
                    Point expression ->
                        Just expression

                    _ ->
                        Nothing
            )


isAttachedPoint : GeometryPartRef -> World -> Bool
isAttachedPoint geometryPart world =
    currentPointExpression geometryPart world
        |> Maybe.map isAttachedPointExpression
        |> Maybe.withDefault False


isAttachedPointExpression : PointExpr -> Bool
isAttachedPointExpression expression =
    case expression of
        OnSegment _ _ ->
            True

        OnCircle _ _ ->
            True

        _ ->
            False


currentPointPosition : GeometryPartRef -> World -> Maybe Vec2
currentPointPosition geometryPart world =
    geometryPartsIn world
        |> List.filter (\candidate -> candidate.ref == geometryPart)
        |> List.head
        |> Maybe.map .position


pointExpressionForPlacement : PlacementCandidate -> PointExpr
pointExpressionForPlacement placement =
    case placement of
        SegmentPlacement candidate ->
            OnSegment candidate.support candidate.parameter

        CirclePlacement candidate ->
            OnCircle candidate.support candidate.angle


pointExpressionForAttachmentAction : AttachmentAction -> PointExpr
pointExpressionForAttachmentAction action =
    case action of
        Attach placement ->
            pointExpressionForPlacement placement

        Detach position ->
            Literal position


validAttachmentAction : AttachmentAction -> GeometryPartRef -> World -> Maybe AttachmentAction
validAttachmentAction action geometryPart world =
    case ( action, attachmentAction geometryPart world ) of
        ( Attach expected, Just (Attach current) ) ->
            if placementSupport expected == placementSupport current then
                Just (Attach current)

            else
                Nothing

        ( Detach _, Just (Detach position) ) ->
            Just (Detach position)

        _ ->
            Nothing


setPointExpression : GeometryPartRef -> PointExpr -> World -> World
setPointExpression geometryPart expression world =
    world
        |> Ecs.onEntity geometryPart.owner
        |> Ecs.insertComponent specs.expression (Point expression)
        |> derivedComponentsSystem


commitAttachmentAction : GeometryPartRef -> AttachmentAction -> World -> World
commitAttachmentAction geometryPart action world =
    setPointExpression geometryPart (pointExpressionForAttachmentAction action) world


attachmentOutcome : AttachmentHold -> AttachmentOutcome
attachmentOutcome hold =
    case hold.action of
        Just (Attach _) ->
            Attached

        Just (Detach _) ->
            Detached

        Nothing ->
            Attached


attachmentPreviewVisible : AttachmentHold -> Bool
attachmentPreviewVisible hold =
    case hold.action of
        Just _ ->
            hold.committed || hold.elapsed >= attachmentPreviewDelay

        Nothing ->
            False


advanceAttachmentAnimation : Model -> Model
advanceAttachmentAnimation model =
    case model.interaction of
        Holding hold ->
            advanceAttachmentHold hold model

        AttachmentNotice notice ->
            advanceAttachmentNotice notice model

        _ ->
            model


advanceAttachmentHold : AttachmentHold -> Model -> Model
advanceAttachmentHold hold model =
    if hold.committed then
        model

    else
        let
            action =
                hold.action
                    |> Maybe.andThen
                        (\currentAction ->
                            validAttachmentAction currentAction hold.geometryPart model.world
                        )

            advancedHold =
                { hold
                    | elapsed =
                        min attachmentCompletionDelay
                            (hold.elapsed + attachmentTickInterval)
                    , action = action
                }
        in
        if advancedHold.elapsed == attachmentCompletionDelay then
            case action of
                Just currentAction ->
                    { model
                        | interaction = Holding { advancedHold | committed = True }
                        , world = commitAttachmentAction hold.geometryPart currentAction model.world
                    }

                Nothing ->
                    { model | interaction = Holding advancedHold }

        else
            { model | interaction = Holding advancedHold }


advanceAttachmentNotice : AttachmentNoticeState -> Model -> Model
advanceAttachmentNotice notice model =
    let
        elapsed =
            notice.elapsed + attachmentTickInterval
    in
    if elapsed >= attachmentNoticeDuration then
        { model | interaction = Hovering notice.geometryPart }

    else
        { model
            | interaction =
                AttachmentNotice
                    { notice | elapsed = elapsed }
        }


snapCircleToGuides : GeometryPartRef -> CircleHitTarget -> Vec2 -> World -> Vec2
snapCircleToGuides geometryPart circle position world =
    pointGeometryPartsIn world
        |> List.filter (\candidate -> candidate.ref /= geometryPart)
        |> alignmentGuides { ref = geometryPart, position = position }
        |> List.concatMap (circleGuideIntersections circle)
        |> List.sortBy (Vec2.distanceSquared position)
        |> List.head
        |> Maybe.withDefault position


circleGuideIntersections : CircleHitTarget -> Guide -> List Vec2
circleGuideIntersections circle guide =
    let
        centerX =
            Vec2.getX circle.center

        centerY =
            Vec2.getY circle.center

        radiusSquared =
            Vec2.distanceSquared circle.center circle.through

        intersections coordinate offset makePoint =
            if offset < 0 then
                []

            else
                let
                    distance =
                        sqrt offset
                in
                if distance == 0 then
                    [ makePoint coordinate ]

                else
                    [ makePoint (coordinate - distance)
                    , makePoint (coordinate + distance)
                    ]
    in
    case guide of
        HorizontalGuide y ->
            intersections
                centerX
                (radiusSquared - (y - centerY) * (y - centerY))
                (\x -> vec2 x y)

        VerticalGuide x ->
            intersections
                centerY
                (radiusSquared - (x - centerX) * (x - centerX))
                (\y -> vec2 x y)


circleUsesPoint : GeometryPartRef -> CircleHitTarget -> World -> Bool
circleUsesPoint geometryPart circle world =
    world
        |> Ecs.onEntity circle.ref.owner
        |> Ecs.getComponent specs.expression
        |> Maybe.map (nodeUsesPoint geometryPart)
        |> Maybe.withDefault False


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

        Line (Through start end) ->
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


segmentParameter : Vec2 -> SegmentHitTarget -> Float
segmentParameter pointer segment =
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
    in
    if lengthSquared == 0 then
        0

    else
        clamp 0
            1
            (((Vec2.getX pointer - startX) * deltaX + (Vec2.getY pointer - startY) * deltaY) / lengthSquared)


nearestPointOnSegment : Vec2 -> SegmentHitTarget -> Vec2
nearestPointOnSegment pointer segment =
    pointOnSegment (segmentParameter pointer segment) segment.start segment.end


pointOnSegment : Float -> Vec2 -> Vec2 -> Vec2
pointOnSegment parameter start end =
    vec2
        (Vec2.getX start + parameter * (Vec2.getX end - Vec2.getX start))
        (Vec2.getY start + parameter * (Vec2.getY end - Vec2.getY start))


segmentDistanceSquared : Vec2 -> SegmentHitTarget -> Float
segmentDistanceSquared pointer segment =
    Vec2.distanceSquared pointer (nearestPointOnSegment pointer segment)


isWithinLineHitRadius : Vec2 -> LineHitTarget -> Bool
isWithinLineHitRadius pointer line =
    lineDistanceSquared pointer line <= 196


lineDistanceSquared : Vec2 -> LineHitTarget -> Float
lineDistanceSquared pointer line =
    let
        startX =
            Vec2.getX line.start

        startY =
            Vec2.getY line.start

        deltaX =
            Vec2.getX line.end - startX

        deltaY =
            Vec2.getY line.end - startY

        lengthSquared =
            deltaX * deltaX + deltaY * deltaY
    in
    if lengthSquared == 0 then
        Vec2.distanceSquared pointer line.start

    else
        let
            parameter =
                ((Vec2.getX pointer - startX) * deltaX + (Vec2.getY pointer - startY) * deltaY) / lengthSquared
        in
        Vec2.distanceSquared pointer
            (vec2
                (startX + parameter * deltaX)
                (startY + parameter * deltaY)
            )


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


circleAngle : Vec2 -> Vec2 -> Float
circleAngle center position =
    atan2
        (Vec2.getY position - Vec2.getY center)
        (Vec2.getX position - Vec2.getX center)


pointOnCircle : Float -> Vec2 -> Vec2 -> Vec2
pointOnCircle angle center through =
    let
        radius =
            sqrt (Vec2.distanceSquared center through)
    in
    vec2
        (Vec2.getX center + radius * cos angle)
        (Vec2.getY center + radius * sin angle)


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


intersectionInteractionAt : Vec2 -> World -> Interaction
intersectionInteractionAt pointer world =
    intersectionSupportAt pointer world
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
        || model.intersectionStart
        == Just geometryPart
        || (case model.interaction of
                Idle ->
                    False

                Hovering hovered ->
                    hovered == geometryPart

                Holding hold ->
                    if attachmentPreviewVisible hold then
                        geometryPart
                            == hold.geometryPart
                            || (case hold.action of
                                    Just (Attach candidate) ->
                                        geometryPart == placementSupport candidate

                                    _ ->
                                        False
                               )

                    else
                        False

                AttachmentNotice notice ->
                    geometryPart == notice.geometryPart

                Dragging drag ->
                    drag.geometryPart == geometryPart
           )


isDependencyHighlighted : GeometryPartRef -> Model -> Bool
isDependencyHighlighted geometryPart model =
    case model.interaction of
        Hovering hovered ->
            model.world
                |> Ecs.onEntity hovered.owner
                |> Ecs.getComponent specs.expression
                |> Maybe.map (isDependentOn geometryPart)
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


isDependentOn : GeometryPartRef -> Node -> Bool
isDependentOn geometryPart node =
    case node of
        Point (Midpoint source) ->
            source == geometryPart

        Point (SegmentIntersection first second) ->
            geometryPart == first || geometryPart == second

        Point (SegmentLineIntersection segment line) ->
            geometryPart == segment || geometryPart == line

        Point (SegmentCircleIntersection segment circle _) ->
            geometryPart == segment || geometryPart == circle

        Point (LineIntersection first second) ->
            geometryPart == first || geometryPart == second

        Point (CircleIntersection first second _) ->
            geometryPart == first || geometryPart == second

        _ ->
            False


isMidpointOfPointExpression : Node -> Bool
isMidpointOfPointExpression node =
    case node of
        Point (Midpoint _) ->
            True

        _ ->
            False


isIntersectionPoint : EntityId -> World -> Bool
isIntersectionPoint entityId world =
    world
        |> Ecs.onEntity entityId
        |> Ecs.getComponent specs.expression
        |> Maybe.map isIntersectionPointExpression
        |> Maybe.withDefault False


isIntersectionPointExpression : Node -> Bool
isIntersectionPointExpression node =
    case node of
        Point (SegmentIntersection _ _) ->
            True

        Point (SegmentLineIntersection _ _) ->
            True

        Point (SegmentCircleIntersection _ _ _) ->
            True

        Point (LineIntersection _ _) ->
            True

        Point (CircleIntersection _ _ _) ->
            True

        _ ->
            False


hoveredPointPosition : (EntityId -> World -> Bool) -> Model -> Maybe Vec2
hoveredPointPosition predicate model =
    case model.interaction of
        Hovering geometryPart ->
            if predicate geometryPart.owner model.world then
                geometryPartsIn model.world
                    |> List.filter (\geometryPart_ -> geometryPart_.ref == geometryPart)
                    |> List.head
                    |> Maybe.map .position

            else
                Nothing

        _ ->
            Nothing


midpointHoverPosition : Model -> Maybe Vec2
midpointHoverPosition =
    hoveredPointPosition isMidpointPoint


intersectionHoverPosition : Model -> Maybe Vec2
intersectionHoverPosition =
    hoveredPointPosition isIntersectionPoint



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


onPointerCancel : Html.Attribute Msg
onPointerCancel =
    on "pointercancel" (Decode.succeed PointerCancelled)



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
                            , viewIntersectionHoverLabel model
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
        , style "background-color" "#111827"
        , style "color" "#cbd5e1"
        , style "border-radius" "0.5rem"
        ]
        (worldExpressionEntries world
            |> List.map worldExpressionEntryView
            |> List.intersperse (syntaxToken ", ")
        )


circleIntersectionBranchView : CircleIntersectionBranch -> Html Msg
circleIntersectionBranchView branch =
    constructorToken <|
        case branch of
            FirstCircleIntersection ->
                "first"

            SecondCircleIntersection ->
                "second"


worldExpressionEntries : World -> List ( EntityId, Node )
worldExpressionEntries world =
    world
        |> Ecs.EntityComponents.foldFromRight
            specs.expression
            (\entityId node expressions -> ( entityId, node ) :: expressions)
            []
        |> List.sortBy Tuple.first


worldExpressionEntryView : ( EntityId, Node ) -> Html Msg
worldExpressionEntryView ( entityId, node ) =
    span []
        [ entityIdToken entityId
        , syntaxToken ":"
        , nodeExpressionView node
        ]


nodeExpressionView : Node -> Html Msg
nodeExpressionView node =
    case node of
        Point pointExpression ->
            typeCall "point" [ pointExpressionView pointExpression ]

        Segment segmentExpression ->
            typeCall "segment" [ segmentExpressionView segmentExpression ]

        Line lineExpression ->
            typeCall "line" [ lineExpressionView lineExpression ]

        Circle circleExpression ->
            typeCall "circle" [ circleExpressionView circleExpression ]


pointExpressionView : PointExpr -> Html Msg
pointExpressionView expression =
    case expression of
        Literal position ->
            constructorCall "free" [ positionView position ]

        Midpoint segment ->
            constructorCall "midpoint" [ geometryPartReferenceView segment ]

        SegmentIntersection first second ->
            constructorCall "segment-intersection"
                [ geometryPartReferenceView first
                , syntaxToken ", "
                , geometryPartReferenceView second
                ]

        SegmentLineIntersection segment line ->
            constructorCall "segment-line-intersection"
                [ geometryPartReferenceView segment
                , syntaxToken ", "
                , geometryPartReferenceView line
                ]

        SegmentCircleIntersection segment circle branch ->
            constructorCall "segment-circle-intersection"
                [ geometryPartReferenceView segment
                , syntaxToken ", "
                , geometryPartReferenceView circle
                , syntaxToken ", "
                , circleIntersectionBranchView branch
                ]

        LineIntersection first second ->
            constructorCall "line-intersection"
                [ geometryPartReferenceView first
                , syntaxToken ", "
                , geometryPartReferenceView second
                ]

        CircleIntersection first second branch ->
            constructorCall "circle-intersection"
                [ geometryPartReferenceView first
                , syntaxToken ", "
                , geometryPartReferenceView second
                , syntaxToken ", "
                , circleIntersectionBranchView branch
                ]

        OnSegment segment parameter ->
            constructorCall "on-segment"
                [ geometryPartReferenceView segment
                , syntaxToken ", "
                , numberToken (decimalText parameter)
                ]

        OnCircle circle angle ->
            constructorCall "on-circle"
                [ geometryPartReferenceView circle
                , syntaxToken ", "
                , numberToken (angleText angle)
                ]


segmentExpressionView : SegmentExpr -> Html Msg
segmentExpressionView expression =
    case expression of
        Between start end ->
            constructorCall "between"
                [ geometryPartReferenceView start
                , syntaxToken ", "
                , geometryPartReferenceView end
                ]


lineExpressionView : LineExpr -> Html Msg
lineExpressionView expression =
    case expression of
        Through start end ->
            constructorCall "through"
                [ geometryPartReferenceView start
                , syntaxToken ", "
                , geometryPartReferenceView end
                ]


circleExpressionView : CircleExpr -> Html Msg
circleExpressionView expression =
    case expression of
        CenterThrough center through ->
            constructorCall "center-through"
                [ geometryPartReferenceView center
                , syntaxToken ", "
                , geometryPartReferenceView through
                ]


typeCall : String -> List (Html Msg) -> Html Msg
typeCall name arguments =
    expressionCall typeToken name arguments


constructorCall : String -> List (Html Msg) -> Html Msg
constructorCall name arguments =
    expressionCall constructorToken name arguments


expressionCall : (String -> Html Msg) -> String -> List (Html Msg) -> Html Msg
expressionCall nameView name arguments =
    span []
        (nameView name
            :: (syntaxToken "(" :: arguments ++ [ syntaxToken ")" ])
        )


positionView : Vec2 -> Html Msg
positionView position =
    span []
        [ numberToken (decimalText (Vec2.getX position))
        , syntaxToken ", "
        , numberToken (decimalText (Vec2.getY position))
        ]


geometryPartReferenceView : GeometryPartRef -> Html Msg
geometryPartReferenceView geometryPart =
    let
        suffix =
            case geometryPart.kind of
                PointLocation ->
                    ""

                SegmentStart ->
                    ".start"

                SegmentEnd ->
                    ".end"

                SegmentBody ->
                    ""

                LineBody ->
                    ""

                CircleBody ->
                    ""
    in
    span []
        [ entityIdToken geometryPart.owner
        , syntaxToken suffix
        ]


entityIdToken : EntityId -> Html Msg
entityIdToken entityId =
    coloredToken "#7dd3fc" ("#" ++ String.fromInt entityId)


typeToken : String -> Html Msg
typeToken =
    coloredToken "#c084fc"


constructorToken : String -> Html Msg
constructorToken =
    coloredToken "#00e566"


numberToken : String -> Html Msg
numberToken =
    coloredToken "#fbbf24"


syntaxToken : String -> Html Msg
syntaxToken =
    coloredToken "#94a3b8"


coloredToken : String -> String -> Html Msg
coloredToken color value =
    span [ style "color" color ] [ text value ]


angleText : Float -> String
angleText angle =
    decimalText (angle * 180 / pi) ++ "°"


decimalText : Float -> String
decimalText value =
    let
        rounded =
            toFloat (round (value * 100)) / 100
    in
    String.fromFloat
        (if rounded == 0 then
            0

         else
            rounded
        )


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
        ++ List.map viewLinePreview (linePreviews model)
        ++ List.map viewCirclePreview (circlePreviews model)
        ++ geometryLayers
        ++ attachmentPreview model
        ++ (model
                |> midpointPreview
                |> Maybe.map viewMidpointPreview
                |> Maybe.withDefault []
           )
        ++ (model
                |> intersectionPreview
                |> List.concatMap viewIntersectionPreview
           )


attachmentPreview : Model -> List (Html Msg)
attachmentPreview model =
    case model.interaction of
        Holding hold ->
            if attachmentPreviewVisible hold then
                currentPointPosition hold.geometryPart model.world
                    |> Maybe.map (\position -> [ viewAttachmentPreview position hold ])
                    |> Maybe.withDefault []

            else
                []

        AttachmentNotice notice ->
            currentPointPosition notice.geometryPart model.world
                |> Maybe.map (\position -> [ viewAttachmentNotice position notice ])
                |> Maybe.withDefault []

        _ ->
            []


attachmentProgress : AttachmentHold -> Float
attachmentProgress hold =
    if hold.committed then
        1

    else
        clamp 0
            1
            ((hold.elapsed - attachmentPreviewDelay) / attachmentProgressDuration)


animationFadeIn : Float -> Float
animationFadeIn progress =
    clamp 0 1 (progress / 0.18)


viewAttachmentPreview : Vec2 -> AttachmentHold -> Html Msg
viewAttachmentPreview position hold =
    let
        radius =
            13

        circumference =
            2 * pi * radius

        progress =
            attachmentProgress hold

        progressLength =
            circumference * progress

        color =
            if hold.committed then
                "#48c78e"

            else
                "#f5a623"
    in
    Svg.g [ opacity (String.fromFloat (animationFadeIn progress)) ]
        ([ Svg.circle
            [ cx (String.fromFloat (Vec2.getX position))
            , cy (String.fromFloat (Vec2.getY position))
            , r (String.fromFloat radius)
            , fill "none"
            , stroke color
            , strokeWidth "2"
            , strokeDasharray
                (String.fromFloat progressLength
                    ++ " "
                    ++ String.fromFloat (circumference - progressLength)
                )
            ]
            []
         , Svg.text_
            [ SvgAttr.x (String.fromFloat (Vec2.getX position + 16))
            , SvgAttr.y (String.fromFloat (Vec2.getY position - 12))
            , fill color
            , SvgAttr.fontFamily "monospace"
            , SvgAttr.fontSize "12"
            ]
            [ Svg.text
                (if hold.committed then
                    attachmentOutcomeLabel (attachmentOutcome hold)

                 else
                    attachmentActionLabel hold.action
                )
            ]
         ]
            ++ attachmentLinkPreview position progress color hold.action
        )


attachmentActionLabel : Maybe AttachmentAction -> String
attachmentActionLabel action =
    case action of
        Just (Attach _) ->
            "Attaching"

        Just (Detach _) ->
            "Detaching"

        Nothing ->
            ""


viewAttachmentNotice : Vec2 -> AttachmentNoticeState -> Html Msg
viewAttachmentNotice position notice =
    let
        opacity_ =
            animationFadeIn (notice.elapsed / 100)
                * clamp 0 1 (1 - notice.elapsed / attachmentNoticeDuration)
    in
    Svg.g [ opacity (String.fromFloat opacity_) ]
        [ Svg.circle
            [ cx (String.fromFloat (Vec2.getX position))
            , cy (String.fromFloat (Vec2.getY position))
            , r "13"
            , fill "none"
            , stroke "#48c78e"
            , strokeWidth "2"
            ]
            []
        , Svg.text_
            [ SvgAttr.x (String.fromFloat (Vec2.getX position + 16))
            , SvgAttr.y (String.fromFloat (Vec2.getY position - 12))
            , fill "#48c78e"
            , SvgAttr.fontFamily "monospace"
            , SvgAttr.fontSize "12"
            ]
            [ Svg.text (attachmentOutcomeLabel notice.outcome) ]
        ]


attachmentOutcomeLabel : AttachmentOutcome -> String
attachmentOutcomeLabel outcome =
    case outcome of
        Attached ->
            "Attached"

        Detached ->
            "Detached"


attachmentLinkPreview : Vec2 -> Float -> String -> Maybe AttachmentAction -> List (Html Msg)
attachmentLinkPreview position progress color action =
    case action of
        Just (Attach _) ->
            [ Svg.g [ opacity (String.fromFloat progress) ]
                [ Svg.circle
                    [ cx (String.fromFloat (Vec2.getX position - 4))
                    , cy (String.fromFloat (Vec2.getY position))
                    , r "3"
                    , fill "none"
                    , stroke color
                    , strokeWidth "1.5"
                    ]
                    []
                , Svg.circle
                    [ cx (String.fromFloat (Vec2.getX position + 4))
                    , cy (String.fromFloat (Vec2.getY position))
                    , r "3"
                    , fill "none"
                    , stroke color
                    , strokeWidth "1.5"
                    ]
                    []
                , Svg.line
                    [ x1 (String.fromFloat (Vec2.getX position - 1))
                    , y1 (String.fromFloat (Vec2.getY position))
                    , x2 (String.fromFloat (Vec2.getX position + 1))
                    , y2 (String.fromFloat (Vec2.getY position))
                    , stroke color
                    , strokeWidth "1.5"
                    ]
                    []
                ]
            ]

        _ ->
            []


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
    midpointHoverPosition model
        |> Maybe.map (viewConstructedPointHoverLabel "Midpoint of segment")
        |> Maybe.withDefault (Svg.g [] [])


viewIntersectionHoverLabel : Model -> Html Msg
viewIntersectionHoverLabel model =
    intersectionHoverPosition model
        |> Maybe.map (viewConstructedPointHoverLabel "Intersection")
        |> Maybe.withDefault (Svg.g [] [])


viewConstructedPointHoverLabel : String -> Vec2 -> Html Msg
viewConstructedPointHoverLabel label position =
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
        [ Svg.text label ]


geometryToolbar : Model -> Html Msg
geometryToolbar model =
    div [ class "buttons has-addons mb-4", Html.Attributes.attribute "role" "toolbar" ]
        [ toolButton model SelectTool "fa fa-mouse-pointer" "Select & move" "Select and move existing points"
        , toolButton model PointTool "fa fa-crosshairs" "Add points" "Enable or disable point construction"
        , toolButton model SegmentTool "fa fa-minus" "Add segments" "Enable or disable segment construction"
        , toolButton model LineTool "fa fa-arrows-h" "Add lines" "Construct an infinite line through two points"
        , toolButton model CircleTool "fa fa-circle-o" "Add circles" "Construct a circle from a center and a passing point"
        , toolButton model MidpointTool "fa fa-circle-o" "Midpoint" "Construct a point at the middle of a segment"
        , toolButton model IntersectionTool "fa fa-times" "Intersection" "Construct a point where two compatible curves intersect"
        , undoButton model
        , redoButton model
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


undoButton : Model -> Html Msg
undoButton model =
    button
        [ class "button is-light"
        , type_ "button"
        , title "Undo the last completed construction or manipulation"
        , disabled (List.isEmpty model.undoHistory)
        , onClick Undo
        ]
        [ span [ class "icon is-small" ] [ i [ class "fa fa-undo" ] [] ]
        , span [] [ text "Undo" ]
        ]


redoButton : Model -> Html Msg
redoButton model =
    button
        [ class "button is-light"
        , type_ "button"
        , title "Redo the last undone construction or manipulation"
        , disabled (List.isEmpty model.redoHistory)
        , onClick Redo
        ]
        [ span [ class "icon is-small" ] [ i [ class "fa fa-repeat" ] [] ]
        , span [] [ text "Redo" ]
        ]


svgInteractionAttributes : Model -> List (Svg.Attribute Msg)
svgInteractionAttributes model =
    [ cursor (cursorFor model)
    , style "touch-action" "none"
    , onPointerDown
    , onPointerMove
    , onPointerUp
    , onPointerCancel
    ]


cursorFor : Model -> String
cursorFor model =
    case model.interaction of
        Dragging _ ->
            "grabbing"

        Holding _ ->
            "grab"

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

                Just LineTool ->
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

                Just IntersectionTool ->
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


linePreviews : Model -> List ( Vec2, Vec2 )
linePreviews model =
    case ( model.lineStart, model.linePreviewEnd ) of
        ( Just startRef, Just end ) ->
            geometryPartsIn model.world
                |> List.filter (\geometryPart -> geometryPart.ref == startRef)
                |> List.head
                |> Maybe.map (\start -> [ ( start.position, end ) ])
                |> Maybe.withDefault []

        _ ->
            []


lineViewportEndpoints : Vec2 -> Vec2 -> Maybe ( Vec2, Vec2 )
lineViewportEndpoints start end =
    let
        startX =
            Vec2.getX start

        startY =
            Vec2.getY start

        deltaX =
            Vec2.getX end - startX

        deltaY =
            Vec2.getY end - startY

        verticalCandidate x =
            if abs deltaX <= intersectionTolerance then
                []

            else
                let
                    y =
                        startY + (x - startX) * deltaY / deltaX
                in
                if y >= 0 && y <= canvasHeight then
                    [ vec2 x y ]

                else
                    []

        horizontalCandidate y =
            if abs deltaY <= intersectionTolerance then
                []

            else
                let
                    x =
                        startX + (y - startY) * deltaX / deltaY
                in
                if x >= 0 && x <= canvasWidth then
                    [ vec2 x y ]

                else
                    []

        candidates =
            verticalCandidate 0
                ++ verticalCandidate canvasWidth
                ++ horizontalCandidate 0
                ++ horizontalCandidate canvasHeight
    in
    case candidates of
        first :: remaining ->
            let
                second =
                    List.foldl
                        (\candidate farthest ->
                            if Vec2.distanceSquared first candidate > Vec2.distanceSquared first farthest then
                                candidate

                            else
                                farthest
                        )
                        first
                        remaining
            in
            if Vec2.distanceSquared first second <= intersectionTolerance then
                Nothing

            else
                Just ( first, second )

        [] ->
            Nothing


viewLinePreview : ( Vec2, Vec2 ) -> Html Msg
viewLinePreview ( start, end ) =
    lineViewportEndpoints start end
        |> Maybe.map
            (\( first, second ) ->
                Svg.line
                    [ x1 (String.fromFloat (Vec2.getX first))
                    , y1 (String.fromFloat (Vec2.getY first))
                    , x2 (String.fromFloat (Vec2.getX second))
                    , y2 (String.fromFloat (Vec2.getY second))
                    , stroke "#f5a623"
                    , strokeWidth "2"
                    , strokeDasharray "6 4"
                    , opacity "0.8"
                    ]
                    []
            )
        |> Maybe.withDefault (Svg.g [] [])


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


intersectionPreview : Model -> List ( Vec2, Bool )
intersectionPreview model =
    case ( model.activeTool, model.intersectionStart, model.interaction ) of
        ( Just IntersectionTool, Just first, Hovering second ) ->
            if first == second then
                []

            else
                case ( first.kind, second.kind ) of
                    ( SegmentBody, SegmentBody ) ->
                        Maybe.map2 segmentIntersection
                            (segmentBodyFor first model.world)
                            (segmentBodyFor second model.world)
                            |> Maybe.andThen Result.toMaybe
                            |> Maybe.map (\point -> [ ( point, True ) ])
                            |> Maybe.withDefault []

                    ( SegmentBody, LineBody ) ->
                        Maybe.map2 segmentLineIntersection
                            (segmentBodyFor first model.world)
                            (lineBodyFor second model.world)
                            |> Maybe.andThen Result.toMaybe
                            |> Maybe.map (\point -> [ ( point, True ) ])
                            |> Maybe.withDefault []

                    ( LineBody, SegmentBody ) ->
                        Maybe.map2 segmentLineIntersection
                            (segmentBodyFor second model.world)
                            (lineBodyFor first model.world)
                            |> Maybe.andThen Result.toMaybe
                            |> Maybe.map (\point -> [ ( point, True ) ])
                            |> Maybe.withDefault []

                    ( SegmentBody, CircleBody ) ->
                        Maybe.map2 segmentCircleIntersectionPoints
                            (segmentBodyFor first model.world)
                            (circleBodyFor second model.world)
                            |> Maybe.andThen Result.toMaybe
                            |> Maybe.map
                                (circleIntersectionPreviewPoints
                                    (segmentCircleIntersectionBranchAt
                                        model.pointerPosition
                                        first
                                        second
                                        model.world
                                    )
                                )
                            |> Maybe.withDefault []

                    ( CircleBody, SegmentBody ) ->
                        Maybe.map2 segmentCircleIntersectionPoints
                            (segmentBodyFor second model.world)
                            (circleBodyFor first model.world)
                            |> Maybe.andThen Result.toMaybe
                            |> Maybe.map
                                (circleIntersectionPreviewPoints
                                    (segmentCircleIntersectionBranchAt
                                        model.pointerPosition
                                        second
                                        first
                                        model.world
                                    )
                                )
                            |> Maybe.withDefault []

                    ( LineBody, LineBody ) ->
                        Maybe.map2 lineIntersection
                            (lineBodyFor first model.world)
                            (lineBodyFor second model.world)
                            |> Maybe.andThen Result.toMaybe
                            |> Maybe.map (\point -> [ ( point, True ) ])
                            |> Maybe.withDefault []

                    ( CircleBody, CircleBody ) ->
                        Maybe.map2 circleIntersectionPoints
                            (circleBodyFor first model.world)
                            (circleBodyFor second model.world)
                            |> Maybe.andThen Result.toMaybe
                            |> Maybe.map
                                (circleIntersectionPreviewPoints
                                    (circleIntersectionBranchAt
                                        model.pointerPosition
                                        first
                                        second
                                        model.world
                                    )
                                )
                            |> Maybe.withDefault []

                    _ ->
                        []

        _ ->
            []


circleIntersectionPreviewPoints : CircleIntersectionBranch -> List Vec2 -> List ( Vec2, Bool )
circleIntersectionPreviewPoints branch points =
    case points of
        firstPoint :: secondPoint :: _ ->
            [ ( firstPoint, branch == FirstCircleIntersection )
            , ( secondPoint, branch == SecondCircleIntersection )
            ]

        firstPoint :: [] ->
            [ ( firstPoint, True ) ]

        [] ->
            []


viewIntersectionPreview : ( Vec2, Bool ) -> List (Html Msg)
viewIntersectionPreview ( point, selected ) =
    let
        color =
            if selected then
                "#f5a623"

            else
                "#94a3b8"

        opacity_ =
            if selected then
                "0.9"

            else
                "0.55"
    in
    [ Svg.circle
        [ cx (String.fromFloat (Vec2.getX point))
        , cy (String.fromFloat (Vec2.getY point))
        , r "7"
        , fill "none"
        , stroke color
        , strokeWidth "2"
        , strokeDasharray "3 2"
        , opacity opacity_
        ]
        []
    , Svg.line
        [ x1 (String.fromFloat (Vec2.getX point - 3))
        , y1 (String.fromFloat (Vec2.getY point))
        , x2 (String.fromFloat (Vec2.getX point + 3))
        , y2 (String.fromFloat (Vec2.getY point))
        , stroke color
        , strokeWidth "1.5"
        ]
        []
    , Svg.line
        [ x1 (String.fromFloat (Vec2.getX point))
        , y1 (String.fromFloat (Vec2.getY point - 3))
        , x2 (String.fromFloat (Vec2.getX point))
        , y2 (String.fromFloat (Vec2.getY point + 3))
        , stroke color
        , strokeWidth "1.5"
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

        ExpectedSegmentGeometryPart geometryPart ->
            "Expected segment geometry part " ++ geometryPartRefDescription geometryPart

        ExpectedCircleGeometryPart geometryPart ->
            "Expected circle geometry part " ++ geometryPartRefDescription geometryPart

        ExpectedLineGeometryPart geometryPart ->
            "Expected line geometry part " ++ geometryPartRefDescription geometryPart

        ParallelLines first second ->
            "Parallel lines " ++ geometryPartPairDescription first second

        CoincidentLines first second ->
            "Coincident lines " ++ geometryPartPairDescription first second

        ParallelSegmentAndLine segment line ->
            "Parallel segment and line " ++ geometryPartPairDescription segment line

        CoincidentSegmentAndLine segment line ->
            "Coincident segment and line " ++ geometryPartPairDescription segment line

        IntersectionOutsideSegment segment line ->
            "Line meets outside segment " ++ geometryPartPairDescription segment line

        SegmentDoesNotMeetCircle segment circle ->
            "Segment does not meet circle " ++ geometryPartPairDescription segment circle

        ParallelSegments first second ->
            "Parallel segments " ++ geometryPartPairDescription first second

        CoincidentSegments first second ->
            "Coincident segments " ++ geometryPartPairDescription first second

        IntersectionOutsideSegments first second ->
            "Intersection lies outside segments " ++ geometryPartPairDescription first second

        DisjointCircles first second ->
            "Disjoint circles " ++ geometryPartPairDescription first second

        ContainedCircle first second ->
            "One circle lies inside the other " ++ geometryPartPairDescription first second

        ConcentricCircles first second ->
            "Concentric circles " ++ geometryPartPairDescription first second

        CoincidentCircles first second ->
            "Coincident circles " ++ geometryPartPairDescription first second

        CyclicGeometryReference entityIds ->
            "Cyclic geometry reference "
                ++ (entityIds
                        |> List.map String.fromInt
                        |> String.join " -> "
                   )


geometryPartPairDescription : GeometryPartRef -> GeometryPartRef -> String
geometryPartPairDescription first second =
    geometryPartRefDescription first ++ " and " ++ geometryPartRefDescription second


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

        LineBody ->
            "LineBody"

        CircleBody ->
            "CircleBody"


pointConstructionDetails : Bool -> Bool -> Vec2 -> List (Html Msg)
pointConstructionDetails isMidpoint isIntersection point =
    if isMidpoint then
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

    else if isIntersection then
        [ Svg.title [] [ Svg.text "Intersection" ]
        , Svg.line
            [ x1 (String.fromFloat (Vec2.getX point - 3))
            , y1 (String.fromFloat (Vec2.getY point))
            , x2 (String.fromFloat (Vec2.getX point + 3))
            , y2 (String.fromFloat (Vec2.getY point))
            , stroke "#f5a623"
            , strokeWidth "1.5"
            ]
            []
        , Svg.line
            [ x1 (String.fromFloat (Vec2.getX point))
            , y1 (String.fromFloat (Vec2.getY point - 3))
            , x2 (String.fromFloat (Vec2.getX point))
            , y2 (String.fromFloat (Vec2.getY point + 3))
            , stroke "#f5a623"
            , strokeWidth "1.5"
            ]
            []
        ]

    else
        []


viewGeometry : Model -> EntityId -> Geometry -> Html Msg
viewGeometry model entityId geometry =
    case geometry of
        GPoint point ->
            let
                geometryPart =
                    { owner = entityId, kind = PointLocation }

                isMidpoint =
                    isMidpointPoint entityId model.world

                isIntersection =
                    isIntersectionPoint entityId model.world
            in
            Svg.g []
                (Svg.circle
                    [ cx (String.fromFloat (Vec2.getX point))
                    , cy (String.fromFloat (Vec2.getY point))
                    , r "7"
                    , fill
                        (if isAttachedPoint geometryPart model.world then
                            "#48c78e"

                         else if isHighlighted geometryPart model then
                            "#f5a623"

                         else
                            "#3273dc"
                        )
                    , stroke "#1f2933"
                    , strokeWidth "2"
                    ]
                    []
                    :: pointConstructionDetails isMidpoint isIntersection point
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

        GLine start end ->
            lineViewportEndpoints start end
                |> Maybe.map
                    (\( first, second ) ->
                        let
                            geometryPart =
                                { owner = entityId, kind = LineBody }

                            strokeColor =
                                if isHighlighted geometryPart model then
                                    "#f5a623"

                                else if isDependencyHighlighted geometryPart model then
                                    "#cbd5e1"

                                else
                                    "#64748b"

                            lineWidth =
                                if isHighlighted geometryPart model then
                                    "4"

                                else if isDependencyHighlighted geometryPart model then
                                    "3"

                                else
                                    "2"
                        in
                        Svg.line
                            [ x1 (String.fromFloat (Vec2.getX first))
                            , y1 (String.fromFloat (Vec2.getY first))
                            , x2 (String.fromFloat (Vec2.getX second))
                            , y2 (String.fromFloat (Vec2.getY second))
                            , stroke strokeColor
                            , strokeWidth lineWidth
                            ]
                            []
                    )
                |> Maybe.withDefault (Svg.g [] [])

        GCircle center through ->
            let
                geometryPart =
                    { owner = entityId, kind = CircleBody }
            in
            Svg.circle
                [ cx (String.fromFloat (Vec2.getX center))
                , cy (String.fromFloat (Vec2.getY center))
                , r (String.fromFloat (sqrt (Vec2.distanceSquared center through)))
                , fill "none"
                , stroke
                    (if isHighlighted geometryPart model then
                        "#f5a623"

                     else
                        "#94a3b8"
                    )
                , strokeWidth
                    (if isHighlighted geometryPart model then
                        "4"

                     else
                        "2"
                    )
                ]
                []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.interaction of
        Holding hold ->
            case hold.action of
                Just _ ->
                    Time.every attachmentTickInterval (\_ -> AttachmentTick)

                Nothing ->
                    Sub.none

        AttachmentNotice _ ->
            Time.every attachmentTickInterval (\_ -> AttachmentTick)

        _ ->
            Sub.none
