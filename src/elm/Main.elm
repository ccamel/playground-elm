module Main exposing (..)

import App.Messages exposing (Msg(..))
import App.Models exposing (Model, initialModel)
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
        ( initialModel currentRoute, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
