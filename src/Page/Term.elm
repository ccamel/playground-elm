port module Page.Term exposing (Model, Msg(..), info, init, subscriptions, update, view)

import Html exposing (Html, div, hr, p, text)
import Html.Attributes exposing (class)
import Lib.Page
import Markdown
import Term exposing (Term)
import Term.ANSI exposing (defaultFormat)



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "term"
    , hash = "term"
    , description = Markdown.toHtml [ class "info" ] """

A terminal which evaluates `JavaScript` code using elm ports.
       """
    , srcRel = "Page/Term.elm"
    }



-- MODEL


type alias Model =
    { term : Term Msg
    }


init : ( Model, Cmd Msg )
init =
    ( { term =
            Term.offline
                (Just
                    { defaultFormat
                        | foreground = Term.ANSI.Green
                    }
                )
                CommandTyped
      }
    , Cmd.batch
        [ -- execute some evals at startup
          evalJS "\"hello\" + \" world!\""
        , evalJS "new Date()"
        ]
    )



-- UPDATE


type Msg
    = CommandTyped String
    | EvalResult String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CommandTyped str ->
            ( model, evalJS str )

        EvalResult str ->
            let
                newTerm =
                    Term.receive (str ++ "\n") model.term
            in
            ( Model newTerm, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    -- results of JS evaluations.
    evalJSResults EvalResult



-- PORTS


{-| Port which evaluates the given string as Javascript code (expression or statements) using the eval() function
from the Javascript world.
-}
port evalJS : String -> Cmd msg


{-| Port subscription which emits results of evaluation performed by evalJS port.
-}
port evalJSResults : (String -> msg) -> Sub msg



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ hr [] []
        , p [ class "text-muted" ]
            [ Markdown.toHtml [ class "info" ] """
The purpose of this playground is to show interoperability between [Elm](https://elm-lang.org/) environment and `JavaScript` through [ports](https://guide.elm-lang.org/interop/ports.html).
"""
            ]
        , p [ class "text-muted" ]
            [ text "Type some javascript code in the terminal below:"
            ]
        , Term.render model.term
        ]
