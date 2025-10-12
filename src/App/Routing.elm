module App.Routing exposing (toRoute)

import App.Pages
import App.Route exposing (Route(..))
import Url exposing (Url)
import Url.Parser exposing (Parser, fragment, map, oneOf, parse, s)


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        [ fragment parseFragment
        , map Home (s "index.html") -- maintain compatibility with old urls
        ]


parseFragment : Maybe String -> Route
parseFragment fragment =
    case fragment of
        Nothing ->
            Home

        Just "" ->
            Home

        Just p ->
            case App.Pages.pageFromSlug p of
                Just page ->
                    Page page

                Nothing ->
                    NotFoundRoute


{-| returns the route parsed given the provided Url
-}
toRoute : String -> Url -> Route
toRoute basePath url =
    let
        newPath =
            if basePath == "" then
                url.path

            else
                String.replace basePath "" url.path
    in
    { url | path = newPath }
        |> parse matchRoute
        |> Maybe.withDefault NotFoundRoute
