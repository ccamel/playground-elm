module App.Routing exposing (..)

import Navigation exposing (Location)
import Page.About
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
        , map (Page About) (s (.hash Page.About.info))
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


hash : Route -> String
hash page =
    case page of
        Page About -> (.hash Page.About.info)
        Page Home -> "home"
        _ -> ""

describe : Route -> String
describe page =
    case page of
        Page Home -> ""
        Page About -> ""
        _ -> ""

