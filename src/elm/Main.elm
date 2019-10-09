module Main exposing (..)

import App.Messages exposing (Msg(..))
import App.Models exposing (Model, initialModel)
import App.Subscriptions exposing (subscriptions)
import App.Routing exposing (Route)
import App.Update exposing (update)
import App.View exposing (view)
import Browser.Navigation as Nav
import Json.Decode as Decode exposing (Value)
import Browser
import Url exposing (Url)

init : flags -> Url -> Nav.Key -> (Model, Cmd Msg)
init flags url navKey =
    let
        currentRoute =
            App.Routing.toRoute url
    in
        initialModel navKey currentRoute

-- MAIN
main : Program Value Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }
