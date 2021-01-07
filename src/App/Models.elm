module App.Models exposing (..)

import App.Messages exposing (Msg(..))
import App.Routing exposing (..)
import Browser.Navigation as Nav
import Page.About exposing (..)
import Page.Calc
import Page.DigitalClock
import Page.Lissajous
import Page.Maze
import Page.Physics
import Platform.Cmd exposing (batch)


type alias Flags =
    { basePath : String
    , version : String
    }


type alias Model =
    { flags : Flags
    , route : Route
    , navKey : Nav.Key

    -- models for pages
    , aboutPage : Maybe Page.About.Model
    , calcPage : Maybe Page.Calc.Model
    , lissajousPage : Maybe Page.Lissajous.Model
    , digitalClockPage : Maybe Page.DigitalClock.Model
    , mazePage : Maybe Page.Maze.Model
    , physicsPage : Maybe Page.Physics.Model
    }


initialModel : Flags -> Nav.Key -> Route -> ( Model, Cmd App.Messages.Msg )
initialModel flags navKey route =
    let
        ( aboutModel, aboutCmd ) =
            Page.About.init

        ( calcModel, calcCmd ) =
            Page.Calc.init

        ( lissajousModel, lissajousCmd ) =
            Page.Lissajous.init

        ( mazeModel, mazeCmd ) =
            Page.Maze.init

        ( digitalClockModel, digitalClockCmd ) =
            Page.DigitalClock.init

        ( physicsModel, physicsCmd ) =
            Page.Physics.init
    in
    ( { flags = flags
      , route = route
      , navKey = navKey

      -- models for pages
      , aboutPage = Just aboutModel
      , calcPage = Just calcModel
      , lissajousPage = Just lissajousModel
      , digitalClockPage = Just digitalClockModel
      , mazePage = Just mazeModel
      , physicsPage = Just physicsModel
      }
    , batch
        [ -- commands for pages
          Cmd.map AboutPageMsg aboutCmd
        , Cmd.map CalcPageMsg calcCmd
        , Cmd.map LissajousPageMsg lissajousCmd
        , Cmd.map DigitalClockPageMsg digitalClockCmd
        , Cmd.map MazePageMsg mazeCmd
        , Cmd.map PhysicsPageMsg physicsCmd
        ]
    )
