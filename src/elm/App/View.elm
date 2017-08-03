module App.View exposing (..)

import App.Pages exposing (emptyNode, pageDescription, pageHash, pageName, pageSrc, pageView, pages)
import Html exposing (Html, a, button, div, h1, h2, h3, hr, i, img, li, p, section, span, text, ul, footer)
import Html.Attributes exposing (alt, attribute, class, href, id, src, style, target, type_)
import Html.Events exposing (onClick)
import App.Messages exposing (Msg(..), Page(About))
import App.Models exposing (Model)
import App.Routing exposing (Route(..))


-- the main view
view : Model -> Html Msg
view model =
    div []
        [
            div [ class "navbar navbar-inverse bg-inverse" ]
            -- nav bar
            [ div [ class "container d-flex justify-content-between" ]
                [ div [ class "navbar-brand" ]
                    [ text ("playground-elm/" ++ hash model.route) ]

                 , case model.route of
                    Home -> emptyNode
                    _ -> ul [ class "nav navbar-nav navbar-right" ]
                            [ li []
                              [ a [ href "#", onClick (GoToHome) ] [ text "Home" ] ]
                            ]
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
                                  i [ class "fa fa-quote-left text-muted", style [("padding-right", "1em")] ] []
                                , text "playground"
                                , span [class "text-muted"] [text "-"]
                                , a [ href "http://elm-lang.org/" ] [ text "elm" ]
                                , i [ class "fa fa-quote-right text-muted", style [("padding-left", "1em")] ] []
                            ]
                        , p [ class "lead text-muted" ]
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
            , div [ id (contentId model.route) ] [
              content model
            ]
            -- footer
            ,footer [ class "footer" ]
                [ div [ class "container" ]
      --              [ div [ class "text-muted pull-center" ]
      --                  [ text "© 2017 Chris Camel - MIT License" ]

                          [ ul [ class "list-inline pull-right" ]
                              [
                               li [class "text-muted"]
                                  [ text "© 2017 Chris Camel - MIT License" ]
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
                    div [ class "row" ] (pages |> List.map (pageCard model))
                ]
            ]

pageCard :  Model -> Page -> Html Msg
pageCard model page =
    div [ class "col-sm-3" ]
        [ div [ class "card" ]
            [ div [ class "card-block" ] [
                h3 [ class "card-title" ]
                    [ text ("~ " ++ (pageName page)) ]
                , p [ class "card-text" ]
                    [ pageDescription page ]
                , a [ href ("#" ++ (pageHash page)), onClick (GoToPage page) ] [ text "» Go" ]
                , span [style [("padding-left", "15px")] ] [] -- FIXME: not pretty
                , linkToGitHub (Page About)
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

-- returns the html anchor ('a') that denotes a link to the code source of the given route.
linkToGitHub: Route -> Html a
linkToGitHub route =
  let
    url = "https://github.com/ccamel/playground-elm/blob/master/src/elm/"
    link = case route of
               Home -> url ++ "App/View.elm"
               Page page -> url ++ pageSrc page
               NotFoundRoute -> url ++ "Main.elm"
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
     Home -> ""
     Page p -> pageHash p
     NotFoundRoute -> ""


