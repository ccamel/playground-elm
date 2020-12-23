module App.View exposing (..)

import App.Pages exposing (pageDescription, pageHash, pageName, pageSrc, pageView, pages)
import Browser
import Html exposing (Html, a, div, footer, h1, h2, h3, hr, i, img, li, nav, p, section, span, text, ul)
import Html.Attributes exposing (alt, attribute, class, href, id, src, style, title, type_)
import Html.Events exposing (onClick)
import App.Messages exposing (Msg(..), Page(..))
import App.Models exposing (Model)
import App.Routing exposing (Route(..), nextPage, prevPage)
import Html.Events
import Html.Events


-- the main view
view : Model -> Browser.Document Msg
view model =
    let
        prev = prevPage model.route pages
        next = nextPage model.route pages
    in
    {
      title = "playground-elm",
      body = [
        div []
            [
                div [ class "navbar navbar-inverse bg-inverse" ]
                -- nav bar
                [
                    div [ class "container d-flex" ]
                    [
                      a [ Html.Attributes.classList
                             [ ("breadcrumb", True)
                              ,("animated", True)
                              ,("fadeOut",  prev |> exists |> not)
                              ,("fadeIn", prev |> exists)
                             ]
                         ,style "cursor" (if prev |> exists then "cursor" else "default")
                         ,href (prev |> Maybe.map pageHash |> Maybe.withDefault "" |> (++) "#")
                         ,onClick (prev |> Maybe.map GoToPage |> Maybe.withDefault GoToHome )
                        ]
                        [ i [class "fa fa-caret-left", attribute "aria-hidden" "true"] [] ]
                     ,nav [ class "breadcrumb" ]
                          [ a [ class "breadcrumb-item", href "#", onClick (GoToHome) ]
                              [ text "playground-elm" ]
                           ,span [ class "breadcrumb-item active" ]
                              [ text (hash model.route) ]
                          ]
                    ,a [ Html.Attributes.classList
                              [ ("breadcrumb", True)
                                ,("animated", True)
                                ,("fadeOut",  next |> exists |> not)
                                ,("fadeIn", next |> exists)
                              ]
                          ,style "cursor" (if next |> exists then "cursor" else "default")
                          ,href (next |> Maybe.map pageHash |> Maybe.withDefault "" |> (++) "#")
                          ,onClick (next |> Maybe.map GoToPage |> Maybe.withDefault GoToHome )
                         ]
                         [ i [class "fa fa-caret-right", attribute "aria-hidden" "true"] [] ]
                    ]

                    -- "fork me" ribbon
                   ,a [ href "https://github.com/ccamel/playground-elm" ]
                                              [ img [ alt "Fork me on GitHub",
                                                      attribute "data:data-canonical-src" "https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png"
                                                    , src "https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67"
                                                    , attribute "style" "position: absolute; top: 0; right: 0; border: 0;"
                                                    ]
                                                 []
                                              , text ""
                                              ]
                ]
                -- preamble
                ,section [ class "jumbotron text-center" ]
                        [ div [ class "container" ]
                            [ h1 [ class "jumbotron-heading" ]
                                [
                                      i [ class "fa fa-quote-left text-muted", style "padding-right" "1em" ] []
                                    , span [ ] [
                                          text "playground"
                                        , text " "
                                        , span [class "elm-pipe"] [text "|"]
                                        , span [class "elm-gt"] [ text ">"]
                                        , text " "
                                        , a [ href "http://elm-lang.org/" ] [ text "elm" ]
                                      ]
                                    , i [ class "fa fa-quote-right text-muted", style "padding-left" "1em" ] []
                                ]
                              ,div [style "float" "right"] [
                                     a 
                                        [ attribute "aria-controls" "collapseExample"
                                        ,attribute "aria-expanded" "true"
                                        ,attribute "data-toggle" "collapse"
                                        ,title "toggle the summary"
                                        ,type_ "button"
                                        ,attribute "data-target" "#summary"
                                        ,href "."
                                        ]
                                       [ i [ class "fa fa-bars" ] [] ]
                                   ]
                              ,p [ class "lead text-muted collapse.show collapse show", id "summary" ]
                                [
                                 p []
                                    [ text "My playground I use for playing with fancy and exciting technologies." ]
                                ,p [] [text "§"]
                                ,p []
                                    [   text "This one's for "
                                      , a [ href "http://elm-lang.org/" ] [ text "elm" ]
                                      , text " and "
                                      , a [ href "https://getbootstrap.com/" ] [ text "bootstrap" ]
                                    ]
                                ]
                            ]
                        ]
                -- content
                , div [ id (contentId model.route), class "demo-content" ] [
                  content model
                ]
                -- footer
                ,footer [ class "footer" ]
                    [ div [ class "container" ]
                              [ ul [ class "text-center" ]
                                  [
                                   li [class "text-muted"]
                                      [ text "© 2017-2021 Christophe Camel - MIT License" ]
                                  , li [class "text-muted"] [text "  •  "]
                                  , li []
                                    [
                                      a [ href "https://github.com/ccamel" ]
                                            [ i [ class "fa fa-github fa-2x" ]
                                                []
                                            ]
                                    ]
                                  , li [class "text-muted"] [text "  •  "]
                                  , li []
                                    [
                                      a [ href "https://www.linkedin.com/in/christophe-camel" ]
                                            [ i [ class "fa fa-linkedin-square fa-2x" ]
                                                []
                                            ]
                                    ]
                                  ]
                              ]
                    ]
            ]
        ]
    }

-- the html elements for the content part of the view
content : Model -> Html Msg
content model =
        case model.route of
            Home -> homePage model
            Page page -> pageView page model
            NotFoundRoute -> notFoundView

-- the home page displaying all available pages as "album" entries
homePage :  Model -> Html Msg
homePage model =
         div [ class "text-muted" ]
            [ div [ class "container" ]
                [
                    hr [] []
                    , div [ class "row" ] (pages |> List.map (pageCard model))
                ]
            ]

pageCard :  Model -> Page -> Html Msg
pageCard _ page =
    div [ class "col-sm-3" ]
        [ div [ class "card animated fadeInUp" ]
            [ div [ class "card-block" ] [
                h3 [ class "card-title" ]
                    [
                       i [class "fa fa-square", attribute "aria-hidden" "true"] []
                      ,text (pageName page)
                    ]
                , p [ class "card-text" ]
                    [ pageDescription page ]
                , a [ href ("#" ++ (pageHash page)), onClick (GoToPage page) ] [ text "» Go" ]
                , span [style "padding-left" "15px" ] [] -- FIXME: not pretty
                , linkToGitHub page
                ]
            ]
        ]

-- the special not found view displayed when routing has found no matching
notFoundView : Html msg
notFoundView =
    div [ class "container" ]
      [
         hr [] []
        ,div [ class "text-muted" ]
            [ div [ class "container" ]
                [ div [ class "row" ]
                  [
                    div [ class "col-sm-12 text-center" ] [
                         i [ class "fa fa-exclamation-triangle" ] []
                       , h2 [] [ text "404" ]
                       , text "not found"
                    ]
                  ]
                ]
            ]
      ]

-- returns the html anchor ('a') that denotes a link to the code source of the given page.
linkToGitHub: Page -> Html a
linkToGitHub page =
  let
    url = "https://github.com/ccamel/playground-elm/blob/master/src/elm/"
    link = url ++ pageSrc page
  in
    a [ href link ] [ text "» Source" ]

contentId : Route -> String
contentId route =
   case route of
     Home -> "home"
     Page p -> pageHash p
     NotFoundRoute -> "?"

hash: Route -> String
hash route =
   case route of
     Home -> "home"
     Page p -> pageHash p
     NotFoundRoute -> ""

exists : Maybe a -> Bool
exists m =
    case m of
        Just _ -> True
        Nothing -> False

