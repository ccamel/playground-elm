module App.Pages exposing (PageSpec, pageDate, pageDescription, pageGithubLink, pageHash, pageName, pageSubscriptions, pageView, pages)

import App.Messages exposing (Msg(..), Page(..))
import App.Models exposing (Model)
import Html exposing (Html)
import Lib.Page exposing (PageInfo)
import Page.About
import Page.Asteroids
import Page.Calc
import Page.Dapp
import Page.DigitalClock
import Page.Glsl
import Page.Lissajous
import Page.Maze
import Page.Physics
import Page.SoundWaveToggle
import Page.Term
import Page.Terrain


emptyNode : Html msg
emptyNode =
    Html.text ""


{-| PageSpec holds the whole specification about a page, including basic information (name, description, source) and a function
to the view and the subscriptions.
This way, it becomes easy to add new pages without changing the code everywhere.
-}
type alias PageSpec =
    { info : PageInfo Msg
    , view : Model -> Html Msg
    , subscriptions : Model -> Sub Msg
    }


pages : List Page
pages =
    [ About

    -- add new pages here:
    , Calc
    , Lissajous
    , DigitalClock
    , Maze
    , Physics
    , Term
    , Asteroids
    , Dapp
    , SoundWaveToggle
    , Glsl
    , Terrain
    ]


toView : (a -> Html b) -> (b -> msg) -> (d -> Maybe a) -> d -> Html msg
toView aPageView pageMsg modelExtractor model =
    model
        |> modelExtractor
        |> Maybe.map aPageView
        |> Maybe.map (Html.map pageMsg)
        |> Maybe.withDefault emptyNode


toSubscriptions : (a -> Sub b) -> (b -> msg) -> (d -> Maybe a) -> d -> Sub msg
toSubscriptions aPageSubscriptions pageMsg modelExtractor model =
    model
        |> modelExtractor
        |> Maybe.map aPageSubscriptions
        |> Maybe.map (Sub.map pageMsg)
        |> Maybe.withDefault Sub.none


toSpec : PageInfo msg -> (model -> Html msg) -> (model -> Sub msg) -> (msg -> Msg) -> (Model -> Maybe model) -> PageSpec
toSpec info aPageView aPageSubscriptions pageMsg modelExtractor =
    { info =
        { name = info.name
        , hash = info.hash
        , date = info.date
        , description = Html.map pageMsg info.description
        , srcRel = info.srcRel
        }
    , view = toView aPageView pageMsg modelExtractor --currified form
    , subscriptions = toSubscriptions aPageSubscriptions pageMsg modelExtractor
    }


pageSpec : Page -> PageSpec
pageSpec page =
    case page of
        -- add new pages here (the code is a little bit tricky but does the job fine)
        About ->
            toSpec Page.About.info Page.About.view Page.About.subscriptions (\x -> AboutPageMsg x) (\model -> model.pages.aboutPage)

        Calc ->
            toSpec Page.Calc.info Page.Calc.view Page.Calc.subscriptions (\x -> CalcPageMsg x) (\model -> model.pages.calcPage)

        Lissajous ->
            toSpec Page.Lissajous.info Page.Lissajous.view Page.Lissajous.subscriptions LissajousPageMsg (\model -> model.pages.lissajousPage)

        DigitalClock ->
            toSpec Page.DigitalClock.info Page.DigitalClock.view Page.DigitalClock.subscriptions DigitalClockPageMsg (\model -> model.pages.digitalClockPage)

        Maze ->
            toSpec Page.Maze.info Page.Maze.view Page.Maze.subscriptions MazePageMsg (\model -> model.pages.mazePage)

        Physics ->
            toSpec Page.Physics.info Page.Physics.view Page.Physics.subscriptions PhysicsPageMsg (\model -> model.pages.physicsPage)

        Term ->
            toSpec Page.Term.info Page.Term.view Page.Term.subscriptions TermPageMsg (\model -> model.pages.termPage)

        Asteroids ->
            toSpec Page.Asteroids.info Page.Asteroids.view Page.Asteroids.subscriptions AsteroidsPageMsg (\model -> model.pages.asteroidsPage)

        Dapp ->
            toSpec Page.Dapp.info Page.Dapp.view Page.Dapp.subscriptions DappPageMsg (\model -> model.pages.dappPage)

        SoundWaveToggle ->
            toSpec Page.SoundWaveToggle.info Page.SoundWaveToggle.view Page.SoundWaveToggle.subscriptions SoundWaveTogglePageMsg (\model -> model.pages.soundWaveTogglePage)

        Glsl ->
            toSpec Page.Glsl.info Page.Glsl.view Page.Glsl.subscriptions GlslPageMsg (\model -> model.pages.glslPage)

        Terrain ->
            toSpec Page.Terrain.info Page.Terrain.view Page.Terrain.subscriptions TerrainPageMsg (\model -> model.pages.terrainPage)


pageName : Page -> String
pageName page =
    pageSpec page
        |> .info
        |> .name


pageDescription : Page -> Html Msg
pageDescription page =
    pageSpec page
        |> .info
        |> .description


pageSrc : Page -> String
pageSrc page =
    pageSpec page
        |> .info
        |> .srcRel


pageGithubLink : Page -> String
pageGithubLink page =
    "https://github.com/ccamel/playground-elm/blob/main/src/" ++ pageSrc page


pageHash : Page -> String
pageHash page =
    pageSpec page
        |> .info
        |> .hash


pageDate : Page -> String
pageDate page =
    pageSpec page
        |> .info
        |> .date


pageView : Page -> Model -> Html Msg
pageView page =
    pageSpec page
        |> .view


pageSubscriptions : Page -> Model -> Sub Msg
pageSubscriptions page =
    pageSpec page
        |> .subscriptions
