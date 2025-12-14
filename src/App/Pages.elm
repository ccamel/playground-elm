module App.Pages exposing
    ( PageSpec
    , clearAll
    , initPage
    , pageDate
    , pageDescription
    , pageFromSlug
    , pageGithubLink
    , pageHash
    , pageName
    , pageSubscriptions
    , pageView
    , pages
    , updateWithMsg
    )

import App.Flags exposing (Flags)
import App.Messages exposing (Msg(..), Page(..))
import App.Models exposing (Model, PagesModel)
import Dict exposing (Dict)
import Html exposing (Html)
import Lib.Page exposing (PageInfo)
import Maybe exposing (withDefault)
import Page.About
import Page.Asteroids
import Page.Calc
import Page.Dapp
import Page.DigitalClock
import Page.DoubleHelix
import Page.Glsl
import Page.Lissajous
import Page.Maze
import Page.Physics
import Page.SoundWaveToggle
import Page.Term
import Page.Terrain


type alias PageSpec =
    { page : Page
    , slug : String
    , info : PageInfo Msg
    , init : Flags -> Model -> ( Model, Cmd Msg )
    , update : Msg -> Model -> Maybe ( Model, Cmd Msg )
    , subscriptions : Model -> Sub Msg
    , view : Model -> Html Msg
    , clear : Model -> Model
    }


emptyNode : Html msg
emptyNode =
    Html.text ""


updatePages : (PagesModel -> PagesModel) -> Model -> Model
updatePages fn model =
    { model | pages = fn model.pages }


toSpec :
    Page
    -> PageInfo pageMsg
    -> (Flags -> ( pageModel, Cmd pageMsg ))
    -> (pageMsg -> pageModel -> ( pageModel, Cmd pageMsg ))
    -> (pageModel -> Html pageMsg)
    -> (pageModel -> Sub pageMsg)
    -> (pageMsg -> Msg)
    -> (Msg -> Maybe pageMsg)
    -> (Model -> Maybe pageModel)
    -> (Maybe pageModel -> Model -> Model)
    -> PageSpec
toSpec page info initFn updateFn viewFn subscriptionsFn wrap unwrap getPage setPage =
    { page = page
    , slug = info.hash
    , info =
        { name = info.name
        , hash = info.hash
        , date = info.date
        , description = Html.map wrap info.description
        , srcRel = info.srcRel
        }
    , init =
        \flags model ->
            let
                ( pageModel, pageCmd ) =
                    initFn flags
            in
            ( setPage (Just pageModel) model
            , Cmd.map wrap pageCmd
            )
    , update =
        \msg model ->
            unwrap msg
                |> Maybe.andThen
                    (\pageMsg ->
                        getPage model
                            |> Maybe.map
                                (\pageModel ->
                                    let
                                        ( nextModel, nextCmd ) =
                                            updateFn pageMsg pageModel
                                    in
                                    ( setPage (Just nextModel) model
                                    , Cmd.map wrap nextCmd
                                    )
                                )
                    )
    , subscriptions =
        \model ->
            getPage model
                |> Maybe.map (subscriptionsFn >> Sub.map wrap)
                |> Maybe.withDefault Sub.none
    , view =
        \model ->
            getPage model
                |> Maybe.map (viewFn >> Html.map wrap)
                |> Maybe.withDefault emptyNode
    , clear = \model -> setPage Nothing model
    }


specs : List PageSpec
specs =
    [ toSpec About
        Page.About.info
        Page.About.init
        Page.About.update
        Page.About.view
        Page.About.subscriptions
        AboutPageMsg
        (\msg ->
            case msg of
                AboutPageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.aboutPage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | aboutPage = maybePage }))
    , toSpec Calc
        Page.Calc.info
        (\_ -> Page.Calc.init)
        Page.Calc.update
        Page.Calc.view
        Page.Calc.subscriptions
        CalcPageMsg
        (\msg ->
            case msg of
                CalcPageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.calcPage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | calcPage = maybePage }))
    , toSpec Lissajous
        Page.Lissajous.info
        (\_ -> Page.Lissajous.init)
        Page.Lissajous.update
        Page.Lissajous.view
        Page.Lissajous.subscriptions
        LissajousPageMsg
        (\msg ->
            case msg of
                LissajousPageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.lissajousPage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | lissajousPage = maybePage }))
    , toSpec DigitalClock
        Page.DigitalClock.info
        (\_ -> Page.DigitalClock.init)
        Page.DigitalClock.update
        Page.DigitalClock.view
        Page.DigitalClock.subscriptions
        DigitalClockPageMsg
        (\msg ->
            case msg of
                DigitalClockPageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.digitalClockPage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | digitalClockPage = maybePage }))
    , toSpec Maze
        Page.Maze.info
        (\_ -> Page.Maze.init)
        Page.Maze.update
        Page.Maze.view
        Page.Maze.subscriptions
        MazePageMsg
        (\msg ->
            case msg of
                MazePageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.mazePage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | mazePage = maybePage }))
    , toSpec Physics
        Page.Physics.info
        (\_ -> Page.Physics.init)
        Page.Physics.update
        Page.Physics.view
        Page.Physics.subscriptions
        PhysicsPageMsg
        (\msg ->
            case msg of
                PhysicsPageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.physicsPage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | physicsPage = maybePage }))
    , toSpec Term
        Page.Term.info
        (\_ -> Page.Term.init)
        Page.Term.update
        Page.Term.view
        Page.Term.subscriptions
        TermPageMsg
        (\msg ->
            case msg of
                TermPageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.termPage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | termPage = maybePage }))
    , toSpec Asteroids
        Page.Asteroids.info
        (\_ -> Page.Asteroids.init)
        Page.Asteroids.update
        Page.Asteroids.view
        Page.Asteroids.subscriptions
        AsteroidsPageMsg
        (\msg ->
            case msg of
                AsteroidsPageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.asteroidsPage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | asteroidsPage = maybePage }))
    , toSpec Dapp
        Page.Dapp.info
        Page.Dapp.init
        Page.Dapp.update
        Page.Dapp.view
        Page.Dapp.subscriptions
        DappPageMsg
        (\msg ->
            case msg of
                DappPageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.dappPage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | dappPage = maybePage }))
    , toSpec SoundWaveToggle
        Page.SoundWaveToggle.info
        (\_ -> Page.SoundWaveToggle.init)
        Page.SoundWaveToggle.update
        Page.SoundWaveToggle.view
        Page.SoundWaveToggle.subscriptions
        SoundWaveTogglePageMsg
        (\msg ->
            case msg of
                SoundWaveTogglePageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.soundWaveTogglePage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | soundWaveTogglePage = maybePage }))
    , toSpec Glsl
        Page.Glsl.info
        (\_ -> Page.Glsl.init)
        Page.Glsl.update
        Page.Glsl.view
        Page.Glsl.subscriptions
        GlslPageMsg
        (\msg ->
            case msg of
                GlslPageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.glslPage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | glslPage = maybePage }))
    , toSpec Terrain
        Page.Terrain.info
        (\_ -> Page.Terrain.init)
        Page.Terrain.update
        Page.Terrain.view
        Page.Terrain.subscriptions
        TerrainPageMsg
        (\msg ->
            case msg of
                TerrainPageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.terrainPage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | terrainPage = maybePage }))
    , toSpec DoubleHelix
        Page.DoubleHelix.info
        (\_ -> Page.DoubleHelix.init)
        Page.DoubleHelix.update
        Page.DoubleHelix.view
        Page.DoubleHelix.subscriptions
        DoubleHelixPageMsg
        (\msg ->
            case msg of
                DoubleHelixPageMsg subMsg ->
                    Just subMsg

                _ ->
                    Nothing
        )
        (\model -> model.pages.doubleHelixPage)
        (\maybePage -> updatePages (\pageModels -> { pageModels | doubleHelixPage = maybePage }))
    ]


pageDict : Dict String PageSpec
pageDict =
    Dict.fromList (List.map (\spec -> ( spec.slug, spec )) specs)


slugDict : Dict String PageSpec
slugDict =
    Dict.fromList (List.map (\spec -> ( spec.slug, spec )) specs)


pages : List Page
pages =
    List.map .page specs


pageSpec : Page -> Maybe PageSpec
pageSpec target =
    let
        slug =
            case target of
                About ->
                    "about"

                Calc ->
                    "calc"

                Lissajous ->
                    "lissajous"

                DigitalClock ->
                    "digital-clock"

                Maze ->
                    "maze"

                Physics ->
                    "physics"

                Term ->
                    "term"

                Asteroids ->
                    "asteroids"

                Dapp ->
                    "dapp"

                SoundWaveToggle ->
                    "sound-wave-toggle"

                Glsl ->
                    "glsl"

                Terrain ->
                    "terrain"

                DoubleHelix ->
                    "double-helix"
    in
    Dict.get slug pageDict


pageFromSlug : String -> Maybe Page
pageFromSlug slug =
    Dict.get slug slugDict |> Maybe.map .page


pageName : Page -> String
pageName page =
    pageSpec page |> Maybe.map (.info >> .name) |> withDefault ""


pageDescription : Page -> Html Msg
pageDescription page =
    pageSpec page |> Maybe.map (.info >> .description) |> withDefault emptyNode


pageGithubLink : Page -> String
pageGithubLink page =
    pageSpec page
        |> Maybe.map (.info >> .srcRel)
        |> Maybe.map (\src -> "https://github.com/ccamel/playground-elm/blob/main/src/" ++ src)
        |> withDefault ""


pageHash : Page -> String
pageHash page =
    pageSpec page |> Maybe.map (.info >> .hash) |> withDefault ""


pageDate : Page -> String
pageDate page =
    pageSpec page |> Maybe.map (.info >> .date) |> withDefault ""


pageView : Page -> Model -> Html Msg
pageView page model =
    pageSpec page |> Maybe.map (\spec -> spec.view model) |> withDefault emptyNode


pageSubscriptions : Page -> Model -> Sub Msg
pageSubscriptions page model =
    pageSpec page |> Maybe.map (\spec -> spec.subscriptions model) |> withDefault Sub.none


initPage : Page -> Flags -> Model -> ( Model, Cmd Msg )
initPage page flags model =
    pageSpec page |> Maybe.map (\spec -> spec.init flags model) |> withDefault ( model, Cmd.none )


updateWithMsg : Msg -> Model -> ( Model, Cmd Msg )
updateWithMsg msg model =
    specs
        |> List.filterMap (\spec -> spec.update msg model)
        |> List.head
        |> withDefault ( model, Cmd.none )


clearAll : Model -> Model
clearAll model =
    List.foldl (\spec acc -> spec.clear acc) model specs
