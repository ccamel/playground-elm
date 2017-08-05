module App.Models exposing (..)

import App.Routing exposing(..)
import Page.About
import Page.Calc

type alias Model =
    {
       route : Route

       -- models for pages
      ,aboutPage : Maybe Page.About.Model
      ,calcPage : Maybe Page.Calc.Model
    }


initialModel : Route -> Model
initialModel route =
    {
       route = route

       -- models for pages
      ,aboutPage = Just Page.About.initialModel
      ,calcPage = Just Page.Calc.initialModel
    }

