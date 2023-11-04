module Page.Calc exposing (Model, Msg(..), Op(..), State(..), Token(..), info, init, subscriptions, update, view)

import Basics.Extra exposing (flip)
import Browser.Events
import Html exposing (Html, div, h2, input, text)
import Html.Attributes exposing (attribute, class, disabled, type_, value)
import Html.Events exposing (onClick)
import Json.Decode as Json
import List exposing (drop, foldl, take)
import Markdown
import Maybe exposing (withDefault)
import Page.Common
import Result exposing (toMaybe)
import String exposing (fromFloat, fromInt)



-- PAGE INFO


info : Page.Common.PageInfo Msg
info =
    { name = "calc"
    , hash = "calc"
    , description = Markdown.toHtml [ class "info" ] """

A very simple and basic calculator.
       """
    , srcRel = "Page/Calc.elm"
    }



-- MODEL


type State
    = ACCUM
    | OPERATOR
    | DOT


type alias Model =
    { outputs : List Float
    , operators : List Op
    , state : State
    , accumulator : String
    , memory : Maybe Float
    }


init : ( Model, Cmd Msg )
init =
    ( { outputs = []
      , operators = []
      , state = ACCUM
      , accumulator = ""
      , memory = Nothing
      }
    , Cmd.none
    )



-- MESSAGES


type Op
    = Plus
    | Minus
    | Multiply
    | Divide
    | Result


type Token
    = Clear
    | Digit Int
    | Dot
    | Operator Op
    | MR
    | MC
    | MS


type Msg
    = Emitted Token
    | KeyMsg String



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Emitted token ->
            apply token model

        KeyMsg key ->
            let
                -- dummy = Debug.log "--> " key
                token =
                    case key of
                        "0" ->
                            Just (Digit 0)

                        "1" ->
                            Just (Digit 1)

                        "2" ->
                            Just (Digit 2)

                        "3" ->
                            Just (Digit 3)

                        "4" ->
                            Just (Digit 4)

                        "5" ->
                            Just (Digit 5)

                        "6" ->
                            Just (Digit 6)

                        "7" ->
                            Just (Digit 7)

                        "8" ->
                            Just (Digit 8)

                        "9" ->
                            Just (Digit 9)

                        "+" ->
                            Just (Operator Plus)

                        "-" ->
                            Just (Operator Minus)

                        "/" ->
                            Just (Operator Divide)

                        "*" ->
                            Just (Operator Multiply)

                        "=" ->
                            Just (Operator Result)

                        "." ->
                            Just Dot

                        "Delete" ->
                            Just Clear

                        _ ->
                            Nothing
            in
            token
                |> Maybe.map (flip apply model)
                |> Maybe.withDefault ( model, Cmd.none )


{-| apply the given token to the model, computing a new state
-}
apply : Token -> Model -> ( Model, Cmd Msg )
apply token model =
    case model.state of
        ACCUM ->
            case token of
                Clear ->
                    model
                        |> doClear

                Digit _ ->
                    ( model
                        |> doAccumulate token
                    , Cmd.none
                    )

                Dot ->
                    ( model
                        |> doAccumulate token
                        |> go DOT
                    , Cmd.none
                    )

                Operator op ->
                    ( model
                        |> doOperator op
                        |> go OPERATOR
                    , Cmd.none
                    )

                MR ->
                    ( model
                        |> doMR
                        |> go OPERATOR
                    , Cmd.none
                    )

                MC ->
                    ( model
                        |> doMC
                        |> go OPERATOR
                    , Cmd.none
                    )

                MS ->
                    ( model
                        |> doMS
                        |> go OPERATOR
                    , Cmd.none
                    )

        OPERATOR ->
            case token of
                Clear ->
                    model
                        |> doClear

                Digit _ ->
                    ( model
                        |> doResetAccu
                        |> doAccumulate token
                        |> go ACCUM
                    , Cmd.none
                    )

                Dot ->
                    ( model
                        |> doResetAccu
                        |> doAccumulate token
                        |> go DOT
                    , Cmd.none
                    )

                Operator op ->
                    ( model
                        |> doOperator op
                    , Cmd.none
                    )

                MR ->
                    ( model
                        |> doMR
                    , Cmd.none
                    )

                MC ->
                    ( model
                        |> doMC
                    , Cmd.none
                    )

                MS ->
                    ( model
                        |> doMS
                    , Cmd.none
                    )

        DOT ->
            case token of
                Clear ->
                    model
                        |> doClear

                Digit _ ->
                    ( model
                        |> doAccumulate token
                    , Cmd.none
                    )

                Dot ->
                    ( model, Cmd.none )

                Operator op ->
                    ( model
                        |> doOperator op
                        |> go OPERATOR
                    , Cmd.none
                    )

                MR ->
                    ( model
                        |> doMR
                        |> go OPERATOR
                    , Cmd.none
                    )

                MC ->
                    ( model
                        |> doMC
                        |> go OPERATOR
                    , Cmd.none
                    )

                MS ->
                    ( model
                        |> doMS
                        |> go OPERATOR
                    , Cmd.none
                    )


doAccumulate : Token -> Model -> Model
doAccumulate d model =
    let
        value =
            case ( d, model.accumulator ) of
                ( Digit 0, "" ) ->
                    ""

                ( Digit n, a ) ->
                    a ++ String.fromInt n

                ( Dot, a ) ->
                    a ++ "."

                ( _, a ) ->
                    a
    in
    { model | accumulator = value }


doOperator : Op -> Model -> Model
doOperator op model =
    let
        reduce m o =
            case m.operators of
                head :: tail ->
                    if opPriority o <= opPriority head then
                        let
                            ( args, rest ) =
                                ( take 2 m.outputs, drop 2 m.outputs )

                            r =
                                case head of
                                    Plus ->
                                        List.sum args

                                    Minus ->
                                        foldl (\a b -> a - b) 0 args

                                    Multiply ->
                                        List.product args

                                    Divide ->
                                        foldl (\a b -> a / b) 1 args

                                    Result ->
                                        0.0

                            -- should not occur
                        in
                        reduce { m | operators = tail, outputs = r :: rest, accumulator = fromFloat r } o

                    else
                        m

                [] ->
                    m

        c2 =
            { model | outputs = Result.withDefault 0.0 (result model) :: model.outputs }

        c =
            reduce c2 op
    in
    case op of
        Result ->
            c

        _ ->
            { c | operators = op :: c.operators }


doResetAccu : Model -> Model
doResetAccu model =
    { model | accumulator = "" }


doClear : Model -> ( Model, Cmd Msg )
doClear _ =
    init


doMS : Model -> Model
doMS model =
    { model | memory = toMaybe (result model) }


doMC : Model -> Model
doMC model =
    { model | memory = Nothing }


doMR : Model -> Model
doMR model =
    case model.memory of
        Just v ->
            { model | accumulator = fromFloat v }

        Nothing ->
            model


go : State -> Model -> Model
go state model =
    { model | state = state }


opPriority : Op -> Int
opPriority op =
    case op of
        Plus ->
            1

        Minus ->
            1

        Multiply ->
            2

        Divide ->
            2

        Result ->
            0


result : Model -> Result String Float
result model =
    case model.accumulator of
        "" ->
            Ok 0.0

        d ->
            String.toFloat d |> Result.fromMaybe "error"



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    let
        eventKeyDecoder =
            Json.field "key" (Json.string |> Json.map KeyMsg)
    in
    Browser.Events.onKeyPress eventKeyDecoder



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "columns" ]
            [ div [ class "column has-text-centered" ]
                [ h2
                    [ class "subtitle is-5 has-text-white"
                    ]
                    [ text "A very simple and basic calculator." ]
                ]
            ]
        , div
            [ class "columns is-centered" ]
            [ div
                [ class "column is-one-third" ]
                [ div
                    [ class "card p-4 has-background-grey-lighter"
                    ]
                    [ calc model
                    ]
                ]
            ]
        ]


calc : Model -> Html Msg
calc model =
    div [ class "calc" ]
        [ -- display
          div [ class "columns is-gapless display is-mobile" ]
            [ div [ class "column is-11" ]
                [ input [ class "input", attribute "readOnly" "", type_ "Text", value (display model) ]
                    []
                ]
            , div [ class "column is-1 has-flex-centered" ]
                [ div [ class "tags-container" ]
                    [ renderMemoryTag model
                    , renderOperatorTag model
                    ]
                ]
            ]

        -- buttons
        , div [ class "columns is-mobile" ]
            [ button (Digit 7) model, button (Digit 8) model, button (Digit 9) model, button (Operator Plus) model, button Clear model ]
        , div [ class "columns is-mobile" ]
            [ button (Digit 4) model, button (Digit 5) model, button (Digit 6) model, button (Operator Minus) model, button MS model ]
        , div [ class "columns is-mobile" ]
            [ button (Digit 1) model, button (Digit 2) model, button (Digit 3) model, button (Operator Multiply) model, button MR model ]
        , div [ class "columns is-mobile" ]
            [ button Dot model, button (Digit 0) model, button (Operator Result) model, button (Operator Divide) model, button MC model ]
        ]


{-| accept tells if the given token can be accepted regarding the current state (model)
used to find if a button should be enabled or disabled depending on the calc context.
-}
accept : Model -> Token -> Bool
accept model token =
    case token of
        Dot ->
            model.state /= DOT

        MR ->
            case model.memory of
                Just _ ->
                    True

                Nothing ->
                    False

        MC ->
            case model.memory of
                Just _ ->
                    True

                Nothing ->
                    False

        _ ->
            True


renderMemoryTag : Model -> Html Msg
renderMemoryTag model =
    div [ class "fixed-tag" ]
        [ text
            (model.memory
                |> Maybe.map (\_ -> "M")
                |> withDefault " "
            )
        ]


renderOperatorTag : Model -> Html Msg
renderOperatorTag model =
    div [ class "fixed-tag" ]
        [ model.operators
            |> List.head
            |> Maybe.map
                (\token ->
                    case token of
                        Plus ->
                            "+"

                        Minus ->
                            "-"

                        Multiply ->
                            "x"

                        Divide ->
                            "/"

                        Result ->
                            "="
                )
            |> withDefault " "
            |> text
        ]


display : Model -> String
display model =
    case model.accumulator of
        "" ->
            "0"

        v ->
            v


{-| returns an html representation of the given token regarding the current state (model)
-}
button : Token -> Model -> Html Msg
button token model =
    let
        render txt style =
            div [ class <| "column px-1 py-0  " ++ style ]
                [ Html.button
                    [ class "button is-fullwidth"
                    , onClick <| Emitted token
                    , disabled <| not <| accept model token
                    ]
                    [ text txt
                    ]
                ]
    in
    case token of
        Clear ->
            render "C" "clear is-2"

        Digit d ->
            render (fromInt d) "digit is-2"

        Operator Plus ->
            render "+" "operator is-4"

        Operator Minus ->
            render "-" "operator is-4"

        Operator Multiply ->
            render "x" "operator is-4"

        Operator Divide ->
            render "/" "operator is-4"

        Operator Result ->
            render "=" "result is-2"

        MR ->
            render "MR" "memory is-2"

        MC ->
            render "MC" "memory is-2"

        MS ->
            render "MS" "memory is-2"

        Dot ->
            render "." "dot is-2"
