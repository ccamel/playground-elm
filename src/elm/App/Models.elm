module App.Models exposing (..)

import App.Routing exposing(..)
import Page.About
import Page.Calc
import Page.Lissajous

type alias Model =
    {
       route : Route

       -- models for pages
      ,aboutPage : Maybe Page.About.Model
      ,calcPage : Maybe Page.Calc.Model
      ,lissajousPage : Maybe Page.Lissajous.Model
    }


initialModel : Route -> Model
initialModel route =
    {
       route = route

       -- models for pages
      ,aboutPage = Just Page.About.initialModel
      ,calcPage = Just Page.Calc.initialModel
      ,lissajousPage = Just Page.Lissajous.initialModel
    }

