module Page.About exposing (Model, Msg, info, init, subscriptions, update, view)

import Html exposing (Html, article, div, h1, img, p, text)
import Html.Attributes exposing (alt, class, src)
import Lib.Page
import Markdown



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "about"
    , hash = "about"
    , description = Markdown.toHtml [ class "info" ] """

A very simple and minimal showcase that is used to lay the foundations of the navigation/routing (*and to test that the whole site works correctly*).
       """
    , srcRel = "Page/About.elm"
    }



-- MODEL


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}
    , Cmd.none
    )



-- UPDATE


type alias Msg =
    ()


update : Msg -> Model -> ( Model, Cmd Msg )
update _ _ =
    ( {}, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view _ =
    let
        content =
            [ { title = "Simple"
              , text = "Fairly simple and understandable. Every showcase is implemented in a single elm file."
              }
            , { title = "Exploratory"
              , text = "Highlight some aspects of the elm language, like immutability, reactiveness, performance and interoperability with other JS libraries. Explore some architectural/design patterns around reactive static/serverless SPA."
              }
            , { title = "Playable"
              , text = "As much as possible, provides a useful and functional content."
              }
            , { title = "Scalable"
              , text = "The structure of the playground is designed to easily accommodate additional examples and showcases. Contributors can effortlessly expand the repository, ensuring it remains a relevant and up-to-date resource for learners and enthusiasts."
              }
            ]
    in
    div
        [ class "container"
        ]
        [ div [ class "columns" ]
            [ div [ class "column is-10 is-offset-1" ]
                [ div [ class "columns is-multiline" ]
                    (content
                        |> List.map
                            (\c ->
                                div [ class "column showcase is-6" ]
                                    [ article [ class "columns is-multiline" ]
                                        [ div [ class "column is-12 showcase-img" ]
                                            [ img [ src "https://placehold.co/480x300", alt "placeholder" ] []
                                            ]
                                        , div [ class "column is-12 featured-content" ]
                                            [ h1 [ class "title showcase-title" ]
                                                [ text "» "
                                                , text c.title
                                                ]
                                            , p [ class "showcase-excerpt" ] [ text c.text ]
                                            ]
                                        ]
                                    ]
                            )
                    )
                ]
            ]
        ]
