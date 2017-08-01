module App.Subscriptions exposing (..)

import App.Messages exposing (Msg(AboutPageMsg))
import App.Models exposing (Model)
import App.Routing exposing (Page(About, Home), Route(..))
import Html
import Maybe exposing (map, withDefault)
import Page.About
import Platform.Sub

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [
        mainSubscriptions model,

        case model.route of
            NotFoundRoute ->
                Sub.none

            Page Home ->
                Sub.none

            Page About ->
                case model.aboutPage of
                   Just x ->
                       x
                         |> Page.About.subscriptions
                         |> Sub.map AboutPageMsg

                   Nothing ->
                     Sub.none
    ]

mainSubscriptions : Model -> Sub Msg
mainSubscriptions model = Sub.none