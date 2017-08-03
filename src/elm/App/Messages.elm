module App.Messages exposing (..)

import Navigation exposing (Location)
import Page.About

type Page
    = About


type Msg
    = OnLocationChange Location
    | GoToHome
    | GoToPage Page

    -- messages for pages
    | AboutPageMsg Page.About.Msg
