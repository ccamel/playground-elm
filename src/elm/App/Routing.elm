module App.Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)


type Page
    = Home
    | About

type Route
    = Page Page
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map (Page Home) top
        , map (Page About) (s "about")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
