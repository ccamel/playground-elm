module Update exposing (..)

import Routing exposing (Page(About, Home), parseLocation)
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

        GoToPage About ->
            ( model, Navigation.newUrl "#about" )

        GoToPage Home ->
            ( model, Navigation.newUrl "/" )
