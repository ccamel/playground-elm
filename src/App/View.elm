module App.View exposing (view)

import App.Flags exposing (Flags)
import App.Messages exposing (Msg, Page)
import App.Models exposing (Model)
import App.Pages exposing (pageDate, pageDescription, pageGithubLink, pageHash, pageName, pageView, pages)
import App.Route exposing (Route(..))
import Browser
import Html exposing (Html, a, article, br, div, footer, h1, h2, h3, hr, i, img, main_, p, section, span, strong, sup, text)
import Html.Attributes exposing (attribute, class, classList, href, src, title, width)
import Html.Lazy exposing (lazy)
import List exposing (intersperse)
import String.Interpolate exposing (interpolate)



-- the main view


view : Model -> Browser.Document Msg
view model =
    { title = "playground-elm"
    , body =
        [ forkmeRibbon
        , lazy headerPart model.route
        , contentPart model
        , lazy footerPart model.flags
        ]
    }


{-| the html elements for the header
-}
headerPart : Route -> Html Msg
headerPart route =
    section
        [ classList [ ( "hero header", True ), ( "is-medium", isHomePage route ), ( "is-small", not (isHomePage route) ) ]
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
                    , a [ href "#" ] [ text "playground" ]
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


{-| the html elements for the footer
-}
footerPart : Flags -> Html Msg
footerPart { version } =
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
                        [ text ("playground-elm v" ++ version) ]
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
            lazy homePage model.flags

        Page page ->
            pagePart page model

        NotFoundRoute ->
            notFound


homePage : Flags -> Html Msg
homePage flags =
    main_ []
        [ section [ class "section" ]
            [ div [ class "container" ]
                [ div [ class "columns" ]
                    [ div [ class "column is-10 is-offset-1" ]
                        (pages
                            |> List.sortBy pageDate
                            |> List.reverse
                            |> List.indexedMap (showcase flags)
                            |> intersperse (hr [] [])
                        )
                    ]
                ]
            ]
        ]


pagePart : Page -> Model -> Html Msg
pagePart page model =
    main_ []
        [ lazy description page
        , pageView page model
        ]


description : Page -> Html Msg
description page =
    section [ class "section has-background-black-bis" ]
        [ div [ class "columns" ]
            [ div [ class "column is-8 is-offset-2" ]
                [ div [ class "content is-medium" ]
                    [ div [ class "level mb-5" ]
                        [ div [ class "level-left" ]
                            [ h2 [ class "title showcase-title mb-0" ]
                                [ page |> pageName |> text
                                , sup [ class "ml-2 is-size-5" ]
                                    [ a
                                        [ href (pageGithubLink page)
                                        , class "has-text-grey-light"
                                        , title "View source on GitHub"
                                        ]
                                        [ i [ class "fa fa-github" ] [] ]
                                    ]
                                ]
                            ]
                        ]
                    , page |> pageDescription
                    ]
                ]
            ]
        ]


showcase : Flags -> Int -> Page -> Html Msg
showcase { basePath } num page =
    div [ class "columns featured-showcase is-multiline" ]
        [ div [ class "column is-12 showcase" ]
            [ article [ class "columns featured" ]
                ([ div [ class "column is-7 showcase-img" ]
                    [ img [ src <| interpolate "{0}{1}.webp" [ basePath, pageHash page ], width 450 ]
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
                            ]
                            [ text "View demo" ]
                        , a
                            [ href (pageGithubLink page)
                            , class "button is-secondary"
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
    main_ []
        [ section [ class "home-container" ]
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
                    ]
                    [ text "Go Home" ]
                ]
            ]
        ]


isHomePage : Route -> Bool
isHomePage route =
    case route of
        Home ->
            True

        _ ->
            False
