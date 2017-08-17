module Page.Maze exposing (..)

import Array exposing (Array, get, initialize, set, toList)
import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Locale)
import Html exposing (Html, a, button, div, h2, h3, hr, i, img, input, li, p, pre, span, text, ul)
import Html.Attributes exposing (alt, attribute, class, classList, href, id, name, size, src, style, title, type_, value)
import Html.Events exposing (onInput)
import List exposing (append, map, range, repeat)
import Markdown
import Maybe exposing (withDefault)
import Page.Common exposing (onClickNotPropagate, strToIntWithMinMax)
import Random exposing (Seed, initialSeed, step)
import Random.List exposing (shuffle)
import String exposing (padLeft)
import String.Interpolate exposing (interpolate)
import Task
import Time exposing (Time, every)

-- PAGE INFO

info : Page.Common.PageInfo Msg
info = {
     name = "maze"
     , hash = "maze"
     , description = Markdown.toHtml [class "info"] """

A maze generator using a [recursive backtracking](https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker) algorithm.
       """
     , srcRel = "Page/Maze.elm"
 }

-- MODEL

type Side =
    Left
  | Up
  | Right
  | Down

type alias Sides = List Side

sides : Sides
sides = [Left, Up, Right, Down]

type alias Cells = Array (Array Sides)

type alias Cell = {
        sides: Sides -- opened sides for the cell (if empty then cell has no issues)
    }

type alias VisitedCell = {
        x : Int
       ,y : Int
       ,dirs : Sides --remaining sides to visit
    }

type alias InitializingCtx = {
        visitedCell : List VisitedCell
       ,steps: Int -- number of steps performed so far (used to compute completeness)
       ,seed : Seed -- for random
    }


type MazeState =
     Created
   | Initializing  InitializingCtx
   | Ready

type alias Maze = {
       width : Int
      ,height: Int
      ,cells : Cells
      ,state : MazeState
   }

type alias Model = {
         maze : Maze
        ,auto : Bool
    }

initialModel : Model
initialModel = initialModelWithMazeSize 15 15

initialModelWithMazeSize : Int -> Int -> Model
initialModelWithMazeSize w h =
    { maze = emptyMaze w h, auto = False }

initialCmd : Cmd Msg
initialCmd = Cmd.none

initialInitializingContext : Time -> InitializingCtx
initialInitializingContext time =
    let
        -- generate random sides
        (shuffled, seed) = step (shuffle sides) (initialSeed (round time))
    in
        { visitedCell = [{x = 0, y = 0, dirs = shuffled}]
         ,seed = seed
         ,steps = 0
        }

cellAt : Int -> Int -> Maze -> Maybe Sides
cellAt x y maze =
    let
       col = get x maze.cells
    in
       col
        |> Maybe.andThen (get y)

cellSet : Int -> Int -> List Side -> Maze -> Maze
cellSet x y v maze =
    let
        cells = maze.cells
        col = get x cells
    in
        case col of
            Just c ->
                { maze | cells = set x (set y v c) cells }
            Nothing ->
                maze


emptyMaze : Int -> Int -> Maze
emptyMaze width height =
    {
        width = width
       ,height = height
       ,cells = initialize width (\x -> initialize  height (\y -> []))
       ,state = Created
    }

-- performs one step in the generation of the maze according to the current building context.
-- algorithm is a depth-first search algorithm (with backtracking)
stepMaze : Maze -> Maze
stepMaze maze =
    case maze.state of
        Initializing ctx ->
            case ctx.visitedCell of
                (visit::ovisits) ->
                    case visit.dirs of
                        (dir::odirs) ->
                            let
                                between v upper = (v >= 0) && (v < upper)
                                (cx, cy) = (visit.x, visit.y)
                                (dx, dy) = deltaSide dir
                                (nx, ny) = (cx + dx, cy + dy)
                                cellC = cellAt cx cy maze |> Maybe.withDefault []
                                cellN = cellAt nx ny maze |> Maybe.withDefault []
                                visited = ({ visit | dirs = odirs }) :: ovisits
                            in
                                if (between nx maze.width)
                                && (between ny maze.height)
                                && (cellN |> List.isEmpty)
                                then
                                    let
                                        -- update maze with new path
                                        newMaze = maze
                                                   |> cellSet cx cy (dir :: cellC )
                                                   |> cellSet nx ny ((oppositeSide dir) :: cellN )
                                        -- add the new cell to the list of visited cells
                                        (shuffled, seed) = step (shuffle sides) ctx.seed
                                        nVisited = {x = nx, y = ny, dirs = shuffled} :: visited
                                    in
                                        {newMaze | state = Initializing { ctx | visitedCell = nVisited
                                                                               ,steps = ctx.steps + 1
                                                                               ,seed = seed}
                                        }
                                else
                                    {maze | state = Initializing { ctx | visitedCell = visited
                                                                        ,steps = ctx.steps + 1}
                                    }
                        [] -> {maze | state = Initializing { ctx | visitedCell = ovisits
                                                                  ,steps = ctx.steps + 1}}
                [] ->
                    {maze | state = Ready}
        _ ->
            maze


deltaSide : Side -> (Int, Int)
deltaSide side =
    case side of
        Up -> (0, -1)
        Right -> (1, 0)
        Down -> (0, 1)
        Left -> (-1, 0)

oppositeSide : Side -> Side
oppositeSide side =
    case side of
        Up -> Down
        Right -> Left
        Down -> Up
        Left -> Right

nameSide : Side -> String
nameSide side =
    case side of
        Up -> "up"
        Right -> "right"
        Down -> "down"
        Left -> "left"

-- UPDATE

type Msg =
    Tick Time
  | StartAutoGeneration
  | StopAutoGeneration
  | Steps Int -- number of steps
  | Reset
  | SetWidth String
  | SetHeight String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Tick time ->
        let
            maze = model.maze
        in
            case maze.state of
                Created ->
                    -- going to initializing state
                    ({ model | maze = { maze | state = Initializing <| initialInitializingContext time }
                     }, Cmd.none)
                Initializing  ctx ->
                    ({ model | maze = stepMaze model.maze }
                    , Cmd.none)
                Ready ->
                    ( {model | auto = False}, Cmd.none)
    StartAutoGeneration ->
        ({model | auto = True}, Cmd.none)

    StopAutoGeneration ->
        ({model | auto = False}, Cmd.none)

    Steps n ->
        let
            -- produce n commands, each one sending a tick on "time.now"
            cmd = Time.now
                     |> repeat n
                     |> map (Task.perform Tick)
                     |> Cmd.batch
        in
            ( model, cmd )

    Reset -> ( initialModel, initialCmd )

    SetWidth s ->
        let
            maze = model.maze
        in
            ( case (strToIntWithMinMax s 2 50) of
                Just width -> initialModelWithMazeSize width model.maze.height
                Nothing -> model
             ,Cmd.none)
    SetHeight s ->
        let
            maze = model.maze
        in
            ( case (strToIntWithMinMax s 2 50) of
                Just height -> initialModelWithMazeSize model.maze.width height
                Nothing -> model
             ,Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    if model.auto
        then every 15 Tick
        else Sub.none

-- VIEW

view : Model -> Html Msg
view model =
  div [ class "container animated flipInX" ]
      [ hr [] []
       ,Markdown.toHtml [class "info"] """
##### Maze generator

The generation use a [recursive backtracking](https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker)
algorithm.

You can control the generation process with the control buttons below.
         """
       ,controlView model
       ,mazeView model.maze
      ]

mazeView : Maze -> Html Msg
mazeView maze =
    div [class "row maze-wrapper"]
        [
           div [class "mx-auto"]
               [
                   div [class "maze"]
                       (rowsView maze)
               ]
        ]

rowsView : Maze -> List (Html Msg)
rowsView maze =
    range 0 (maze.height - 1)
        |> List.map (\y ->
            div [class "maze-row", attribute "y" (toString y)]
                (cellView maze y))

controlView : Model -> Html Msg
controlView model =
    let
        state = model.maze.state
    in
        div [class "control"] [
             div [ attribute "aria-label" "Maze toolbar", class "btn-toolbar", attribute "role" "toolbar" ]
                [ div [ attribute "aria-label" "Generation controls", class "btn-group mr-4  btn-group-sm", attribute "role" "group" ]
                    [
                         button [ classList [("btn btn-secondary btn-danger", True)]
                                 ,type_ "button"
                                 ,title "reset the maze"
                                 ,onClickNotPropagate Reset]
                            [ i [class "fa fa-repeat"] [] ]
                       , button [ classList [("btn btn-secondary", True), ("disabled", model.auto || (state == Ready))]
                                 ,type_ "button"
                                 ,title "generate the maze"
                                 ,onClickNotPropagate StartAutoGeneration]
                            [ i [class "fa fa-play"] [] ]
                       , button [ classList [("btn btn-secondary", True), ("disabled", not model.auto || (state == Ready))]
                                 ,type_ "button"
                                 ,title "stop the generation"
                                 ,onClickNotPropagate StopAutoGeneration]
                            [ i [class "fa fa-pause"] [] ]
                       , button [ classList [("btn btn-secondary", True), ("disabled", model.auto || (state == Ready))]
                                 ,type_ "button"
                                 ,title "make one step"
                                 ,onClickNotPropagate (Steps 1)]
                            [ i [class "fa fa-step-forward"] [] ]
                        , button [ classList [("btn btn-secondary", True), ("disabled", model.auto || (state == Ready))]
                                 ,type_ "button"
                                 ,title "make 5 steps"
                                 ,onClickNotPropagate (Steps 5)]
                            [ i [class "fa fa-fast-forward"] [] ]
                    ]
                ,div [ attribute "aria-label" "Maze dimensions", class "btn-group mr-2", attribute "role" "group" ]
                    [
                        div [ class "input-group mr-2" ]
                            [ span [ class "input-group-addon"
                                    ,id "btnMazeWidth" ]
                                [ text "width" ]
                             ,input [ class "form-control input-number t4"
                                     ,attribute "aria-describedby" "btnMazeWidth"
                                     ,name "maze-w"
                                     ,type_ "number"
                                     ,value (toString model.maze.width)
                                     ,onInput SetWidth] []
                            ]
                       ,div [ class "input-group" ]
                            [ span [ class "input-group-addon"
                                    ,id "btnMazeHeight" ]
                                [ text "height" ]
                             ,input [ class "form-control input-number t4"
                                     ,attribute "aria-describedby" "btnMazeHeight"
                                     ,name "maze-h"
                                     ,type_ "number"
                                     ,value (toString model.maze.height)
                                     ,onInput SetHeight] []
                            ]
                    ]
                ,div [ attribute "aria-label" "States", class "btn-group mr-2", attribute "role" "group" ]
                    [
                            div [ class "input-group mr-2" ]
                                [ span [ class "input-group-addon"
                                        ,id "btnMazeState" ]
                                    [ text "state" ]
                                 ,input [ class "form-control input-text t6 monotyped"
                                         ,attribute "readonly" ""
                                         ,attribute "aria-describedby" "btnMazeState"
                                         ,name "maze-state"
                                         ,type_ "text"
                                         ,value (stateString model.maze)] []
                                ]
                           ,div [ class "input-group mr-2" ]
                                [ span [ class "input-group-addon"
                                        ,id "btnMazeProgress" ]
                                    [ text "progress" ]
                                 ,input [ class "form-control input-text t7 monotyped"
                                         ,attribute "readonly" ""
                                         ,attribute "aria-describedby" "btnMazeProgress"
                                         ,name "maze-progress"
                                         ,type_ "text"
                                         ,value (progressString model.maze)] []
                                ]
                            ,div [ class "input-group mr-2" ]
                                [ span [ class "input-group-addon"
                                        ,id "btnMazeSteps" ]
                                    [ text "steps" ]
                                 ,input [ class "form-control input-text t8 monotyped"
                                         ,attribute "readonly" ""
                                         ,attribute "aria-describedby" "btnMazeSteps"
                                         ,name "maze-steps"
                                         ,type_ "text"
                                         ,value <| interpolate "{0}/{1}"
                                                               [ currentSteps model.maze |> toString |> padLeft 5 ' '
                                                                ,totalSteps model.maze |> toString |> padLeft 5 ' ']
                                        ] []
                                ]
                    ]
                ]
        ]

-- tells if the cell at given position is currently being explored (i.e. is a new discovered cell)
isExploring : Int -> Int -> Maze -> Bool
isExploring x y maze =
    case maze.state of
        Created -> False
        Initializing ctx ->
            case ctx.visitedCell of
                (head::_) ->   (head.x == x)
                            && (head.y == y)
                            && ((List.length head.dirs) == (List.length sides))
                _ -> False
        Ready -> False

exploredCell : Maze -> Maybe VisitedCell
exploredCell maze =
    case maze.state of
        Created -> Nothing
        Initializing ctx ->
            case ctx.visitedCell of
                (head::_) -> Just head
                _ -> Nothing
        Ready -> Nothing

-- return the explored side if any
exploredSide : Int -> Int -> Maze -> Maybe Side
exploredSide x y maze =
    exploredCell maze
      |> Maybe.andThen (\cell ->
              if (cell.x == x) && (cell.y == y) then
                  case cell.dirs of
                      (side::_) -> Just side
                      _ -> Nothing
              else
                  Nothing)

isBacktracked : Int -> Int -> Maze -> Bool
isBacktracked x y maze =
    case maze.state of
        Created -> False
        Initializing ctx ->
            case ctx.visitedCell of
                (head::_) ->   (head.x == x)
                            && (head.y == y)
                            && ((List.length head.dirs) /= (List.length sides))
                _ -> False
        Ready -> False

-- tells if the cell at given position is a wall, i.e. there's no path to it
isWall : Int -> Int -> Maze -> Bool
isWall x y maze =
    maze
      |> cellAt x y
      |> Maybe.map List.length
      |> Maybe.withDefault 0
      |> (==) 0

isEntrance : Int -> Int -> Maze -> Bool
isEntrance x y maze = (x == 0) && (y == 0)

isExit : Int -> Int -> Maze -> Bool
isExit x y maze = (x == maze.width - 1) && (y == maze.height - 1)

isEnclosureWall : Int -> Int -> Side -> Maze -> Bool
isEnclosureWall x y side maze =
    case side of
        Up -> y == 0
        Right -> x == (maze.width - 1)
        Down -> y == (maze.height - 1)
        Left -> x == 0

-- return the total number of steps needed for generating the maze
totalSteps : Maze -> Int
totalSteps maze =
    maze.width * maze.height * ((List.length sides) + 1 ) -- one for backtracking

stateString: Maze -> String
stateString maze =
    case maze.state of
        Created -> "created"
        Initializing _ -> "running"
        Ready -> "done"

progress : Maze -> Float
progress maze =
    let
        totalStepsForMaze = totalSteps maze
    in
        case maze.state of
            Created -> 0.0
            Initializing ctx -> 100.0 * (min totalStepsForMaze ctx.steps |> toFloat) / (totalStepsForMaze |> toFloat)
            Ready -> 100.0

progressString : Maze -> String
progressString maze =
       (maze
        |> progress
        |> format locale2digits
        |> padLeft 6 ' ')
       ++ " %"

currentSteps : Maze -> Int
currentSteps maze =
    case maze.state of
            Created -> 0
            Initializing ctx -> ctx.steps
            Ready -> totalSteps maze

cellView : Maze -> Int -> List (Html Msg)
cellView maze y  =
    range 0 (maze.width - 1)
        |> List.map (\x ->
            let
                cell = cellAt x y maze |> withDefault []
                cside = exploredSide x y maze
                isExploredSide side = cside == Just side
                isNoSideToExplore =
                    exploredCell maze
                        |> Maybe.map (\explCell -> (explCell.x == x) && (explCell.y == y) && (explCell.dirs |> List.isEmpty))
                        |> withDefault False
            in
                div [ attribute "x" (toString x)
                     ,classList [
                         ("cell", True)
                        ,("up", (List.member Up cell))
                        ,("left", (List.member Left cell))
                        ,("down", (List.member Down cell))
                        ,("right", (List.member Right cell))
                        ,("exploring", isExploring x y maze)
                        ,("backtracked", isBacktracked x y maze)
                        ,("wall", isWall x y maze)
                        ,("path", isWall x y maze |> not)
                        ,("enclosure-wall-up", isEnclosureWall x y Up maze)
                        ,("enclosure-wall-right", isEnclosureWall x y Right maze)
                        ,("enclosure-wall-down", isEnclosureWall x y Down maze)
                        ,("enclosure-wall-left", isEnclosureWall x y Left maze)
                        ,("fa fa-caret-up", isExploredSide Up )
                        ,("fa fa-caret-right", isExploredSide Right )
                        ,("fa fa-caret-left", isExploredSide Left )
                        ,("fa fa-caret-down", isExploredSide Down)
                        ,("fa fa-crosshairs", isNoSideToExplore)
                        ,("entrance", isEntrance x y maze)
                        ,("exit", isExit x y maze)
                       ]
                    ]
                    [])

locale2digits : Locale
locale2digits =
    Locale 2 "," "." "−" ""