module App.Models exposing (..)

import App.Messages exposing (Msg(AboutPageMsg, CalcPageMsg, DigitalClockPageMsg, LissajousPageMsg))
import App.Routing exposing(..)
import Page.About exposing (..)
import Page.Calc
import Page.DigitalClock
import Page.Lissajous
import Platform.Cmd exposing (batch)

type alias Model =
    {
       route : Route

       -- models for pages
      ,aboutPage : Maybe Page.About.Model
      ,calcPage : Maybe Page.Calc.Model
      ,lissajousPage : Maybe Page.Lissajous.Model
      ,digitalClockPage : Maybe Page.DigitalClock.Model
    }


initialModel : Route -> (Model, Cmd App.Messages.Msg)
initialModel route =
    ({
       route = route

       -- models for pages
      ,aboutPage = Just Page.About.initialModel
      ,calcPage = Just Page.Calc.initialModel
      ,lissajousPage = Just Page.Lissajous.initialModel
      ,digitalClockPage = Just Page.DigitalClock.initialModel
    }, batch [
        -- commands for pages
        Cmd.map AboutPageMsg Page.About.initialCmd
       ,Cmd.map CalcPageMsg Page.Calc.initialCmd
       ,Cmd.map LissajousPageMsg Page.Lissajous.initialCmd
       ,Cmd.map DigitalClockPageMsg Page.DigitalClock.initialCmd
    ])

