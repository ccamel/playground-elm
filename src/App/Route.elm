module App.Route exposing (Route(..))

import App.Messages exposing (Page)


type Route
    = Home
    | Page Page
    | NotFoundRoute
