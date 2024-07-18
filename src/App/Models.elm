module App.Models exposing (Model, PagesModel, emptyPagesModel)

import App.Flags exposing (Flags)
import App.Routing exposing (Route)
import Browser.Navigation as Nav
import Page.About
import Page.Asteroids
import Page.Calc
import Page.Dapp
import Page.DigitalClock
import Page.Lissajous
import Page.Maze
import Page.Physics
import Page.SoundWaveToggle
import Page.Term


type alias PagesModel =
    { aboutPage : Maybe Page.About.Model
    , calcPage : Maybe Page.Calc.Model
    , lissajousPage : Maybe Page.Lissajous.Model
    , digitalClockPage : Maybe Page.DigitalClock.Model
    , mazePage : Maybe Page.Maze.Model
    , physicsPage : Maybe Page.Physics.Model
    , termPage : Maybe Page.Term.Model
    , asteroidsPage : Maybe Page.Asteroids.Model
    , dappPage : Maybe Page.Dapp.Model
    , soundWaveTogglePage : Maybe Page.SoundWaveToggle.Model
    }


type alias Model =
    { flags : Flags
    , route : Route
    , navKey : Nav.Key

    -- models for pages
    , pages : PagesModel
    }


emptyPagesModel : { aboutPage : Maybe a, calcPage : Maybe b, lissajousPage : Maybe c, digitalClockPage : Maybe d, mazePage : Maybe e, physicsPage : Maybe f, termPage : Maybe g, asteroidsPage : Maybe h, dappPage : Maybe i, soundWaveTogglePage : Maybe j }
emptyPagesModel =
    { aboutPage = Nothing
    , calcPage = Nothing
    , lissajousPage = Nothing
    , digitalClockPage = Nothing
    , mazePage = Nothing
    , physicsPage = Nothing
    , termPage = Nothing
    , asteroidsPage = Nothing
    , dappPage = Nothing
    , soundWaveTogglePage = Nothing
    }
