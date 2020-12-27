module App.Messages exposing (..)

import Page.About
import Page.Calc
import Page.Maze
import Page.Physics
import Url exposing (Url)
import Browser exposing (Document)
import Page.DigitalClock
import Page.Lissajous

type Page
    = About
    | Calc
    | Lissajous
    | DigitalClock
    | Maze
    | Cloth


type Msg
    = UrlChanged Url
    | LinkClicked Browser.UrlRequest
    | GoToHome
    | GoToPage Page
    -- messages for pages
    | AboutPageMsg Page.About.Msg
    | CalcPageMsg Page.Calc.Msg
    | LissajousPageMsg Page.Lissajous.Msg
    | DigitalClockPageMsg Page.DigitalClock.Msg
    | MazePageMsg Page.Maze.Msg
    | ClothPageMsg Page.Physics.Msg
