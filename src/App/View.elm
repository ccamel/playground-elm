module App.View exposing (view)

import App.Messages exposing (Msg(..), Page)
import App.Models exposing (Model)
import App.Pages exposing (pageDescription, pageHash, pageName, pageSrc, pageView, pages)
import App.Routing exposing (Route(..), nextPage, prevPage)
import Browser exposing (UrlRequest(..))
import Html exposing (Html, a, br, div, figure, footer, h1, h2, h3, hr, i, img, li, nav, p, section, span, strong, text, ul)
import Html.Attributes exposing (alt, attribute, class, href, id, src, style, target, title, type_)
import Html.Events exposing (on, onClick)
import Page.Common exposing (onClickNotPropagate)



-- the main view


view : Model -> Browser.Document Msg
view model =
    let
        prev =
            prevPage model.route pages

        next =
            nextPage model.route pages
    in
    { title = "playground-elm"
    , body =
        [ section
            [ class "hero is-fullheight"
            ]
            [ div
                [ class "hero-head"
                ]
                [ navbarPart model
                , forkmeRibbon
                ]
            , div
                [ class "hero-body"
                ]
                [ content model
                ]
            , div
                [ class "hero-footer"
                ]
                [ footerPart model
                ]
            ]
        ]
    }


{-| the html elements for the navigation bar
-}
navbarPart : Model -> Html Msg
navbarPart _ =
    nav
        [ class "navbar"
        ]
        [ div
            [ class "container"
            ]
            [ div
                [ class "navbar-brand"
                ]
                [ a
                    [ class "navbar-item"
                    , href "#"
                    , onClick GoToHome
                    ]
                    [ span []
                        [ text "playground"
                        , text " "
                        , span [ class "elm-pipe" ] [ text "|" ]
                        , span [ class "elm-gt" ] [ text ">" ]
                        , text " "
                        , a [ href "http://elm-lang.org/" ] [ text "elm" ]
                        ]
                    ]
                ]
            ]
        ]


{-| the html elements for the footer
-}
footerPart : Model -> Html Msg
footerPart _ =
    footer
        [ class "footer" ]
        [ div
            [ class "container"
            ]
            [ div
                [ class "content has-text-centered"
                ]
                [ div
                    [ class "soc"
                    ]
                    [ a
                        [ href "https://github.com/ccamel"
                        ]
                        [ i
                            [ class "fa fa-github fa-lg"
                            , attribute "aria-hidden" "true"
                            ]
                            []
                        ]
                    , a
                        [ href "https://linkedin.com/in/christophe-camel/"
                        ]
                        [ i
                            [ class "fa fa-linkedin fa-lg"
                            , attribute "aria-hidden" "true"
                            ]
                            []
                        ]
                    , a
                        [ href "https://twitter.com/7h3_360l355_d3v"
                        ]
                        [ i
                            [ class "fa fa-twitter fa-lg"
                            , attribute "aria-hidden" "true"
                            ]
                            []
                        ]
                    ]
                , p []
                    [ strong []
                        [ text "playground-elm" ]
                    , text " | "
                    , a [ href "https://github.com/ccamel" ]
                        [ text "© 2017-2023 Christophe Camel" ]
                    , text " | "
                    , a [ href "https://github.com/ccamel/playground-elm/blob/main/LICENSE" ]
                        [ text "MIT License" ]
                    , text "."
                    , br [] []
                    ]
                ]
            ]
        ]


forkmeRibbon : Html msg
forkmeRibbon =
    a
        [ class "github-fork-ribbon right-top"
        , href "https://github.com/ccamel/playground-elm"
        , attribute "data-ribbon" "Fork me on GitHub"
        , title "Fork me on GitHub"
        ]
        [ text "Fork me on GitHub" ]


{-| the html elements for the content part of the view
-}
content : Model -> Html Msg
content model =
    case model.route of
        Home ->
            homePage model

        Page page ->
            pageView page model

        NotFoundRoute ->
            notFoundView


{-| the home page displaying all available pages as "cards" entries
-}
homePage : Model -> Html Msg
homePage model =
    div []
        [ div
            [ class "section"
            ]
            [ div
                [ class "container" ]
                [ div
                    [ class "columns"
                    ]
                    [ div
                        [ class "column has-text-centered"
                        ]
                        [ h1
                            [ class "title is-1"
                            , style "color" "ghostwhite"
                            ]
                            [ i [ class "fa fa-quote-left text-muted", style "padding-right" ".5em" ] []
                            , text "playground"
                            , text " "
                            , span [ class "elm-pipe" ] [ text "|" ]
                            , span [ class "elm-gt" ] [ text ">" ]
                            , text " "
                            , a [ href "http://elm-lang.org/" ] [ text "elm" ]
                            , i [ class "fa fa-quote-right text-muted", style "padding-left" ".5em" ] []
                            ]
                        , br []
                            []
                        , h2
                            [ class "subtitle is-3"
                            , style "color" "ghostwhite"
                            ]
                            [ text "My playground I use for playing with fancy and exciting technologies." ]
                        , br []
                            []
                        ]
                    ]
                ]
            ]
        , div [ class "section" ]
            [ div [ class "container" ]
                [ div
                    [ class "row columns is-multiline"
                    ]
                    (pages |> List.map (pageCard model))
                ]
            ]
        ]


pageCard : Model -> Page -> Html Msg
pageCard _ page =
    div
        [ class "column is-4"
        ]
        [ div
            [ class "card large is-cursor-pointer"
            , onClick (GoToPage page)
            ]
            [ div
                [ class "card-image cover-image is-overflow-hidden"
                ]
                [ figure
                    [ class "image"
                    ]
                    [ img
                        [ src "https://images.unsplash.com/photo-1687851898832-650714860119?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80"
                        , alt "Image"
                        ]
                        []
                    ]
                ]
            , div
                [ class "card-content"
                ]
                [ div
                    [ class "media"
                    ]
                    [ div
                        [ class "media-content"
                        ]
                        [ p
                            [ class "title is-4 no-padding"
                            ]
                            [ page |> pageName |> text ]
                        , p []
                            [ span
                                [ class "title is-6"
                                ]
                                [ linkToGitHub page ]
                            ]
                        ]
                    ]
                , div
                    [ class "content"
                    ]
                    [ pageDescription page
                    ]
                ]
            , footer
                [ class "card-footer has-background-white-bis"
                ]
                [ a
                    [ href "#"
                    , class "card-footer-item p-5 has-text-grey is-uppercase is-text-wide-1"
                    ]
                    [ text "Play" ]
                ]
            ]
        ]


{-| the special not found view displayed when routing has found no matching
-}
notFoundView : Html Msg
notFoundView =
    div
        [ class "container has-text-centered"
        ]
        [ h1
            [ class "is-size-1 has-text-weight-bold has-text-primary"
            ]
            [ text "404" ]
        , p
            [ class "is-size-5 has-text-weight-medium"
            ]
            [ span
                [ class "has-text-danger"
                ]
                [ text "Opps!" ]
            , text " Page not found."
            ]
        , p
            [ class "is-size-6 mb-2"
            ]
            [ text "The page you’re looking for doesn’t exist." ]
        , a
            [ href "#"
            , class "button is-primary"
            , onClick GoToHome
            ]
            [ text "Go Home" ]
        ]


{-| returns the html anchor ('a') that denotes a link to the code source of the given page.
-}
linkToGitHub : Page -> Html Msg
linkToGitHub page =
    let
        url =
            "https://github.com/ccamel/playground-elm/blob/main/src/"

        link =
            url ++ pageSrc page
    in
    a
        [ href "#"
        , onClickNotPropagate (LinkClicked (External link))
        ]
        [ i
            [ class "fa fa-github "
            , attribute "aria-hidden" "true"
            ]
            [ text " source" ]
        ]


contentId : Route -> String
contentId route =
    case route of
        Home ->
            "home"

        Page p ->
            pageHash p

        NotFoundRoute ->
            "?"


hash : Route -> String
hash route =
    case route of
        Home ->
            "home"

        Page p ->
            pageHash p

        NotFoundRoute ->
            ""


exists : Maybe a -> Bool
exists m =
    case m of
        Just _ ->
            True

        Nothing ->
            False
