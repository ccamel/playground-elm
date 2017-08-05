module App.Routing exposing (..)

import App.Messages exposing (Page(About, Calc))
import Navigation exposing (Location)
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
        , map (Page Calc) (s "calc" )
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute



