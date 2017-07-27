module View exposing (..)

import Html exposing (Html, div, text, button, h1, p)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (Page(About, Home), Route(..))


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Page Home ->
            mainPage

        Page About ->
            aboutPage

        NotFoundRoute ->
            notFoundView


mainPage : Html Msg
mainPage =
    div [ class "jumbotron" ]
        [ div [ class "container" ]
            [ h1 [] [ text "Welcome to Elm Main page" ]
            , p [] [ text "A delightful language for reliable webapps." ]
            , button [ onClick (GoToPage About), class "btn btn-primary btn-lg" ] [ text "Go To About Page" ]
            ]
        ]


aboutPage : Html Msg
aboutPage =
    div [ class "jumbotron" ]
        [ div [ class "container" ]
            [ h1 [] [ text "This is <about> page" ]
            , button [ onClick (GoToPage Home), class "btn btn-primary btn-lg" ] [ text "Go To Home Page" ]
            ]
        ]


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not Found" ]
