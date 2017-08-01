module App.Models exposing (..)

import App.Routing exposing(..)
import Page.About

type alias Model =
    {
        route : Route
        , aboutPage : Maybe Page.About.Model
    }

initialModel : Route -> Model
initialModel route =
    {
        route = route
        , aboutPage = Nothing
    }
