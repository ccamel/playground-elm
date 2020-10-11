module App.Routing exposing (..)

import App.Messages exposing (Page(..))
import Url.Parser exposing (..)
import Url exposing (Url)

type Route
    = Home
    | Page Page
    | NotFoundRoute

route : Parser (Route -> a) a
route =
    oneOf
        [ map (Home) top
        , map (Page About) (s "about" )
        , map (Page Calc) (s "calc" )
--        , map (Page Lissajous) (s "lissajous" )
--        , map (Page DigitalClock) (s "digital-clock")
--        , map (Page Maze) (s "maze")
        ]

toRoute : Url -> Route
toRoute url =
      Maybe.withDefault NotFoundRoute (parse route url)

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

