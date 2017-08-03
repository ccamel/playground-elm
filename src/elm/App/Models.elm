module App.Models exposing (..)

import App.Messages exposing (Msg(AboutPageMsg), Page(About))
import App.Routing exposing(..)
import Html exposing (Html)
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

