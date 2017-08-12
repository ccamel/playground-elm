module Main exposing (..)

import App.Messages exposing (Msg(..))
import App.Models exposing (Model, initialModel)
import App.Subscriptions exposing (subscriptions)
import Navigation exposing (Location)
import App.Routing exposing (Route)
import App.Update exposing (update)
import App.View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            App.Routing.parseLocation location
    in
        initialModel currentRoute



-- MAIN


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
