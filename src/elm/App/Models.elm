module App.Models exposing (..)

import App.Routing exposing(..)
import Page.About

type alias Model =
    {
       route : Route

       -- models for pages
      ,aboutPage : Maybe Page.About.Model
    }


initialModel : Route -> Model
initialModel route =
    {
       route = route

       -- models for pages
      ,aboutPage = Just Page.About.initialModel
    }

