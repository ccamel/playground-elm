module App.Messages exposing (..)

import Page.About
import Page.Calc
import Url exposing (Url)
import Browser exposing (Document)
-- import Page.DigitalClock
-- import Page.Lissajous
-- import Page.Maze

type Page
    = About
    | Calc
--    | Lissajous
--    | DigitalClock
--    | Maze


type Msg
    = ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | GoToHome
    | GoToPage Page
    -- messages for pages
    | AboutPageMsg Page.About.Msg
    | CalcPageMsg Page.Calc.Msg
--    | LissajousPageMsg Page.Lissajous.Msg
--    | DigitalClockPageMsg Page.DigitalClock.Msg
--    | MazePageMsg Page.Maze.Msg
