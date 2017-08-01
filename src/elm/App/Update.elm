module App.Update exposing (..)

import App.Routing exposing (Page(About, Home), Route(..), parseLocation)
import App.Messages exposing (Msg(..))
import App.Models exposing (Model)
import Maybe exposing (map)
import Navigation
import Page.About
import String exposing (cons)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location

                clearedModel = { model | aboutPage = Nothing }
            in
                case newRoute of
                     NotFoundRoute ->
                        ( { clearedModel | route = newRoute }, Cmd.none )

                     Page Home ->
                        ( { clearedModel | route = newRoute }, Cmd.none )

                     Page About ->
                        ( { clearedModel | route = newRoute, aboutPage = Just Page.About.initialModel  }, Cmd.none )


        GoToPage About ->
            ( model, Page.About.info
                      |> .hash
                      |> cons '#'
                      |> Navigation.newUrl )

        GoToPage Home ->
            ( model, Navigation.newUrl "/" )

        AboutPageMsg m -> ( { model | aboutPage = map (Page.About.update m) model.aboutPage }, Cmd.none)
