module App.Subscriptions exposing (subscriptions)

import App.Messages exposing (Msg)
import App.Models exposing (Model)
import App.Pages exposing (pageSubscriptions)
import App.Route exposing (Route(..))


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ mainSubscriptions model
        , case model.route of
            NotFoundRoute ->
                Sub.none

            Home ->
                Sub.none

            Page page ->
                pageSubscriptions page model
        ]


mainSubscriptions : Model -> Sub Msg
mainSubscriptions _ =
    Sub.none
