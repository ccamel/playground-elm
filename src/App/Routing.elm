module App.Routing exposing (..)

import App.Messages exposing (Page(..))
import Page.About
import Page.Calc
import Page.DigitalClock
import Page.Lissajous
import Page.Maze
import Page.Physics
import Page.Term
import Url exposing (Url)
import Url.Parser exposing (..)


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
        Nothing ->
            Home

        Just "" ->
            Home

        Just p ->
            if p == Page.About.info.name then
                Page About

            else if p == Page.Calc.info.name then
                Page Calc

            else if p == Page.Lissajous.info.name then
                Page Lissajous

            else if p == Page.DigitalClock.info.name then
                Page DigitalClock

            else if p == Page.Maze.info.name then
                Page Maze

            else if p == Page.Physics.info.name then
                Page Physics

            else if p == Page.Term.info.name then
                Page Term

            else
                NotFoundRoute


{-| returns the route parsed given the provided Url
-}
toRoute : String -> Url -> Route
toRoute basePath url =
    { url | path = String.replace basePath "" url.path }
        |> parse matchRoute
        |> Maybe.withDefault NotFoundRoute


{-| returns the next page for the given route, if any
-}
nextPage : Route -> List Page -> Maybe Page
nextPage aroute pages =
    case aroute of
        Page page ->
            case pages of
                a :: b :: rest ->
                    if a == page then
                        Just b

                    else
                        nextPage aroute (b :: rest)

                _ ->
                    Nothing

        _ ->
            Nothing


{-| returns the previous page for the given route, if any
-}
prevPage : Route -> List Page -> Maybe Page
prevPage aroute pages =
    case aroute of
        Page page ->
            case pages of
                a :: b :: rest ->
                    if b == page then
                        Just a

                    else
                        prevPage aroute (b :: rest)

                _ ->
                    Nothing

        _ ->
            Nothing
