module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)


type Route
    = MainPage
    | AboutPage
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map MainPage top
        , map AboutPage (s "about")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
