module App.Models exposing (..)

import App.Routing exposing(..)
import Page.About

type alias Model =
    {
       route : Route
      ,aboutPage : Maybe Page.About.Model
    }

initialModel : Route -> Model
initialModel route =
    {
       route = route
      ,aboutPage = if (route == Page About) then (Just Page.About.initialModel) else Nothing -- TODO: I'm not happy with this
    }
