module App.Update exposing (initialModel, update)

import App.Messages exposing (Msg(..), Page(..))
import App.Models exposing (Flags, Model, PagesModel, emptyPagesModel)
import App.Pages exposing (pageHash)
import App.Routing exposing (Route(..), toRoute)
import Browser
import Browser.Navigation as Nav
import Maybe exposing (withDefault)
import Page.About
import Page.Asteroids
import Page.Calc
import Page.DigitalClock
import Page.Lissajous
import Page.Maze
import Page.Physics
import Page.Term
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

                ( termModel, termCmd ) =
                    Page.Term.init

                ( asteroidsModel, asteroidsCmd ) =
                    Page.Asteroids.init
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

                Page Term ->
                    ( { clearedModel | route = newRoute, pages = { emptyPagesModel | termPage = Just termModel } }, Cmd.map TermPageMsg termCmd )

                Page Asteroids ->
                    ( { clearedModel | route = newRoute, pages = { emptyPagesModel | asteroidsPage = Just asteroidsModel } }, Cmd.map AsteroidsPageMsg asteroidsCmd )

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
            convert model m .aboutPage Page.About.update (\mdl -> { model | pages = { pages | aboutPage = Just mdl } }) AboutPageMsg

        CalcPageMsg m ->
            convert model m .calcPage Page.Calc.update (\mdl -> { model | pages = { pages | calcPage = Just mdl } }) CalcPageMsg

        LissajousPageMsg m ->
            convert model m .lissajousPage Page.Lissajous.update (\mdl -> { model | pages = { pages | lissajousPage = Just mdl } }) LissajousPageMsg

        DigitalClockPageMsg m ->
            convert model m .digitalClockPage Page.DigitalClock.update (\mdl -> { model | pages = { pages | digitalClockPage = Just mdl } }) DigitalClockPageMsg

        MazePageMsg m ->
            convert model m .mazePage Page.Maze.update (\mdl -> { model | pages = { pages | mazePage = Just mdl } }) MazePageMsg

        PhysicsPageMsg m ->
            convert model m .physicsPage Page.Physics.update (\mdl -> { model | pages = { pages | physicsPage = Just mdl } }) PhysicsPageMsg

        TermPageMsg m ->
            convert model m .termPage Page.Term.update (\mdl -> { model | pages = { pages | termPage = Just mdl } }) TermPageMsg

        AsteroidsPageMsg m ->
            convert model m .asteroidsPage Page.Asteroids.update (\mdl -> { model | pages = { pages | asteroidsPage = Just mdl } }) AsteroidsPageMsg


initialModel : Flags -> Nav.Key -> Route -> ( Model, Cmd App.Messages.Msg )
initialModel flags navKey route =
    let
        model =
            { flags = flags
            , route = route
            , navKey = navKey

            -- models for pages
            , pages = emptyPagesModel
            }
    in
    case route of
        NotFoundRoute ->
            update GoToHome model

        Home ->
            update GoToHome model

        Page p ->
            update (GoToPage p) model


convert : Model -> b -> (PagesModel -> Maybe.Maybe a) -> (b -> a -> ( m, Cmd c )) -> (m -> Model) -> (c -> Msg) -> ( Model, Cmd Msg )
convert model m selector2 updater applier msg =
    model
        |> .pages
        |> selector2
        |> Maybe.map (updater m)
        |> Maybe.map
            (adapt
                applier
                (Cmd.map msg)
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
