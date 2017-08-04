module App.Pages exposing (..)

import App.Messages exposing (Msg(AboutPageMsg), Page(About))
import App.Models exposing (Model)
import Html exposing (Html)
import Page.About
import Page.Common

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
 ]

pageSpec : Page -> PageSpec
pageSpec page =
    let
      toView pageView pageMsg modelExtractor model =
            model
             |> modelExtractor
             |> Maybe.map pageView
             |> Maybe.map (Html.map pageMsg)
             |> Maybe.withDefault emptyNode

      toSubscriptions pageSubscriptions pageMsg modelExtractor model =
            model
             |> modelExtractor
             |> Maybe.map pageSubscriptions
             |> Maybe.map  (Sub.map pageMsg)
             |> Maybe.withDefault Sub.none

      toSpec info pageView pageSubscriptions pageMsg modelExtractor =
           {
             info = { info | description = Html.map pageMsg info.description }
            ,view = toView pageView pageMsg modelExtractor --currified form
            ,subscriptions = toSubscriptions pageSubscriptions pageMsg modelExtractor
           }

    in
        case page of
            -- add new pages here (the code is a little bit tricky but does the job fine)
            About -> toSpec Page.About.info Page.About.view Page.About.subscriptions AboutPageMsg (\model -> model.aboutPage)


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
