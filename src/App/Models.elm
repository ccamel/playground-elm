module App.Models exposing (..)

import App.Routing exposing (..)
import Browser.Navigation as Nav
import Page.About
import Page.Calc
import Page.DigitalClock
import Page.Lissajous
import Page.Maze
import Page.Physics
import Page.Term


type alias Flags =
    { basePath : String
    , version : String
    }


type alias PagesModel =
    { aboutPage : Maybe Page.About.Model
    , calcPage : Maybe Page.Calc.Model
    , lissajousPage : Maybe Page.Lissajous.Model
    , digitalClockPage : Maybe Page.DigitalClock.Model
    , mazePage : Maybe Page.Maze.Model
    , physicsPage : Maybe Page.Physics.Model
    , termPage : Maybe Page.Term.Model
    }


type alias Model =
    { flags : Flags
    , route : Route
    , navKey : Nav.Key

    -- models for pages
    , pages : PagesModel
    }


emptyPagesModel =
    { aboutPage = Nothing
    , calcPage = Nothing
    , lissajousPage = Nothing
    , digitalClockPage = Nothing
    , mazePage = Nothing
    , physicsPage = Nothing
    , termPage = Nothing
    }
