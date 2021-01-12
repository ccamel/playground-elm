module Page.Asteroids exposing (..)

import Html exposing (Html, div, hr, p)
import Html.Attributes exposing (class)
import Markdown
import Page.Common



-- PAGE INFO


info : Page.Common.PageInfo Msg
info =
    { name = "asteroids"
    , hash = "asteroids"
    , description = Markdown.toHtml [ class "info" ] """

A simple Asteroids clone in [Elm](https://elm-lang.org/).
       """
    , srcRel = "Page/Asteroids.elm"
    }



-- MODEL


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}
    , Cmd.batch
        []
    )



-- UPDATE


type Msg
    = Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Reset ->
            init



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ hr [] []
        , p [ class "text-muted" ]
            [ Markdown.toHtml [ class "info" ] """
Simple Asteroids clone in [Elm](https://elm-lang.org/) .
"""
            ]
        ]
