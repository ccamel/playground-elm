module App.Routing exposing (..)

import App.Messages exposing (Page(About, Calc, DigitalClock, Lissajous))
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
        , map (Page Lissajous) (s "lissajous" )
        , map (Page DigitalClock) (s "digital-clock")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute



