module App.Messages exposing (Msg(..), Page(..))

import Browser
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
import Url exposing (Url)


type Page
    = About
    | Calc
    | Lissajous
    | DigitalClock
    | Maze
    | Physics
    | Term
    | Asteroids
    | Dapp
    | SoundWaveToggle


type Msg
    = NoOp
    | UrlChanged Url
    | LinkClicked Browser.UrlRequest
      -- messages for pages
    | AboutPageMsg Page.About.Msg
    | CalcPageMsg Page.Calc.Msg
    | LissajousPageMsg Page.Lissajous.Msg
    | DigitalClockPageMsg Page.DigitalClock.Msg
    | MazePageMsg Page.Maze.Msg
    | PhysicsPageMsg Page.Physics.Msg
    | TermPageMsg Page.Term.Msg
    | AsteroidsPageMsg Page.Asteroids.Msg
    | DappPageMsg Page.Dapp.Msg
    | SoundWaveTogglePageMsg Page.SoundWaveToggle.Msg
