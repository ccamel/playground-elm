module Messages exposing (..)

import Navigation exposing (Location)
import Routing

type Msg
    = OnLocationChange Location
    | GoToPage Routing.Page

