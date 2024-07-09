module Main exposing (main)

import App.Flags exposing (Flags)
import App.Messages exposing (Msg(..))
import App.Models exposing (Model)
import App.Subscriptions exposing (subscriptions)
import App.Update exposing (init, update)
import App.View exposing (view)
import Browser



-- MAIN


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
