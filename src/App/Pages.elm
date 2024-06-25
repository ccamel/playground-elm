module App.Pages exposing (PageSpec, pageDescription, pageHash, pageName, pageSrc, pageSubscriptions, pageView, pages)

import App.Messages exposing (Msg(..), Page(..))
import App.Models exposing (Model)
import Html exposing (Html)
import Page.About
import Page.Asteroids
import Page.Calc
import Lib.Page exposing (PageInfo)
import Page.DigitalClock
import Page.Lissajous
import Page.Maze
import Page.Physics
import Page.Term


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


pageHash : Page -> String
pageHash page =
    pageSpec page
        |> .info
        |> .hash


pageView : Page -> Model -> Html Msg
pageView page =
    pageSpec page
        |> .view


pageSubscriptions : Page -> Model -> Sub Msg
pageSubscriptions page =
    pageSpec page
        |> .subscriptions
