module App.Update exposing (..)

import App.Pages exposing (pageHash)
import App.Routing exposing (Route(..), parseLocation)
import App.Messages exposing (Msg(..), Page(About, Calc, DigitalClock, Lissajous))
import App.Models exposing (Model)
import Maybe exposing (map, withDefault)
import Navigation
import Page.About
import Page.Calc
import Page.DigitalClock
import Page.Lissajous
import String exposing (cons)
import Tuple exposing (first, second)


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
                        ( { clearedModel | route = newRoute, aboutPage = Just Page.About.initialModel  }, Cmd.map AboutPageMsg Page.About.initialCmd )

                     Page Calc ->
                        ( { clearedModel | route = newRoute, calcPage = Just Page.Calc.initialModel  }, Cmd.map CalcPageMsg Page.Calc.initialCmd )

                     Page Lissajous ->
                        ( { clearedModel | route = newRoute, lissajousPage = Just Page.Lissajous.initialModel  }, Cmd.map LissajousPageMsg Page.Lissajous.initialCmd )

                     Page DigitalClock ->
                        ( { clearedModel | route = newRoute, digitalClockPage = Just Page.DigitalClock.initialModel  }, Cmd.map DigitalClockPageMsg Page.DigitalClock.initialCmd )



        GoToPage p ->
            ( model, pageHash p
                      |> cons '#'
                      |> Navigation.newUrl )

        GoToHome ->
            ( model, Navigation.newUrl "#" )

        -- messages from pages
        AboutPageMsg m ->
            model
              |> .aboutPage
              |> Maybe.map (Page.About.update m) -- Maybe(mdl, Cmd msg)
              |> Maybe.map ( adapt
                              (\mdl -> {model | aboutPage = Just mdl})
                              (Cmd.map AboutPageMsg))
              |> withDefault (model, Cmd.none)

        CalcPageMsg m ->
            model
              |> .calcPage
              |> Maybe.map (Page.Calc.update m) -- Maybe(mdl, Cmd msg)
              |> Maybe.map ( adapt
                              (\mdl -> {model | calcPage = Just mdl})
                              (Cmd.map CalcPageMsg))
              |> withDefault (model, Cmd.none)

        LissajousPageMsg m ->
            model
              |> .lissajousPage
              |> Maybe.map (Page.Lissajous.update m) -- Maybe(mdl, Cmd msg)
              |> Maybe.map ( adapt
                              (\mdl -> {model | lissajousPage = Just mdl})
                              (Cmd.map LissajousPageMsg))
              |> withDefault (model, Cmd.none)

        DigitalClockPageMsg m ->
            model
              |> .digitalClockPage
              |> Maybe.map (Page.DigitalClock.update m) -- Maybe(mdl, Cmd msg)
              |> Maybe.map ( adapt
                              (\mdl -> {model | digitalClockPage = Just mdl})
                              (Cmd.map DigitalClockPageMsg))
              |> withDefault (model, Cmd.none)


adapt : (m -> Model) -> (Cmd a -> Cmd Msg) -> (m, Cmd a) -> (Model, Cmd Msg)
adapt toModel toCmd modelCmd =
    let
        model = modelCmd |> first |> toModel
        cmd = modelCmd |> second |> toCmd
    in
        (model, cmd)
