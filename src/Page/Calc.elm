module Page.Calc exposing (..)

import Html exposing (Html, a, div, h2, h3, hr, i, img, input, li, p, text, ul)
import Html.Attributes exposing (alt, attribute, class, href, src, style, type_, value)
import Html.Events exposing (onClick)
import Basics.Extra exposing (flip)
import List exposing (drop, foldl, foldr, take)
import Markdown
import Maybe exposing (andThen, withDefault)
import Page.Common
import Result exposing (toMaybe)
import String exposing (fromFloat, fromInt)
import Json.Decode as Json
import Browser.Events

-- PAGE INFO

info : Page.Common.PageInfo Msg
info = {
     name = "calc"
     , hash = "calc"
     , description = Markdown.toHtml [class "info"] """

A very simple and basic calculator
       """
     , srcRel = "Page/Calc.elm"
 }

-- MODEL

type State =
     ERROR
   | ACCUM
   | OPERATOR
   | DOT

type alias Model = {
     outputs: List Float
   , operators: List Op
   , state: State
   , accumulator: String
   , memory: Maybe Float
 }

init: (Model, Cmd Msg)
init = (
    {
      outputs = []
    , operators = []
    , state = ACCUM
    , accumulator = ""
    , memory = Nothing
    },
    Cmd.none)

-- MESSAGES

type Op =
    Plus
  | Minus
  | Multiply
  | Divide
  | Result

type Token =
    Clear
  | Digit Int
  | Dot
  | Operator Op
  | MR
  | MC
  | MS


type Msg =
    Emitted Token
  | KeyMsg String

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Emitted token ->
            apply token model
        KeyMsg key ->
            let
                -- dummy = Debug.log "--> " key
                token = case key of
                    "0" -> Just (Digit 0)
                    "1" -> Just (Digit 1)
                    "2" -> Just (Digit 2)
                    "3" -> Just (Digit 3)
                    "4" -> Just (Digit 4)
                    "5" -> Just (Digit 5)
                    "6" -> Just (Digit 6)
                    "7" -> Just (Digit 7)
                    "8" -> Just (Digit 8)
                    "9" -> Just (Digit 9)
                    "+" -> Just (Operator Plus)
                    "-" -> Just (Operator Minus)
                    "/" -> Just (Operator Divide)
                    "*" -> Just (Operator Multiply)
                    "=" -> Just (Operator Result)
                    "." -> Just Dot
                    "Delete" -> Just Clear
                    _ -> Nothing
            in
                token
                  |> Maybe.map (flip apply model)
                  |> Maybe.withDefault (model, Cmd.none)

-- apply the given token to the model, computing a new state
apply : Token -> Model -> (Model,  Cmd Msg)
apply token model =
  case model.state of
    ACCUM ->
        case token of
            Clear ->
                model
                  |> doClear
            Digit _ ->
                (model
                  |> doAccumulate token,
                  Cmd.none)
            Dot ->
                (model
                  |> doAccumulate token
                  |> go DOT,
                  Cmd.none)
            Operator op ->
                (model
                  |> doOperator op
                  |> go OPERATOR,
                  Cmd.none)
            MR ->
                (model
                  |> doMR
                  |> go OPERATOR,
                  Cmd.none)                  
            MC ->
                (model
                  |> doMC
                  |> go OPERATOR,
                  Cmd.none)
            MS ->
                (model
                  |> doMS
                  |> go OPERATOR,
                  Cmd.none)

    OPERATOR ->
        case token of
            Clear ->
                model
                  |> doClear
            Digit _ ->
                (model
                  |> doResetAccu
                  |> doAccumulate token
                  |> go ACCUM,
                  Cmd.none)
            Dot ->
                (model
                  |> doResetAccu
                  |> doAccumulate token
                  |> go DOT,
                  Cmd.none)
            Operator op ->
                (model
                  |> doOperator op,
                  Cmd.none)
            MR ->
                (model
                  |> doMR,
                  Cmd.none)
            MC ->
                (model
                  |> doMC,
                  Cmd.none)
            MS ->
                (model
                  |> doMS,
                  Cmd.none)

    DOT ->
        case token of
            Clear ->
                model
                  |> doClear
            Digit _ ->
                (model
                  |> doAccumulate token,
                  Cmd.none)
            Dot ->
                (model, Cmd.none)
            Operator op ->
                (model
                  |> doOperator op
                  |> go OPERATOR,
                  Cmd.none)
            MR ->
                (model
                  |> doMR
                  |> go OPERATOR,
                  Cmd.none)
            MC ->
                (model
                  |> doMC
                  |> go OPERATOR,
                  Cmd.none)
            MS ->
                (model
                  |> doMS
                  |> go OPERATOR,
                  Cmd.none)
    ERROR ->
        case token of
            Clear -> doClear model
            _ -> (model, Cmd.none)


doAccumulate : Token -> Model -> Model
doAccumulate d model =
  let
    value = case (d, model.accumulator) of
                (Digit 0, "") -> ""
                (Digit n, a ) -> a ++ (String.fromInt n)
                (Dot, a) -> a ++ "."
                (_, a) -> a
  in
    { model | accumulator = value }

doOperator : Op -> Model -> Model
doOperator op model =
  let
    reduce m o =
        case m.operators of
            head::tail ->
                if (opPriority o) <= (opPriority head) then
                    let
                        (args, rest) = (take 2 m.outputs, drop 2 m.outputs)
                        r = case head of
                            Plus -> foldr (\a b -> a + b) 0 args
                            Minus -> foldl (\a b -> a - b) 0 args
                            Multiply -> foldr (\a b -> b * a) 1 args
                            Divide -> foldl (\a b -> a / b) 1 args
                            Result -> 0.0 -- should not occur
                    in
                        reduce {m | operators = tail, outputs = r :: rest, accumulator = (fromFloat r) } o

                else
                    m
            [] -> m

    c2 = { model | outputs = (Result.withDefault 0.0 (result model)) :: model.outputs }
    c = reduce c2 op
  in
    case op of
      Result -> c
      _ -> { c | operators = op :: c.operators }


doResetAccu : Model -> Model
doResetAccu model = { model | accumulator = "" }

doClear : Model -> ( Model, Cmd Msg )
doClear model = init

doMS : Model -> Model
doMS model =  { model | memory = toMaybe (result model) }


doMC : Model -> Model
doMC model =  { model | memory = Nothing }

doMR : Model -> Model
doMR model =
    case model.memory of
        Just v -> { model | accumulator = (fromFloat v) }
        Nothing -> model

go : State -> Model -> Model
go state model = { model | state = state }

opPriority : Op -> Int
opPriority op =
    case op of
        Plus -> 1
        Minus -> 1
        Multiply -> 2
        Divide -> 2
        Result -> 0

result : Model -> Result String Float
result model =
  case model.state of
    ERROR -> Err "error"
    _ ->
        case model.accumulator of
            "" -> Ok 0.0
            d -> String.toFloat d |> Result.fromMaybe "error"

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
-- subscriptions model = Keyboard.presses KeyMsg
subscriptions model =
    let
      eventKeyDecoder = Json.field "key" (Json.string |> Json.map KeyMsg)
    in
      Browser.Events.onKeyPress eventKeyDecoder


-- VIEW

view : Model -> Html Msg
view model =
  div [ class "container animated flipInX" ]
      [ hr [] []
       ,p [class "text-muted"]
           [ text "A very simple and basic calculator." ]
       , div [class "calc"]
         [
           -- display
           div [class "row display"]
             [
                div [class "col-11"]
                 [
                   input [ class "lcd", attribute "readOnly" "", type_ "Text", value (display model) ]
                         []

                 ]
                , div [] [
                    renderMemoryTag model
                   ,renderOperatorTag model
                ]
             ]
          -- buttons
          ,div [class "row buttons"]
            [ button (Digit 7) model, button (Digit 8) model, button (Digit 9) model, button (Operator Plus)  model, button Clear  model ]
          ,div [class "row buttons"]
            [ button (Digit 4) model, button (Digit 5) model, button (Digit 6) model, button (Operator Minus)  model, button MS  model ]
          ,div [class "row buttons"]
            [ button (Digit 1) model, button (Digit 2) model, button (Digit 3) model, button (Operator Multiply)  model, button MR  model ]
          ,div [class "row buttons"]
            [ button Dot model, button (Digit 0) model, button (Operator Result) model, button (Operator Divide)  model, button MC  model ]
         ]
      ]

-- accept tells if the given token can be accepted regarding the current state (model)
-- used to find if a button should be enabled or disabled depending on the calc context.
accept: Model -> Token -> Bool
accept model token =
   case token of
      Dot ->
        model.state /= DOT

      MR ->
        case model.memory of
            Just _ -> True
            Nothing -> False
      MC ->
        case model.memory of
            Just _ -> True
            Nothing -> False
      _ ->
        True

renderMemoryTag : Model -> Html Msg
renderMemoryTag model =
    div [class "tag"]
    [
      text (model.memory
            |> Maybe.map (\it -> "M")
            |> withDefault " ")
    ]

renderOperatorTag: Model -> Html Msg
renderOperatorTag model =
   div [class "tag"]
   [
     model.operators
        |> List.head
        |> Maybe.map (\token ->
             case token of
                Plus -> "+"
                Minus -> "-"
                Multiply -> "x"
                Divide -> "/"
                Result -> "="
           )
        |> withDefault " "
        |> text
   ]

display : Model -> String
display model =
  case model.accumulator of
    "" -> "0"
    v -> v

-- returns an html representation of the given token regarding the current state (model)
button : Token -> Model -> Html Msg
button token model =
  let
    disabled = if accept model token then "" else " disabled"
    render txt style =
        div [class style]
           [
              Html.button
              [  type_ "button"
               , class ("btn" ++ disabled)
               , onClick (Emitted token)
              ]
              [
                text txt
              ]
           ]
  in
      case token of
        Clear             -> render "C" "clear col-2 push-1"
        Digit d           -> render (fromInt d) "digit col-2"
        Operator Plus     -> render "+" "operator col-2 push-1"
        Operator Minus    -> render "-" "operator col-2 push-1"
        Operator Multiply -> render "x" "operator col-2 push-1"
        Operator Divide   -> render "/" "operator col-2 push-1"
        Operator Result   -> render "=" "result col-2"
        MR                -> render "MR" "memory col-2 push-1"
        MC                -> render "MC" "memory col-2 push-1"
        MS                -> render "MS" "memory col-2 push-1"
        Dot               -> render "." "dot col-2"