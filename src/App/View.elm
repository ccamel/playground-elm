module App.View exposing (view)

import App.Messages exposing (Msg(..), Page)
import App.Models exposing (Model)
import App.Pages exposing (pageDate, pageDescription, pageGithubLink, pageHash, pageName, pageView, pages)
import App.Routing exposing (Route(..))
import Browser exposing (UrlRequest(..))
import Html exposing (Html, a, article, br, div, footer, h1, h2, h3, hr, i, img, p, section, span, strong, text)
import Html.Attributes exposing (attribute, class, href, src, title)
import Html.Events exposing (onClick)
import Lib.Html exposing (classList, onClickNotPropagate)
import List exposing (intersperse)
import String.Interpolate exposing (interpolate)
import Html.Attributes exposing (width)



-- the main view


view : Model -> Browser.Document Msg
view model =
    { title = "playground-elm"
    , body =
        [ forkmeRibbon
        , section
            [ classList [ ( "hero", True ), ( "is-medium", isHomePage model ), ( "is-small", not (isHomePage model) ) ]
            ]
            [ div
                [ class "hero-body"
                ]
                [ div
                    [ class "container has-text-centered"
                    ]
                    [ h1 [ class "title pb-5" ]
                        [ i [ class "quote-left fa fa-quote-left text-muted pr-4" ] []
                        , span [ class "break" ] []
                        , a [ href "#", onClickNotPropagate GoToHome ] [ text "playground" ]
                        , span [ class "elm-pipe pl-1" ] [ text "|" ]
                        , span [ class "elm-gt pr-1" ] [ text ">" ]
                        , a [ href "http://elm-lang.org/" ] [ text "elm" ]
                        , span [ class "break" ] []
                        , i [ class "quote-right fa fa-quote-right text-muted pl-4" ] []
                        ]
                    , h2
                        [ class "subtitle"
                        ]
                        [ text "A playground for fancy web experiences with Elm" ]
                    ]
                ]
            ]
        , contentPart model
        , footerPart model
        ]
    }


{-| the html elements for the footer
-}
footerPart : Model -> Html Msg
footerPart _ =
    footer
        [ class "footer has-background-black-bis" ]
        [ div
            [ class "container"
            ]
            [ div
                [ class "content has-text-centered"
                ]
                [ p
                    []
                    [ a
                        [ href "https://github.com/ccamel"
                        ]
                        [ i
                            [ class "fa fa-github-square fa-2x"
                            , attribute "aria-hidden" "true"
                            ]
                            []
                        ]
                    , a
                        [ href "https://linkedin.com/in/christophe-camel/"
                        ]
                        [ i
                            [ class "fa fa-linkedin-square fa-2x mx-4"
                            , attribute "aria-hidden" "true"
                            ]
                            []
                        ]
                    , a
                        [ href "https://twitter.com/7h3_360l355_d3v"
                        ]
                        [ i
                            [ class "fa fa-twitter-square fa-2x"
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
                        [ text "© 2017-2024 Christophe Camel" ]
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
contentPart : Model -> Html Msg
contentPart model =
    case model.route of
        Home ->
            homePage model

        Page page ->
            pagePart page model

        NotFoundRoute ->
            notFound


homePage : Model -> Html Msg
homePage model =
    section [ class "section" ]
        [ div [ class "container" ]
            [ div [ class "columns" ]
                [ div [ class "column is-10 is-offset-1" ]
                    (pages
                        |> List.sortBy pageDate
                        |> List.reverse
                        |> List.indexedMap (showcase model)
                        |> intersperse (hr [] [])
                    )
                ]
            ]
        ]


pagePart : Page -> Model -> Html Msg
pagePart page model =
    div []
        [ section [ class "section has-background-black-bis" ]
            [ div [ class "columns" ]
                [ div [ class "column is-8 is-offset-2" ]
                    [ div [ class "content is-medium" ]
                        [ h2 [ class "title showcase-title mb-5" ] [ page |> pageName |> text ]
                        , page |> pageDescription
                        ]
                    ]
                ]
            ]
        , section [ class "section pt-1 has-background-black-bis" ]
            [ pageView page model ]
        ]


showcase : Model -> Int -> Page -> Html Msg
showcase _ num page =
    div [ class "columns featured-showcase is-multiline" ]
        [ div [ class "column is-12 showcase" ]
            [ article [ class "columns featured" ]
                ([ div [ class "column is-7 showcase-img" ]
                    [ img [ src <| interpolate "/{0}.png" [ pageHash page ], width 450 ]
                        []
                    ]
                 , div [ class "column is-5 featured-content va" ]
                    [ div []
                        [ h3
                            [ class "heading showcase-category"
                            ]
                            [ page |> pageDate |> text ]
                        , h1
                            [ class "title showcase-title"
                            ]
                            [ page |> pageName |> text ]
                        , pageDescription page
                        , br []
                            []
                        , a
                            [ href ("#" ++ pageHash page)
                            , class "button is-primary mr-4"
                            , onClick (GoToPage page)
                            ]
                            [ text "View demo" ]
                        , a
                            [ href (pageGithubLink page)
                            , class "button is-secondary"
                            , onClickNotPropagate (LinkClicked (External (pageGithubLink page)))
                            ]
                            [ i [ class "fa fa-github mr-2" ] []
                            , text "Source"
                            ]
                        ]
                    ]
                 ]
                    |> (if modBy 2 num == 0 then
                            List.reverse

                        else
                            identity
                       )
                )
            ]
        ]


{-| the special not found view displayed when routing has found no matching
-}
notFound : Html Msg
notFound =
    section [ class "home-container" ]
        [ div
            [ class "container has-text-centered"
            ]
            [ h1
                [ class "is-size-1 has-text-weight-bold"
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
                , class "button"
                , onClickNotPropagate GoToHome
                ]
                [ text "Go Home" ]
            ]
        ]


isHomePage : Model -> Bool
isHomePage model =
    case model.route of
        Home ->
            True

        _ ->
            False
