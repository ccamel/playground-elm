module App.Update exposing (init, update)

import App.Flags exposing (Flags)
import App.Messages exposing (Msg(..))
import App.Models exposing (Model, emptyPagesModel)
import App.Pages
import App.Route exposing (Route(..))
import App.Routing exposing (toRoute)
import Browser
import Browser.Dom as Dom
import Browser.Navigation as Nav
import Task
import Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal location ->
                    let
                        newRoute =
                            toRoute model.flags.basePath location
                    in
                    if model.route == newRoute then
                        ( model, Cmd.none )

                    else
                        ( model
                        , Cmd.batch
                            [ Nav.pushUrl model.navKey (Url.toString location)
                            , Task.perform (always NoOp) (Dom.setViewport 0 0)
                            ]
                        )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged location ->
            let
                newRoute =
                    toRoute model.flags.basePath location

                clearedModel =
                    App.Pages.clearAll model
            in
            case newRoute of
                NotFoundRoute ->
                    ( { clearedModel | route = newRoute }, Cmd.none )

                Home ->
                    ( { clearedModel | route = newRoute }, Cmd.none )

                Page page ->
                    let
                        ( nextModel, cmd ) =
                            App.Pages.initPage page model.flags clearedModel
                    in
                    ( { nextModel | route = newRoute }, cmd )

        _ ->
            App.Pages.updateWithMsg msg model


init : Flags -> Url.Url -> Nav.Key -> ( Model, Cmd App.Messages.Msg )
init flags url navKey =
    let
        model =
            { flags = flags
            , route = Home
            , navKey = navKey

            -- models for pages
            , pages = emptyPagesModel
            }
    in
    update (UrlChanged url) model
