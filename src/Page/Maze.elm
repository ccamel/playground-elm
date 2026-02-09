module Page.Maze exposing (Model, Msg, info, init, subscriptions, update, view)

import Array exposing (Array, get, set)
import Basics.Extra exposing (flip)
import File.Download as Download
import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Decimals(..), Locale, usLocale)
import Html exposing (Html, button, div, i, label, option, p, section, select, span, text)
import Html.Attributes exposing (attribute, class, classList, disabled, selected, title, type_, value)
import Html.Events exposing (onClick, onInput)
import Json.Encode exposing (Value, encode, int, list, object, string)
import Lib.Page
import List exposing (map, range, repeat)
import List.Extra exposing (last, splitAt)
import Markdown
import Maybe exposing (withDefault)
import Random exposing (Seed, initialSeed, step)
import Random.List exposing (shuffle)
import String exposing (fromInt, padLeft)
import String.Interpolate exposing (interpolate)
import Task
import Time exposing (Posix, every, posixToMillis)



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "maze"
    , hash = "maze"
    , date = "2020-12-19"
    , description = Markdown.toHtml [ class "content" ] """

A maze generator using a [recursive backtracking](https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker) algorithm.
       """
    , srcRel = "Page/Maze.elm"
    }



-- MODEL


type Side
    = Left
    | Up
    | Right
    | Down


type alias Sides =
    List Side


sides : Sides
sides =
    [ Left, Up, Right, Down ]


type alias Cells =
    Array (Array Sides)


type alias VisitedCell =
    { x : Int
    , y : Int
    , dirs : Sides --remaining sides to visit
    }


type alias InitializingCtx =
    { visitedCell : List VisitedCell
    , steps : Int -- number of steps performed so far (used to compute completeness)
    , seed : Seed -- for random
    }


type MazeState
    = Created
    | Initializing InitializingCtx
    | Ready


type alias Maze =
    { width : Int
    , height : Int
    , cells : Cells
    , state : MazeState
    }


type alias ModelRecord =
    { maze : Maze
    , auto : Bool
    , memento : List Maze
    }


type Model
    = Model ModelRecord


init : ( Model, Cmd Msg )
init =
    ( Model <| initialModelWithMazeSize 20 15
    , Cmd.none
    )


initialModel : ModelRecord
initialModel =
    initialModelWithMazeSize 20 15


initialModelWithMazeSize : Int -> Int -> ModelRecord
initialModelWithMazeSize w h =
    { maze = emptyMaze w h
    , auto = False
    , memento = []
    }


initialInitializingContext : Posix -> InitializingCtx
initialInitializingContext time =
    let
        -- generate random sides
        ( shuffled, seed ) =
            step (shuffle sides) (initialSeed (posixToMillis time))
    in
    { visitedCell = [ { x = 0, y = 0, dirs = shuffled } ]
    , seed = seed
    , steps = 0
    }


cellAt : Int -> Int -> Maze -> Maybe Sides
cellAt x y maze =
    let
        col =
            get x maze.cells
    in
    col
        |> Maybe.andThen (get y)


cellSet : Int -> Int -> List Side -> Maze -> Maze
cellSet x y v maze =
    let
        cells =
            maze.cells

        col =
            get x cells
    in
    case col of
        Just c ->
            { maze | cells = set x (set y v c) cells }

        Nothing ->
            maze


emptyMaze : Int -> Int -> Maze
emptyMaze width height =
    { width = width
    , height = height
    , cells = Array.repeat width (Array.repeat height [])
    , state = Created
    }


maxDimensionsMaze : { minW : Int, maxW : Int, minH : Int, maxH : Int }
maxDimensionsMaze =
    { minW = 1, maxW = 50, minH = 1, maxH = 50 }


{-| performs one step in the generation of the maze according to the current building context.
Algorithm is a depth-first search algorithm (with backtracking)
-}
stepMaze : Maze -> Maze
stepMaze maze =
    case maze.state of
        Initializing ctx ->
            case ctx.visitedCell of
                visit :: ovisits ->
                    case visit.dirs of
                        dir :: odirs ->
                            let
                                between v upper =
                                    (v >= 0) && (v < upper)

                                ( cx, cy ) =
                                    ( visit.x, visit.y )

                                ( dx, dy ) =
                                    deltaSide dir

                                ( nx, ny ) =
                                    ( cx + dx, cy + dy )

                                cellN =
                                    cellAt nx ny maze |> Maybe.withDefault []

                                visited =
                                    { visit | dirs = odirs } :: ovisits
                            in
                            if
                                between nx maze.width
                                    && between ny maze.height
                                    && (cellN |> List.isEmpty)
                            then
                                let
                                    -- update maze with new path
                                    cellC =
                                        cellAt cx cy maze |> Maybe.withDefault []

                                    newMaze =
                                        maze
                                            |> cellSet cx cy (dir :: cellC)
                                            |> cellSet nx ny (oppositeSide dir :: cellN)

                                    -- add the new cell to the list of visited cells
                                    ( shuffled, seed ) =
                                        step (shuffle sides) ctx.seed

                                    nVisited =
                                        { x = nx, y = ny, dirs = shuffled } :: visited
                                in
                                { newMaze
                                    | state =
                                        Initializing
                                            { ctx
                                                | visitedCell = nVisited
                                                , steps = ctx.steps + 1
                                                , seed = seed
                                            }
                                }

                            else
                                { maze
                                    | state =
                                        Initializing
                                            { ctx
                                                | visitedCell = visited
                                                , steps = ctx.steps + 1
                                            }
                                }

                        [] ->
                            { maze
                                | state =
                                    Initializing
                                        { ctx
                                            | visitedCell = ovisits
                                            , steps = ctx.steps + 1
                                        }
                            }

                [] ->
                    { maze | state = Ready }

        _ ->
            maze


deltaSide : Side -> ( Int, Int )
deltaSide side =
    case side of
        Up ->
            ( 0, -1 )

        Right ->
            ( 1, 0 )

        Down ->
            ( 0, 1 )

        Left ->
            ( -1, 0 )


oppositeSide : Side -> Side
oppositeSide side =
    case side of
        Up ->
            Down

        Right ->
            Left

        Down ->
            Up

        Left ->
            Right


nameSide : Side -> String
nameSide side =
    case side of
        Up ->
            "up"

        Right ->
            "right"

        Down ->
            "down"

        Left ->
            "left"



-- UPDATE


type Msg
    = Tick Posix
    | StartAutoGeneration
    | StopAutoGeneration
    | Steps Int -- number of steps (relative)
    | Reset
    | SetDimension ( Int, Int )
    | Download


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    Tuple.mapFirst Model <|
        case msg of
            Tick time ->
                let
                    maze =
                        model.maze

                    newModel =
                        case maze.state of
                            Created ->
                                -- going to initializing state
                                { model | maze = { maze | state = Initializing <| initialInitializingContext time } }

                            Initializing _ ->
                                { model | maze = stepMaze model.maze }

                            Ready ->
                                { model | auto = False }
                in
                if newModel.maze /= model.maze then
                    ( { newModel | memento = maze :: newModel.memento }, Cmd.none )

                else
                    ( newModel, Cmd.none )

            StartAutoGeneration ->
                ( { model | auto = True }, Cmd.none )

            StopAutoGeneration ->
                ( { model | auto = False }, Cmd.none )

            Steps n ->
                if n > 0 then
                    let
                        -- produce n commands, each one sending a tick on "time.now"
                        cmd =
                            Task.perform Tick Time.now
                                |> repeat n
                                |> Cmd.batch
                    in
                    ( model, cmd )

                else
                    -- restore state from memento
                    let
                        ( first, second ) =
                            splitAt (-1 * n) model.memento
                    in
                    ( { model
                        | maze = last first |> withDefault initialModel.maze
                        , memento = second
                      }
                    , Cmd.none
                    )

            Reset ->
                ( initialModelWithMazeSize model.maze.width model.maze.height, Cmd.none )

            SetDimension ( w, h ) ->
                let
                    width =
                        w |> min maxDimensionsMaze.maxW |> max maxDimensionsMaze.minW

                    height =
                        h |> min maxDimensionsMaze.maxH |> max maxDimensionsMaze.minH
                in
                ( initialModelWithMazeSize width height, Cmd.none )

            Download ->
                ( model, Download.string "maze.json" "text/csv" (model.maze |> asJsonValue |> encode 4) )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions (Model { auto }) =
    if auto then
        every 15 Tick

    else
        Sub.none



-- VIEW


view : Model -> Html Msg
view (Model model) =
    section [ class "section pt-1 has-background-black-bis" ]
        [ div [ class "columns" ]
            [ div [ class "column is-8 is-offset-2" ]
                [ div [ class "content is-medium" ]
                    [ p []
                        [ text "You can control the generation process with the control buttons below." ]
                    ]
                ]
            ]
        , div [ class "block" ]
            [ controlView model ]
        , div [ class "block" ]
            [ mazeView model.maze ]
        ]


mazeView : Maze -> Html Msg
mazeView maze =
    div [ class "container" ]
        [ div [ class "columns is-centered" ]
            [ div [ class "columns is-narrow" ]
                [ div [ class "maze" ]
                    (rowsView maze)
                ]
            ]
        ]


rowsView : Maze -> List (Html Msg)
rowsView maze =
    range 0 (maze.height - 1)
        |> List.map
            (\y ->
                div [ class "maze-row", attribute "y" (fromInt y) ]
                    (cellView maze y)
            )


controlView : ModelRecord -> Html Msg
controlView model =
    div []
        [ div [ class "buttons has-addons is-centered are-small" ]
            [ button
                [ class "button is-danger"
                , type_ "button"
                , title "reset the maze"
                , onClick Reset
                ]
                [ span [ class "icon is-small" ] [ i [ class "fa fa-repeat" ] [] ] ]
            , button
                [ class "button"
                , disabled (model.auto || List.isEmpty model.memento)
                , type_ "button"
                , title "make 5 steps backward"
                , onClick (Steps -5)
                ]
                [ span [ class "icon is-small" ] [ i [ class "fa fa-fast-backward" ] [] ] ]
            , button
                [ class "button"
                , disabled (model.auto || List.isEmpty model.memento)
                , type_ "button"
                , title "make one step backward"
                , onClick (Steps -1)
                ]
                [ span [ class "icon is-small" ] [ i [ class "fa fa-step-backward" ] [] ] ]
            , button
                [ class "button is-success"
                , disabled (model.auto || (model.maze.state == Ready))
                , type_ "button"
                , title "generate the maze"
                , onClick StartAutoGeneration
                ]
                [ span [ class "icon is-small" ] [ i [ class "fa fa-play" ] [] ] ]
            , button
                [ class "button"
                , disabled (not model.auto || (model.maze.state == Ready))
                , type_ "button"
                , title "stop the generation"
                , onClick StopAutoGeneration
                ]
                [ span [ class "icon is-small" ] [ i [ class "fa fa-pause" ] [] ] ]
            , button
                [ class "button"
                , disabled (model.auto || (model.maze.state == Ready))
                , type_ "button"
                , title "make one step"
                , onClick (Steps 1)
                ]
                [ span [ class "icon is-small" ] [ i [ class "fa fa-step-forward" ] [] ] ]
            , button
                [ class "button"
                , disabled (model.auto || (model.maze.state == Ready))
                , type_ "button"
                , title "make one step"
                , onClick (Steps 5)
                ]
                [ span [ class "icon is-small" ] [ i [ class "fa fa-fast-forward" ] [] ] ]
            , button
                [ class "button is-info ml-4"
                , type_ "button"
                , title "export the maze state to JSON"
                , onClick Download
                ]
                [ span [ class "icon is-small" ] [ i [ class "fa fa-download" ] [] ] ]
            , div [ class "select is-info is-small ml-4" ]
                [ let
                    defaultSize =
                        ( 20, 15 )

                    sizes =
                        Array.fromList [ defaultSize, ( 40, 1 ), ( 3, 20 ), ( 5, 5 ), ( 15, 15 ), ( 50, 50 ) ]
                  in
                  select
                    [ onInput
                        (String.toInt
                            >> Maybe.andThen (flip Array.get sizes)
                            >> Maybe.withDefault defaultSize
                            >> SetDimension
                        )
                    ]
                    (sizes
                        |> Array.indexedMap
                            (\i ( w, h ) ->
                                option
                                    [ selected (( w, h ) == ( model.maze.width, model.maze.height ))
                                    , value <| fromInt i
                                    ]
                                    [ text <| fromInt w ++ " x " ++ fromInt h ]
                            )
                        |> Array.toList
                    )
                ]
            ]
        , progressView model
        ]


progressView : ModelRecord -> Html Msg
progressView model =
    let
        progressValue =
            progressString model.maze

        progressText =
            progressValue ++ "%"

        progressLabel =
            interpolate "{0}/{1}"
                [ currentSteps model.maze |> fromInt |> padLeft 5 ' '
                , totalSteps model.maze |> fromInt |> padLeft 5 ' '
                ]
    in
    div [ class "columns" ]
        [ div [ class "column is-4 is-offset-4" ]
            [ div
                [ class "field is-horizontal"
                ]
                [ div [ class "field-label is-normal" ]
                    [ label
                        [ class "label"
                        ]
                        [ text progressLabel ]
                    ]
                , div [ class "field-body" ]
                    [ div [ class "field" ]
                        [ div [ class "control" ]
                            [ Html.progress [ class "progress is-link is-small mt-3", value progressValue, Html.Attributes.max "100" ] [ text progressText ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


{-| tells if the cell at given position is currently being explored (i.e. is a new discovered cell)
-}
isExploring : Int -> Int -> Maze -> Bool
isExploring x y maze =
    case maze.state of
        Created ->
            False

        Initializing ctx ->
            case ctx.visitedCell of
                head :: _ ->
                    (head.x == x)
                        && (head.y == y)
                        && (List.length head.dirs == List.length sides)

                _ ->
                    False

        Ready ->
            False


exploredCell : Maze -> Maybe VisitedCell
exploredCell maze =
    case maze.state of
        Created ->
            Nothing

        Initializing ctx ->
            case ctx.visitedCell of
                head :: _ ->
                    Just head

                _ ->
                    Nothing

        Ready ->
            Nothing


{-| return the explored side if any
-}
exploredSide : Int -> Int -> Maze -> Maybe Side
exploredSide x y maze =
    exploredCell maze
        |> Maybe.andThen
            (\cell ->
                if (cell.x == x) && (cell.y == y) then
                    case cell.dirs of
                        side :: _ ->
                            Just side

                        _ ->
                            Nothing

                else
                    Nothing
            )


isBacktracked : Int -> Int -> Maze -> Bool
isBacktracked x y maze =
    case maze.state of
        Created ->
            False

        Initializing ctx ->
            case ctx.visitedCell of
                head :: _ ->
                    (head.x == x)
                        && (head.y == y)
                        && (List.length head.dirs /= List.length sides)

                _ ->
                    False

        Ready ->
            False


{-| tells if the cell at given position is a wall, i.e. there's no path to it
-}
isWall : Int -> Int -> Maze -> Bool
isWall x y maze =
    maze
        |> cellAt x y
        |> Maybe.map List.length
        |> Maybe.withDefault 0
        |> (==) 0


isEntrance : Int -> Int -> Bool
isEntrance x y =
    (x == 0) && (y == 0)


isExit : Int -> Int -> Maze -> Bool
isExit x y maze =
    (x == maze.width - 1) && (y == maze.height - 1)


isEnclosureWall : Int -> Int -> Side -> Maze -> Bool
isEnclosureWall x y side maze =
    case side of
        Up ->
            y == 0

        Right ->
            x == (maze.width - 1)

        Down ->
            y == (maze.height - 1)

        Left ->
            x == 0


{-| return the total number of steps needed for generating the maze
-}
totalSteps : Maze -> Int
totalSteps maze =
    maze.width * maze.height * (List.length sides + 1)


stateString : Maze -> String
stateString maze =
    case maze.state of
        Created ->
            "created"

        Initializing _ ->
            "running"

        Ready ->
            "done"


progress : Maze -> Float
progress maze =
    case maze.state of
        Created ->
            0.0

        Initializing ctx ->
            let
                totalStepsForMaze =
                    totalSteps maze
            in
            100.0 * (min totalStepsForMaze ctx.steps |> toFloat) / (totalStepsForMaze |> toFloat)

        Ready ->
            100.0


progressString : Maze -> String
progressString maze =
    maze
        |> progress
        |> format locale2digits


currentSteps : Maze -> Int
currentSteps maze =
    case maze.state of
        Created ->
            0

        Initializing ctx ->
            ctx.steps

        Ready ->
            totalSteps maze


cellView : Maze -> Int -> List (Html Msg)
cellView maze y =
    range 0 (maze.width - 1)
        |> List.map
            (\x ->
                let
                    cell =
                        cellAt x y maze |> withDefault []

                    cside =
                        exploredSide x y maze

                    isExploredSide side =
                        cside == Just side

                    isNoSideToExplore =
                        exploredCell maze
                            |> Maybe.map (\explCell -> (explCell.x == x) && (explCell.y == y) && (explCell.dirs |> List.isEmpty))
                            |> withDefault False
                in
                div
                    [ attribute "x" (fromInt x)
                    , classList
                        [ ( "cell", True )
                        , ( "up", List.member Up cell )
                        , ( "left", List.member Left cell )
                        , ( "down", List.member Down cell )
                        , ( "right", List.member Right cell )
                        , ( "exploring", isExploring x y maze )
                        , ( "backtracked", isBacktracked x y maze )
                        , ( "wall", isWall x y maze )
                        , ( "path", isWall x y maze |> not )
                        , ( "enclosure-wall-up", isEnclosureWall x y Up maze )
                        , ( "enclosure-wall-right", isEnclosureWall x y Right maze )
                        , ( "enclosure-wall-down", isEnclosureWall x y Down maze )
                        , ( "enclosure-wall-left", isEnclosureWall x y Left maze )
                        , ( "fa fa-caret-up", isExploredSide Up )
                        , ( "fa fa-caret-right", isExploredSide Right )
                        , ( "fa fa-caret-left", isExploredSide Left )
                        , ( "fa fa-caret-down", isExploredSide Down )
                        , ( "fa fa-crosshairs", isNoSideToExplore )
                        , ( "entrance", isEntrance x y )
                        , ( "exit", isExit x y maze )
                        ]
                    ]
                    []
            )


asJsonValue : Maze -> Value
asJsonValue maze =
    let
        cellsToValue : Int -> Int -> List Value -> List Value
        cellsToValue x y acc =
            if x < 0 then
                cellsToValue (maze.width - 1) (y - 1) acc

            else if y < 0 then
                acc

            else
                -- dense representation of the cells
                cellsToValue (x - 1)
                    y
                    (object
                        [ ( "x", int x )
                        , ( "y", int y )
                        , ( "sides"
                          , maze
                                |> cellAt x y
                                |> withDefault []
                                |> map nameSide
                                |> list string
                          )
                        ]
                        :: acc
                    )

        cellValues =
            cellsToValue (maze.width - 1) (maze.height - 1) []
    in
    object
        [ ( "width", int maze.width )
        , ( "height", int maze.height )
        , ( "cells", list identity cellValues )
        , ( "state", string <| stateString maze )
        ]


locale2digits : Locale
locale2digits =
    { usLocale
        | decimals = Exact 2
        , thousandSeparator = ","
        , decimalSeparator = "."
        , negativePrefix = "−"
    }
