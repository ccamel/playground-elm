module App.Update exposing (..)

import App.Messages exposing (Msg(..), Page(..))
import App.Models exposing (Model, emptyPagesModel)
import App.Pages exposing (pageHash)
import App.Routing exposing (Route(..), toRoute)
import Browser
import Browser.Navigation as Nav
import Maybe exposing (withDefault)
import Page.About
import Page.Calc
import Page.DigitalClock
import Page.Lissajous
import Page.Maze
import Page.Physics
import String exposing (cons)
import Tuple exposing (first, second)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        pages =
            model.pages
    in
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.External href ->
                    ( model, Nav.load href )

                _ ->
                    ( model, Cmd.none )

        UrlChanged location ->
            let
                newRoute =
                    toRoute model.flags.basePath location

                clearedModel =
                    { model | pages = emptyPagesModel }

                ( aboutModel, aboutCmd ) =
                    Page.About.init

                ( calcModel, calcCmd ) =
                    Page.Calc.init

                ( lissajousModel, lissajousCmd ) =
                    Page.Lissajous.init

                ( digitalClockModel, digitalClockCmd ) =
                    Page.DigitalClock.init

                ( mazeModel, mazeCmd ) =
                    Page.Maze.init

                ( physicsModel, physicsCmd ) =
                    Page.Physics.init
            in
            case newRoute of
                NotFoundRoute ->
                    ( { clearedModel | route = newRoute }, Cmd.none )

                Home ->
                    ( { clearedModel | route = newRoute }, Cmd.none )

                Page About ->
                    ( { clearedModel | route = newRoute, pages = { emptyPagesModel | aboutPage = Just aboutModel } }, Cmd.map AboutPageMsg aboutCmd )

                Page Calc ->
                    ( { clearedModel | route = newRoute, pages = { emptyPagesModel | calcPage = Just calcModel } }, Cmd.map CalcPageMsg calcCmd )

                Page Lissajous ->
                    ( { clearedModel | route = newRoute, pages = { emptyPagesModel | lissajousPage = Just lissajousModel } }, Cmd.map LissajousPageMsg lissajousCmd )

                Page DigitalClock ->
                    ( { clearedModel | route = newRoute, pages = { emptyPagesModel | digitalClockPage = Just digitalClockModel } }, Cmd.map DigitalClockPageMsg digitalClockCmd )

                Page Maze ->
                    ( { clearedModel | route = newRoute, pages = { emptyPagesModel | mazePage = Just mazeModel } }, Cmd.map MazePageMsg mazeCmd )

                Page Physics ->
                    ( { clearedModel | route = newRoute, pages = { emptyPagesModel | physicsPage = Just physicsModel } }, Cmd.map PhysicsPageMsg physicsCmd )

        GoToPage p ->
            ( model
            , pageHash p
                |> cons '#'
                |> Nav.pushUrl model.navKey
            )

        GoToHome ->
            ( model, Nav.replaceUrl model.navKey "#" )

        -- messages from pages
        AboutPageMsg m ->
            model
                |> .pages
                |> .aboutPage
                |> Maybe.map (Page.About.update m)
                |> Maybe.map
                    (adapt
                        (\mdl -> { model | pages = { pages | aboutPage = Just mdl } })
                        (Cmd.map AboutPageMsg)
                    )
                |> withDefault ( model, Cmd.none )

        CalcPageMsg m ->
            model
                |> .pages
                |> .calcPage
                |> Maybe.map (Page.Calc.update m)
                |> Maybe.map
                    (adapt
                        (\mdl -> { model | pages = { pages | calcPage = Just mdl } })
                        (Cmd.map CalcPageMsg)
                    )
                |> withDefault ( model, Cmd.none )

        LissajousPageMsg m ->
            model
                |> .pages
                |> .lissajousPage
                |> Maybe.map (Page.Lissajous.update m)
                |> Maybe.map
                    (adapt
                        (\mdl -> { model | pages = { pages | lissajousPage = Just mdl } })
                        (Cmd.map LissajousPageMsg)
                    )
                |> withDefault ( model, Cmd.none )

        DigitalClockPageMsg m ->
            model
                |> .pages
                |> .digitalClockPage
                |> Maybe.map (Page.DigitalClock.update m)
                |> Maybe.map
                    (adapt
                        (\mdl -> { model | pages = { pages | digitalClockPage = Just mdl } })
                        (Cmd.map DigitalClockPageMsg)
                    )
                |> withDefault ( model, Cmd.none )

        MazePageMsg m ->
            model
                |> .pages
                |> .mazePage
                |> Maybe.map (Page.Maze.update m)
                |> Maybe.map
                    (adapt
                        (\mdl -> { model | pages = { pages | mazePage = Just mdl } })
                        (Cmd.map MazePageMsg)
                    )
                |> withDefault ( model, Cmd.none )

        PhysicsPageMsg m ->
            model
                |> .pages
                |> .physicsPage
                |> Maybe.map (Page.Physics.update m)
                |> Maybe.map
                    (adapt
                        (\mdl -> { model | pages = { pages | physicsPage = Just mdl } })
                        (Cmd.map PhysicsPageMsg)
                    )
                |> withDefault ( model, Cmd.none )


adapt : (m -> Model) -> (Cmd a -> Cmd Msg) -> ( m, Cmd a ) -> ( Model, Cmd Msg )
adapt toModel toCmd modelCmd =
    let
        model =
            modelCmd |> first |> toModel

        cmd =
            modelCmd |> second |> toCmd
    in
    ( model, cmd )
