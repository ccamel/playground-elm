module Page.Calc exposing (Model, Msg, info, init, subscriptions, update, view)

import Basics.Extra exposing (flip)
import Browser.Events
import Html exposing (Html, div, input, section, span, text)
import Html.Attributes exposing (attribute, class, disabled, type_, value)
import Html.Events exposing (onClick)
import Json.Decode as Json
import Lib.Page
import List exposing (drop, foldl, take)
import Markdown
import Maybe exposing (withDefault)
import Result exposing (toMaybe)
import String exposing (fromFloat, fromInt)



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "calc"
    , hash = "calc"
    , date = "2020-10-11"
    , description = Markdown.toHtml [ class "content" ] """

A very simple and basic calculator.
       """
    , srcRel = "Page/Calc.elm"
    }



-- MODEL


type State
    = ACCUM
    | OPERATOR
    | DOT


type alias ModelRecord =
    { outputs : List Float
    , operators : List Op
    , state : State
    , accumulator : String
    , memory : Maybe Float
    }


type Model
    = Model ModelRecord


init : ( Model, Cmd Msg )
init =
    ( Model
        { outputs = []
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
update msg (Model model) =
    Tuple.mapFirst Model <|
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
apply : Token -> ModelRecord -> ( ModelRecord, Cmd Msg )
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


doAccumulate : Token -> ModelRecord -> ModelRecord
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


doOperator : Op -> ModelRecord -> ModelRecord
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


doResetAccu : ModelRecord -> ModelRecord
doResetAccu model =
    { model | accumulator = "" }


doClear : ModelRecord -> ( ModelRecord, Cmd Msg )
doClear _ =
    let
        ( Model m, c ) =
            init
    in
    ( m, c )


doMS : ModelRecord -> ModelRecord
doMS model =
    { model | memory = toMaybe (result model) }


doMC : ModelRecord -> ModelRecord
doMC model =
    { model | memory = Nothing }


doMR : ModelRecord -> ModelRecord
doMR model =
    case model.memory of
        Just v ->
            { model | accumulator = fromFloat v }

        Nothing ->
            model


go : State -> ModelRecord -> ModelRecord
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


result : ModelRecord -> Result String Float
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
view (Model model) =
    section [ class "section pt-1 has-background-black-bis" ]
        [ div [ class "columns is-centered" ]
            [ div [ class "column is-one-third" ]
                [ calc model
                ]
            ]
        ]


calc : ModelRecord -> Html Msg
calc model =
    div [ class "pl-5 pb-5 has-background-grey-dark br-10" ]
        [ -- display
          div [ class "columns is-mobile" ]
            [ div [ class "column is-11 control has-icons-right" ]
                [ input [ class "input has-text-right is-family-monospace", attribute "readOnly" "", type_ "Text", value (display model) ]
                    []
                , span []
                    [ span [ class "icon is-right is-size-7  mt-2 mr-2" ]
                        [ renderMemoryTag model
                        ]
                    , span [ class "icon is-right is-size-7  mt-5 mr-2" ] [ renderOperatorTag model ]
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
accept : ModelRecord -> Token -> Bool
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


renderMemoryTag : ModelRecord -> Html Msg
renderMemoryTag model =
    text
        (model.memory
            |> Maybe.map (always "M")
            |> withDefault " "
        )


renderOperatorTag : ModelRecord -> Html Msg
renderOperatorTag model =
    model.operators
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


display : ModelRecord -> String
display model =
    case model.accumulator of
        "" ->
            "0"

        v ->
            v


{-| returns an html representation of the given token regarding the current state (model)
-}
button : Token -> ModelRecord -> Html Msg
button token model =
    let
        render txt divStyle buttonStyle =
            div [ class <| "column p-1 " ++ divStyle ]
                [ Html.button
                    [ class <| "button is-fullwidth " ++ buttonStyle
                    , onClick <| Emitted token
                    , disabled <| not <| accept model token
                    ]
                    [ text txt
                    ]
                ]
    in
    case token of
        Clear ->
            render "C" "clear is-2" "is-warning"

        Digit d ->
            render (fromInt d) "digit is-2" ""

        Operator Plus ->
            render "+" "operator is-4" "is-info"

        Operator Minus ->
            render "-" "operator is-4" "is-info"

        Operator Multiply ->
            render "x" "operator is-4" "is-info"

        Operator Divide ->
            render "/" "operator is-4" "is-info"

        Operator Result ->
            render "=" "result is-2" "is-link"

        MR ->
            render "MR" "memory is-2" "is-success"

        MC ->
            render "MC" "memory is-2" "is-success"

        MS ->
            render "MS" "memory is-2" "is-success"

        Dot ->
            render "." "dot is-2" ""
