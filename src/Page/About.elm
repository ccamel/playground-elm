module Page.About exposing (..)

import Html exposing (Html, a, div, h2, hr, i, p, text)
import Html.Attributes exposing (attribute, class, href, style)
import Markdown
import Page.Common



-- PAGE INFO


info : Page.Common.PageInfo Msg
info =
    { name = "about"
    , hash = "about"
    , description = Markdown.toHtml [ class "info" ] """

A very simple and minimal showcase that is used to lay the foundations of the navigation/routing (*and to test that the whole site works correctly*)
       """
    , srcRel = "Page/About.elm"
    }



-- MODEL


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}
    , Cmd.none
    )



-- UPDATE


type Msg
    = Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Reset ->
            init



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view _ =
    div [ class "container" ]
        [ hr [] []
        , p [ class "text-muted" ]
            [ text "The purpose of this playground is to "
            , i []
                [ text "explore" ]
            , text ", "
            , i []
                [ text "study" ]
            , text " and "
            , i []
                [ text "assess" ]
            , text " the "
            , a [ href "http://elm-lang.org/" ]
                [ text "elm language" ]
            , text " — a delightful language for reliable webapps."
            ]
        , p [ class "text-muted" ]
            [ text "The showcases are intended to be:" ]
        , div [ class "row", style "padding-top" "2em" ]
            [ div [ class "col-lg-4" ]
                [ i [ attribute "aria-hidden" "true", class "fa fa-child fa-3x iconic" ]
                    []
                , h2 [ style "padding-top" "1em" ]
                    [ text "» simple" ]
                , p []
                    [ text "Fairly simple and understandable. Every showcase is implemented in a single elm file."
                    ]
                ]
            , div [ class "col-lg-4" ]
                [ i [ attribute "aria-hidden" "true", class "fa fa-search fa-3x iconic" ]
                    []
                , h2 [ style "padding-top" "1em" ]
                    [ text "» exploratory" ]
                , p []
                    [ text "Highlight some aspects of the "
                    , a [ href "http://elm-lang.org/" ]
                        [ text "elm" ]
                    , text " language, like immutability, reactiveness, performance and interoperability with other JS libraries."
                    ]
                , p []
                    [ text "Explore some architectural/design patterns around reactive static/serverless "
                    , a [ href "https://en.wikipedia.org/wiki/Single-page_application" ]
                        [ text "SPA" ]
                    , text "."
                    ]
                ]
            , div [ class "col-lg-4" ]
                [ i [ attribute "aria-hidden" "true", class "fa fa-futbol-o fa-3x iconic" ]
                    []
                , h2 [ style "padding-top" "1em" ]
                    [ text "» playable" ]
                , p []
                    [ text "As much as possible, provides a useful and functional content."
                    ]
                ]
            ]
        ]
