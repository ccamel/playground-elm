module Page.Euclid exposing (Model, Msg, info, init, subscriptions, update, view)

import Html exposing (Html)
import Lib.Page
import Markdown
import Svg


info : Lib.Page.PageInfo Msg
info =
    { name = "euclid"
    , hash = "euclid"
    , date = "2026-08-30"
    , description = Markdown.toHtml [] """
An experimental 2D vector playground for geometric construction, manipulation, and composable geometric expressions.
       """
    , srcRel = "Page/Euclid.elm"
    }


type Model
    = Model


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    ( Model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update NoOp model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view _ =
    Svg.svg [] []
