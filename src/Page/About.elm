module Page.About exposing (Model, Msg, info, init, subscriptions, update, view)

import Html exposing (Html, a, div, h2, h3, h4, hr, i, p, section, span, text)
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


type alias Msg =
    ()


update : Msg -> Model -> ( Model, Cmd Msg )
update _ _ =
    ( {}, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view _ =
    div
        [ class "container"
        ]
        [ div [ class "section is-medium has-text-centered" ]
            [ h2
                [ class "title is-size-2-desktop has-text-white"
                ]
                [ span []
                    [ text "playground"
                    , text " "
                    , span [ class "elm-pipe" ] [ text "|" ]
                    , span [ class "elm-gt" ] [ text ">" ]
                    , text " "
                    , a [ href "http://elm-lang.org/" ] [ text "elm" ]
                    ]
                ]
            , h3
                [ class "subtitle has-text-white"
                ]
                [ text "Explore, study and assess the "
                , a [ href "http://elm-lang.org/" ] [ text "elm language" ]
                , text " a delightful language for reliable webapps."
                ]
            ]
        , div
            [ class "columns is-centered about"
            ]
            [ div
                [ class "column is-9"
                ]
                [ div
                    [ class "columns"
                    ]
                    [ div
                        [ class "column is-6"
                        ]
                        [ h4
                            [ class "title is-4 has-text-white"
                            ]
                            [ i
                                [ attribute "aria-hidden" "true"
                                , class "fa fa-child"
                                ]
                                []
                            , text " Simple"
                            ]
                        , p [ class "has-text-light" ]
                            [ text "Fairly simple and understandable. Every showcase is implemented in a single elm file." ]
                        ]
                    , div
                        [ class "column is-6"
                        ]
                        [ h4
                            [ class "title is-4 has-text-white"
                            ]
                            [ i
                                [ attribute "aria-hidden" "true"
                                , class "fa fa-search"
                                ]
                                []
                            , text " Exploratory"
                            ]
                        , p [ class "has-text-light" ]
                            [ text "Highlight some aspects of the elm language, like immutability, reactiveness, performance and interoperability with other JS libraries." ]
                        , p [ class "has-text-light" ]
                            [ text "Explore some architectural/design patterns around reactive static/serverless SPA." ]
                        ]
                    ]
                , div
                    [ class "columns"
                    ]
                    [ div
                        [ class "column is-6"
                        ]
                        [ h4
                            [ class "title is-4 has-text-white"
                            ]
                            [ i
                                [ attribute "aria-hidden" "true"
                                , class "fa fa-futbol-o"
                                ]
                                []
                            , text " Playable"
                            ]
                        , p [ class "has-text-light" ]
                            [ text "As much as possible, provides a useful and functional content." ]
                        ]
                    , div
                        [ class "column is-6"
                        ]
                        [ h4
                            [ class "title is-4 has-text-white"
                            ]
                            [ i
                                [ attribute "aria-hidden" "true"
                                , class "fa fa-arrows-alt-v"
                                ]
                                []
                            , text " Scalable"
                            ]
                        , p [ class "has-text-light" ]
                            [ text "The structure of the playground is designed to easily accommodate additional examples and showcases." ]
                        , p [ class "has-text-light" ]
                            [ text " Contributors can effortlessly expand the repository, ensuring it remains a relevant and up-to-date resource for learners and enthusiasts." ]
                        ]
                    ]
                ]
            ]
        ]
