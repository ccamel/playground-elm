module Page.Maze exposing (Cells, InitializingCtx, Maze, MazeState(..), Model, Msg(..), Side(..), Sides, VisitedCell, info, init, subscriptions, update, view)

import Array exposing (Array, get, initialize, set)
import File.Download as Download
import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Decimals(..), Locale, usLocale)
import Html exposing (Html, a, button, div, hr, i, input, span, text)
import Html.Attributes exposing (attribute, class, classList, href, id, name, style, title, type_, value)
import Html.Events exposing (onInput)
import Json.Encode exposing (Value, encode, int, list, object, string)
import Lib.Html exposing (onClickNotPropagate)
import Lib.Page
import Lib.String exposing (strToIntWithMinMax)
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
    , description = Markdown.toHtml [ class "info" ] """

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


type alias Model =
    { maze : Maze
    , auto : Bool
    , memento : List Maze
    }


init : ( Model, Cmd Msg )
init =
    ( initialModelWithMazeSize 20 15
    , Cmd.none
    )


initialModel : Model
initialModel =
    initialModelWithMazeSize 20 15


initialModelWithMazeSize : Int -> Int -> Model
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
    , cells = initialize width (\_ -> initialize height (\_ -> []))
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
    | SetWidth String
    | SetHeight String
    | SetDimension ( Int, Int )
    | Download


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
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
                        Time.now
                            |> repeat n
                            |> map (Task.perform Tick)
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

        SetWidth s ->
            ( case strToIntWithMinMax s maxDimensionsMaze.minW maxDimensionsMaze.maxW of
                Just width ->
                    initialModelWithMazeSize width model.maze.height

                Nothing ->
                    model
            , Cmd.none
            )

        SetHeight s ->
            ( case strToIntWithMinMax s maxDimensionsMaze.minH maxDimensionsMaze.maxH of
                Just height ->
                    initialModelWithMazeSize model.maze.width height

                Nothing ->
                    model
            , Cmd.none
            )

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
subscriptions model =
    if model.auto then
        every 15 Tick

    else
        Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container animated flipInX" ]
        [ hr [] []
        , Markdown.toHtml [ class "info" ] """
##### Maze generator

The generation use a [recursive backtracking](https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker)
algorithm.

You can control the generation process with the control buttons below.
         """
        , controlView model
        , mazeView model.maze
        ]


mazeView : Maze -> Html Msg
mazeView maze =
    div [ class "row maze-wrapper" ]
        [ div [ class "mx-auto" ]
            [ div [ class "maze" ]
                (rowsView maze)
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


controlView : Model -> Html Msg
controlView model =
    let
        state =
            model.maze.state
    in
    div [ class "control" ]
        [ div [ class "row" ]
            [ div [ class "mx-auto" ]
                [ div [ attribute "aria-label" "Maze toolbar", class "btn-toolbar", attribute "role" "toolbar" ]
                    [ div [ attribute "aria-label" "Generation controls", class "btn-group mr-4  btn-group-sm", attribute "role" "group" ]
                        [ button
                            [ class "btn btn-danger"
                            , type_ "button"
                            , title "reset the maze"
                            , onClickNotPropagate Reset
                            ]
                            [ i [ class "fa fa-repeat" ] [] ]
                        , button
                            [ classList [ ( "btn btn-secondary", True ), ( "disabled", List.isEmpty model.memento ) ]
                            , type_ "button"
                            , title "make 5 steps backward"
                            , onClickNotPropagate (Steps -5)
                            ]
                            [ i [ class "fa fa-fast-backward" ] [] ]
                        , button
                            [ classList [ ( "btn btn-secondary", True ), ( "disabled", List.isEmpty model.memento ) ]
                            , type_ "button"
                            , title "make one step backward"
                            , onClickNotPropagate (Steps -1)
                            ]
                            [ i [ class "fa fa-step-backward" ] [] ]
                        , button
                            [ classList [ ( "btn btn-secondary", True ), ( "disabled", model.auto || (state == Ready) ) ]
                            , type_ "button"
                            , title "generate the maze"
                            , onClickNotPropagate StartAutoGeneration
                            ]
                            [ i [ class "fa fa-play" ] [] ]
                        , button
                            [ classList [ ( "btn btn-secondary", True ), ( "disabled", not model.auto || (state == Ready) ) ]
                            , type_ "button"
                            , title "stop the generation"
                            , onClickNotPropagate StopAutoGeneration
                            ]
                            [ i [ class "fa fa-pause" ] [] ]
                        , button
                            [ classList [ ( "btn btn-secondary", True ), ( "disabled", model.auto || (state == Ready) ) ]
                            , type_ "button"
                            , title "make one step"
                            , onClickNotPropagate (Steps 1)
                            ]
                            [ i [ class "fa fa-step-forward" ] [] ]
                        , button
                            [ classList [ ( "btn btn-secondary", True ), ( "disabled", model.auto || (state == Ready) ) ]
                            , type_ "button"
                            , title "make 5 steps"
                            , onClickNotPropagate (Steps 5)
                            ]
                            [ i [ class "fa fa-fast-forward" ] [] ]
                        ]
                    , div [ attribute "aria-label" "Import/Export controls", class "btn-group mr-4", attribute "role" "group" ]
                        [ a
                            [ class "btn btn-info"
                            , attribute "role" "button"
                            , title "Export the maze state to JSON"
                            , href "."
                            , onClickNotPropagate Download
                            ]
                            [ i [ class "fa fa-download" ] [] ]
                        ]
                    , div [ attribute "aria-label" "Maze dimensions", class "btn-group mr-2", attribute "role" "group" ]
                        [ div [ class "input-group mr-2" ]
                            [ span
                                [ class "input-group-addon"
                                , id "btnMazeWidth"
                                ]
                                [ text "width" ]
                            , input
                                [ class "form-control input-number t4"
                                , attribute "aria-describedby" "btnMazeWidth"
                                , name "maze-w"
                                , type_ "number"
                                , value (fromInt model.maze.width)
                                , onInput SetWidth
                                ]
                                []
                            ]
                        , div [ class "input-group" ]
                            [ span
                                [ class "input-group-addon"
                                , id "btnMazeHeight"
                                ]
                                [ text "height" ]
                            , input
                                [ class "form-control input-number t4"
                                , attribute "aria-describedby" "btnMazeHeight"
                                , name "maze-h"
                                , type_ "number"
                                , value (fromInt model.maze.height)
                                , onInput SetHeight
                                ]
                                []
                            ]
                        , div [ class "dropdown" ]
                            [ button
                                [ attribute "aria-expanded" "false"
                                , attribute "aria-haspopup" "true"
                                , class "btn btn-info dropdown-toggle"
                                , attribute "data-toggle" "dropdown"
                                , id "dropdownMazeDimensions"
                                , type_ "button"
                                ]
                                [ text "Samples" ]
                            , div [ attribute "aria-labelledby" "dropdownMazeDimensions", class "dropdown-menu" ]
                                ([ ( 20, 15 ), ( 40, 1 ), ( 3, 20 ), ( 5, 5 ), ( 15, 15 ), ( 50, 50 ) ]
                                    |> map
                                        (\( w, h ) ->
                                            a
                                                [ classList
                                                    [ ( "dropdown-item", True )
                                                    , ( "selected", ( w, h ) == ( model.maze.width, model.maze.height ) )
                                                    ]
                                                , onClickNotPropagate (SetDimension ( w, h ))
                                                , href "#"
                                                ]
                                                [ text <| fromInt w ++ " x " ++ fromInt h ]
                                        )
                                )
                            ]
                        ]
                    ]
                ]
            ]
        , div [ class "row" ]
            [ div [ class "mx-auto" ]
                [ div [ attribute "aria-label" "States", class "btn-group mr-2 states", attribute "role" "group" ]
                    [ div [ class "input-group mr-2" ]
                        [ span
                            [ class "input-group-addon monotyped"
                            , id "btnMazeState"
                            ]
                            [ text "state" ]
                        , input
                            [ class "form-control input-text t7 monotyped"
                            , attribute "readonly" ""
                            , attribute "aria-describedby" "btnMazeState"
                            , name "maze-state"
                            , type_ "text"
                            , value (stateString model.maze)
                            ]
                            []
                        ]
                    , div [ class "input-group mr-2" ]
                        [ span
                            [ class "input-group-addon monotyped"
                            , id "btnMazeProgress"
                            ]
                            [ text "progress" ]
                        , let
                            pString =
                                progressString model.maze

                            pText =
                                pString ++ "%"
                          in
                          div [ class "progress form-control", style "width" "150px" ]
                            [ div
                                [ attribute "aria-valuemax" "100"
                                , attribute "aria-valuemin" "0"
                                , attribute "aria-valuenow" pString
                                , class "progress-bar progress-bar-striped bg-info"
                                , classList [ ( "progress-bar-animated", model.maze.state /= Ready ) ]
                                , attribute "role" "progressbar"
                                , attribute "style" (interpolate "width: {0};" [ pText ])
                                ]
                                [ div [ class "progression" ]
                                    [ text (pText |> padLeft 6 ' ') ]
                                ]
                            ]
                        ]
                    , div [ class "input-group mr-2" ]
                        [ span
                            [ class "input-group-addon monotyped"
                            , id "btnMazeSteps"
                            ]
                            [ text "steps" ]
                        , input
                            [ class "form-control input-text t9 monotyped"
                            , attribute "readonly" ""
                            , attribute "aria-describedby" "btnMazeSteps"
                            , name "maze-steps"
                            , type_ "text"
                            , value <|
                                interpolate "{0}/{1}"
                                    [ currentSteps model.maze |> fromInt |> padLeft 5 ' '
                                    , totalSteps model.maze |> fromInt |> padLeft 5 ' '
                                    ]
                            ]
                            []
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


isEntrance : Int -> Int -> Maze -> Bool
isEntrance x y _ =
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
                        , ( "entrance", isEntrance x y maze )
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
