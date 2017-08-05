module App.Update exposing (..)

import App.Pages exposing (pageHash)
import App.Routing exposing (Route(..), parseLocation)
import App.Messages exposing (Msg(..), Page(About, Calc))
import App.Models exposing (Model)
import Maybe exposing (map)
import Navigation
import Page.About
import Page.Calc
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

                     Home ->
                        ( { clearedModel | route = newRoute }, Cmd.none )

                     Page About ->
                        ( { clearedModel | route = newRoute, aboutPage = Just Page.About.initialModel  }, Cmd.none )

                     Page Calc ->
                        ( { clearedModel | route = newRoute, calcPage = Just Page.Calc.initialModel  }, Cmd.none )


        GoToPage p ->
            ( model, pageHash p
                      |> cons '#'
                      |> Navigation.newUrl )

        GoToHome ->
            ( model, Navigation.newUrl "#" )

        -- messages from pages
        AboutPageMsg m -> ( { model | aboutPage = map (Page.About.update m) model.aboutPage }, Cmd.none)
        CalcPageMsg m -> ( { model | calcPage = map (Page.Calc.update m) model.calcPage }, Cmd.none)
