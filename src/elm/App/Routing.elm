module App.Routing exposing (..)

import App.Messages exposing (Page(About))
import Navigation exposing (Location)
import Page.About
import UrlParser exposing (..)

type Route
    = Home
    | Page Page
    | NotFoundRoute

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map (Home) top
        , map (Page About) (s "about" )
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute



