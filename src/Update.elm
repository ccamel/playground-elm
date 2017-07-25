module Update exposing (..)

import Routing exposing (parseLocation)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Navigation


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        GoToAboutPage ->
            ( model, Navigation.newUrl "#about" )

        GoToMainPage ->
            ( model, Navigation.newUrl "/" )
