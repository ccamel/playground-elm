module App.Models exposing (..)

import App.Routing exposing(..)

type alias Model =
    {
        route : Route
    }


initialModel : Route -> Model
initialModel route =
    {
        route = route
    }
