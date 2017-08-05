module App.Messages exposing (..)

import Navigation exposing (Location)
import Page.About
import Page.Calc

type Page
    = About
    | Calc


type Msg
    = OnLocationChange Location
    | GoToHome
    | GoToPage Page

    -- messages for pages
    | AboutPageMsg Page.About.Msg
    | CalcPageMsg Page.Calc.Msg
