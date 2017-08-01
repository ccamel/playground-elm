module App.View exposing (..)

import Html exposing (Html, a, button, div, h1, img, p, text)
import Html.Attributes exposing (alt, attribute, class, href, src)
import Html.Events exposing (onClick)
import App.Messages exposing (Msg(..))
import App.Models exposing (Model)
import App.Routing exposing (Page(About, Home), Route(..))
import Page.About
import Page.Common

emptyNode = Html.text ""

view : Model -> Html Msg
view model =
    div []
        [
            div [ class "jumbotron" ]
                [
                  a [ href "https://github.com/ccamel/playground-elm" ]
                          [ img [ alt "Fork me on GitHub",
                                  attribute "data:data-canonical-src" "https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png"
                                , src "https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67"
                                , attribute "style" "position: absolute; top: 0; right: 0; border: 0;"
                                ]
                             []
                          , text ""
                          ],

                    div [ class "container" ]
                    [
                        page model
                    ]
                ]
        ]


page : Model -> Html Msg
page model =
        case model.route of
            Page Home ->
                homePage

            Page About ->
                case model.aboutPage of
                    Just p ->
                        Html.map AboutPageMsg (Page.About.view p)
                    Nothing ->
                        emptyNode

            NotFoundRoute ->
                notFoundView


homePage : Html Msg
homePage =
        div []
        [
           h1 [] [ text "Welcome to Elm Main page" ]
            , p [] [ text "A delightful language for reliable webapps." ]
            , button [ onClick (GoToPage About), class "btn btn-primary btn-lg" ] [ text "Go To About Page" ]
            , Html.map AboutPageMsg (.description Page.About.info)
            ]

notFoundView : Html msg
notFoundView =
    div []
        [ text "Not Found" ]
