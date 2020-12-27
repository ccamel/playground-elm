module App.Pages exposing (..)

import App.Messages exposing (Msg(..), Page(..))
import App.Models exposing (Model)
import Html exposing (Html)
import Page.About
import Page.Calc
import Page.Common
import Page.DigitalClock
import Page.Lissajous
import Page.Maze
import Page.Physics

emptyNode : Html msg
emptyNode = Html.text ""

-- PageSpec holds the whole specification about a page, including basic information (name, description, source) and a function
-- to the view and the subscriptions.
-- This way, it becomes easy to add new pages without changing the code everywhere.
type alias PageSpec = {
      info : Page.Common.PageInfo Msg
    , view : Model -> Html Msg
    , subscriptions: Model -> Sub Msg
 }

pages : List Page
pages = [
      About
    -- add new pages here:
    , Calc
    , Lissajous
    , DigitalClock
    , Maze
    , Cloth
 ]

toView aPageView pageMsg modelExtractor model =
      model
        |> modelExtractor
        |> Maybe.map aPageView
        |> Maybe.map (Html.map pageMsg)
        |> Maybe.withDefault emptyNode

toSubscriptions aPageSubscriptions pageMsg modelExtractor model =
      model
        |> modelExtractor
        |> Maybe.map aPageSubscriptions
        |> Maybe.map  (Sub.map pageMsg)
        |> Maybe.withDefault Sub.none

-- toSpec: (Record {}) -> (Msg) -> (Model -> Html Msg) -> (Model -> Sub Msg) -> c -> (x -> y)
toSpec info aPageView aPageSubscriptions pageMsg modelExtractor =
      let
        desc = info.description
        info2 = {
                      name = info.name
                    , hash = info.hash
                    , description = Html.map pageMsg desc
                    , srcRel = info.srcRel
                }
      in
        {
          info = info2
          ,view = toView aPageView pageMsg modelExtractor --currified form
          ,subscriptions = toSubscriptions aPageSubscriptions pageMsg modelExtractor
        }

pageSpec : Page -> PageSpec
pageSpec page =
        case page of
            -- add new pages here (the code is a little bit tricky but does the job fine)
            About -> toSpec Page.About.info Page.About.view Page.About.subscriptions  (\x -> AboutPageMsg x) (\model -> model.aboutPage)
            Calc -> toSpec Page.Calc.info Page.Calc.view Page.Calc.subscriptions (\x -> CalcPageMsg x) (\model -> model.calcPage)
            Lissajous -> toSpec Page.Lissajous.info Page.Lissajous.view Page.Lissajous.subscriptions LissajousPageMsg (\model -> model.lissajousPage)
            DigitalClock -> toSpec Page.DigitalClock.info Page.DigitalClock.view Page.DigitalClock.subscriptions DigitalClockPageMsg (\model -> model.digitalClockPage)
            Maze -> toSpec Page.Maze.info Page.Maze.view Page.Maze.subscriptions MazePageMsg (\model -> model.mazePage)
            Cloth -> toSpec Page.Physics.info Page.Physics.view Page.Physics.subscriptions ClothPageMsg (\model -> model.ropePage)

pageName : Page -> String
pageName page = pageSpec page
                 |> .info
                 |> .name

pageDescription : Page -> Html Msg
pageDescription page = pageSpec page
                 |> .info
                 |> .description

pageSrc : Page -> String
pageSrc page = pageSpec page
                 |> .info
                 |> .srcRel

pageHash : Page -> String
pageHash page = pageSpec page
                 |> .info
                 |> .hash

pageView : Page -> Model -> Html Msg
pageView page = pageSpec page
                 |> .view

pageSubscriptions : Page -> Model -> Sub Msg
pageSubscriptions page = pageSpec page
                           |> .subscriptions
