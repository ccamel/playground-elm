module App.Update exposing (..)

import App.Pages exposing (pageHash)
import App.Routing exposing (Route(..), toRoute)
import App.Messages exposing (Msg(..), Page(..))
import App.Models exposing (Model)
import Browser
import Browser.Navigation as Route
import Browser.Navigation as Nav
import Maybe exposing (withDefault)
import Page.About
import Page.Calc
import Page.DigitalClock
import Page.Lissajous
import Page.Maze
import String exposing (cons)
import Tuple exposing (first, second)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.External href ->
                    (model, Nav.load href )
                _ ->
                    (model, Cmd.none)
        UrlChanged location ->
            let
                newRoute =
                    toRoute location

                clearedModel = { model | aboutPage = Nothing }

                ( aboutModel, aboutCmd ) = Page.About.init
                ( calcModel, calcCmd ) = Page.Calc.init
                ( lissajousModel, lissajousCmd ) = Page.Lissajous.init
                ( digitalClockModel, digitalClockCmd ) = Page.DigitalClock.init
                ( mazeModel, mazeCmd ) = Page.Maze.init
            in
                case newRoute of
                     NotFoundRoute ->
                        ( { clearedModel | route = newRoute }, Cmd.none )

                     Home ->
                        ( { clearedModel | route = newRoute }, Cmd.none )

                     Page About ->
                        ( { clearedModel | route = newRoute, aboutPage = Just aboutModel  }, Cmd.map AboutPageMsg aboutCmd )

                     Page Calc ->
                        ( { clearedModel | route = newRoute, calcPage = Just calcModel  }, Cmd.map CalcPageMsg calcCmd )

                     Page Lissajous ->
                        ( { clearedModel | route = newRoute, lissajousPage = Just lissajousModel  }, Cmd.map LissajousPageMsg lissajousCmd )

                     Page DigitalClock ->
                        ( { clearedModel | route = newRoute, digitalClockPage = Just digitalClockModel  }, Cmd.map DigitalClockPageMsg digitalClockCmd )

                     Page Maze ->
                        ( { clearedModel | route = newRoute, mazePage = Just mazeModel  }, Cmd.map MazePageMsg mazeCmd )



        GoToPage p ->
            ( model, pageHash p
                      |> cons '#'
                      |> Route.pushUrl model.navKey )

        GoToHome ->
            ( model, Route.replaceUrl model.navKey "#" )

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

        MazePageMsg m ->
            model
              |> .mazePage
              |> Maybe.map (Page.Maze.update m) -- Maybe(mdl, Cmd msg)
              |> Maybe.map ( adapt
                              (\mdl -> {model | mazePage = Just mdl})
                              (Cmd.map MazePageMsg))
              |> withDefault (model, Cmd.none)

adapt : (m -> Model) -> (Cmd a -> Cmd Msg) -> (m, Cmd a) -> (Model, Cmd Msg)
adapt toModel toCmd modelCmd =
    let
        model = modelCmd |> first |> toModel
        cmd = modelCmd |> second |> toCmd
    in
        (model, cmd)
