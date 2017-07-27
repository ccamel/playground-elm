module App.Messages exposing (..)

import Navigation exposing (Location)
import App.Routing

type Msg
    = OnLocationChange Location
    | GoToPage App.Routing.Page

