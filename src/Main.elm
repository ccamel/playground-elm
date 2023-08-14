module Main exposing (main)

import App.Messages exposing (Msg(..))
import App.Models exposing (Flags, Model)
import App.Routing
import App.Subscriptions exposing (subscriptions)
import App.Update exposing (initialModel, update)
import App.View exposing (view)
import Browser
import Browser.Navigation as Nav
import Url exposing (Url)


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    let
        currentRoute =
            App.Routing.toRoute flags.basePath url
    in
    initialModel flags navKey currentRoute



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
