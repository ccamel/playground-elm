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

-- returns the next page for the given route, if any
nextPage : Route -> List Page -> Maybe Page
nextPage route pages =
    case route of
        Page page ->
            case pages of
                a::b::rest ->
                    if a == page
                    then Just b
                    else nextPage route (b::rest)
                _ ->
                    Nothing
        _ -> Nothing

-- returns the previous page for the given route, if any
prevPage : Route -> List Page -> Maybe Page
prevPage route pages =
    case route of
        Page page ->
            case pages of
                a::b::rest ->
                    if b == page
                    then Just a
                    else prevPage route (b::rest)
                _ ->
                    Nothing
        _ -> Nothing

