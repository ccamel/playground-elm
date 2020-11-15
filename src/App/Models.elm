module App.Models exposing (..)

import App.Messages exposing (Msg(..))
import App.Routing exposing(..)
import Page.About exposing (..)
import Page.Calc
-- import Page.DigitalClock
-- import Page.Lissajous
-- import Page.Maze
import Browser.Navigation as Nav
import Browser.Navigation as Nav
import Platform.Cmd exposing (batch)
import Json.Decode exposing (bool)

type alias Model =
    {
       route : Route
       ,navKey : Nav.Key
       -- models for pages
       ,aboutPage : Maybe Page.About.Model
       ,calcPage : Maybe Page.Calc.Model
--      ,lissajousPage : Maybe Page.Lissajous.Model
--      ,digitalClockPage : Maybe Page.DigitalClock.Model
--      ,mazePage : Maybe Page.Maze.Model
    }


initialModel : Nav.Key -> Route -> (Model, Cmd App.Messages.Msg)
initialModel navKey route =
    let
        ( aboutModel, aboutCmd ) = Page.About.init
        ( calcModel, calcCmd ) = Page.Calc.init        
    in
        ({
        route = route
        ,navKey = navKey
        -- models for pages
        ,aboutPage = Just aboutModel
        ,calcPage = Just calcModel
    --      ,lissajousPage = Just Page.Lissajous.initialModel
    --      ,digitalClockPage = Just Page.DigitalClock.initialModel
    --      ,mazePage = Just Page.Maze.initialModel
        }, batch [
            -- commands for pages
            Cmd.map AboutPageMsg aboutCmd
        ,Cmd.map CalcPageMsg calcCmd
    --       ,Cmd.map LissajousPageMsg Page.Lissajous.initialCmd
    --       ,Cmd.map DigitalClockPageMsg Page.DigitalClock.initialCmd
    --       ,Cmd.map MazePageMsg Page.Maze.initialCmd
        ])

