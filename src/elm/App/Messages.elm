module App.Messages exposing (..)

import Navigation exposing (Location)
import App.Routing
import Page.About

type Msg
    = OnLocationChange Location
    | GoToPage App.Routing.Page
    | AboutPageMsg Page.About.Msg
