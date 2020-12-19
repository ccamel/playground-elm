module App.Routing exposing (..)

import App.Messages exposing (Page(..))
import Url.Parser exposing (..)
import Url exposing (Url)

type Route
    = Home
    | Page Page
    | NotFoundRoute

matchRoute : Parser (Route -> a) a
matchRoute =
    map parseFragment (fragment identity)
    
parseFragment : Maybe String -> Route
parseFragment fragment =
    case fragment of
        Nothing -> Home
        Just "" -> Home
        Just "about" -> Page About
        Just "calc" -> Page Calc
        Just "lissajous" -> Page Lissajous
--        , map (Page DigitalClock) (s "digital-clock")
        Just "maze" -> Page Maze

        _ -> NotFoundRoute

-- returns the route parsed given the provided Url
toRoute : Url -> Route
toRoute url =
    Maybe.withDefault NotFoundRoute (parse matchRoute url)

-- returns the next page for the given route, if any
nextPage : Route -> List Page -> Maybe Page
nextPage aroute pages =
    case aroute of
        Page page ->
            case pages of
                a::b::rest ->
                    if a == page
                    then Just b
                    else nextPage aroute (b::rest)
                _ ->
                    Nothing
        _ -> Nothing

-- returns the previous page for the given route, if any
prevPage : Route -> List Page -> Maybe Page
prevPage aroute pages =
        case aroute of
            Page page ->
                case pages of
                    a::b::rest ->
                        if b == page
                        then Just a
                        else prevPage aroute (b::rest)
                    _ ->
                        Nothing
            _ -> Nothing

