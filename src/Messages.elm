module Messages exposing (..)

import Navigation exposing (Location)


type Msg
    = OnLocationChange Location
    | GoToAboutPage
    | GoToMainPage
