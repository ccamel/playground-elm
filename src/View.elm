module View exposing (..)

import Html exposing (Html, div, text, button, h1, p)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        MainPage ->
            mainPage

        AboutPage ->
            aboutPage

        NotFoundRoute ->
            notFoundView


mainPage : Html Msg
mainPage =
    div [ class "jumbotron" ]
        [ div [ class "container" ]
            [ h1 [] [ text "Welcome to Elm Main page" ]
            , p [] [ text "A delightful language for reliable webapps." ]
            , button [ onClick GoToAboutPage, class "btn btn-primary btn-lg" ] [ text "Go To About Page" ]
            ]
        ]


aboutPage : Html Msg
aboutPage =
    div [ class "jumbotron" ]
        [ div [ class "container" ]
            [ h1 [] [ text "This is <about> page" ]
            , button [ onClick GoToMainPage, class "btn btn-primary btn-lg" ] [ text "Go To About Page" ]
            ]
        ]


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not Found" ]
