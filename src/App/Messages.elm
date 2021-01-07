module App.Messages exposing (..)

import Browser exposing (Document)
import Page.About
import Page.Calc
import Page.DigitalClock
import Page.Lissajous
import Page.Maze
import Page.Physics
import Url exposing (Url)


type Page
    = About
    | Calc
    | Lissajous
    | DigitalClock
    | Maze
    | Physics


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
    | PhysicsPageMsg Page.Physics.Msg
