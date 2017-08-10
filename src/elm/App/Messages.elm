module App.Messages exposing (..)

import Navigation exposing (Location)
import Page.About
import Page.Calc
import Page.DigitalClock
import Page.Lissajous

type Page
    = About
    | Calc
    | Lissajous
    | DigitalClock


type Msg
    = OnLocationChange Location
    | GoToHome
    | GoToPage Page

    -- messages for pages
    | AboutPageMsg Page.About.Msg
    | CalcPageMsg Page.Calc.Msg
    | LissajousPageMsg Page.Lissajous.Msg
    | DigitalClockPageMsg Page.DigitalClock.Msg
