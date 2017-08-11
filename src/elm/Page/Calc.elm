module Page.Calc exposing (..)

import Html exposing (Html, a, div, h2, h3, hr, i, img, input, li, p, text, ul)
import Html.Attributes exposing (alt, attribute, class, href, src, style, type_, value)
import Html.Events exposing (onClick)
import List exposing (drop, foldl, foldr, take)
import Markdown
import Maybe exposing (andThen, withDefault)
import Page.Common
import Result exposing (toMaybe)

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

initialModel : Model
initialModel = {
     outputs = []
   , operators = []
   , state = ACCUM
   , accumulator = ""
   , memory = Nothing
  }

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

-- UPDATE

update : Msg -> Model -> Model
update msg model =
    case msg of
        Emitted token -> apply token model


-- apply the given token to the model, computing a new state
apply : Token -> Model -> Model
apply token model =
  case model.state of
    ACCUM ->
        case token of
            Clear ->
                model
                  |> doClear
            Digit _ ->
                model
                  |> doAccumulate token
            Dot ->
                model
                  |> doAccumulate token
                  |> go DOT
            Operator op ->
                model
                  |> doOperator op
                  |> go OPERATOR
            MR ->
                model
                  |> doMR
                  |> go OPERATOR
            MC ->
                model
                  |> doMC
                  |> go OPERATOR
            MS ->
                model
                  |> doMS
                  |> go OPERATOR

    OPERATOR ->
        case token of
            Clear ->
                model
                  |> doClear
            Digit _ ->
                model
                  |> doResetAccu
                  |> doAccumulate token
                  |> go ACCUM
            Dot ->
                model
                  |> doResetAccu
                  |> doAccumulate token
                  |> go DOT
            Operator op ->
                model
                  |> doOperator op
            MR ->
                model
                  |> doMR
            MC ->
                model
                  |> doMC
            MS ->
                model
                  |> doMS

    DOT ->
        case token of
            Clear ->
                model
                  |> doClear
            Digit _ ->
                model
                  |> doAccumulate token
            Dot ->
                model
            Operator op ->
                model
                  |> doOperator op
                  |> go OPERATOR
            MR ->
                model
                  |> doMR
                  |> go OPERATOR
            MC ->
                model
                  |> doMC
                  |> go OPERATOR
            MS ->
                model
                  |> doMS
                  |> go OPERATOR
    ERROR ->
        case token of
            Clear -> doClear model
            _ -> model


doAccumulate : Token -> Model -> Model
doAccumulate d model =
  let
    value = case (d, model.accumulator) of
                (Digit 0, "") -> ""
                (Digit n, a ) -> a ++ (toString n)
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
                        result = case head of
                            Plus -> foldr (\a b -> a + b) 0 args
                            Minus -> foldl (\a b -> a - b) 0 args
                            Multiply -> foldr (\a b -> b * a) 1 args
                            Divide -> foldl (\a b -> a / b) 1 args
                            Result -> 0.0 -- should not occur
                    in
                        reduce {m | operators = tail, outputs = result :: rest, accumulator = (toString result) } o

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

doClear : Model -> Model
doClear model = initialModel

doMS : Model -> Model
doMS model =  { model | memory = toMaybe (result model) }


doMC : Model -> Model
doMC model =  { model | memory = Nothing }

doMR : Model -> Model
doMR model =
    case model.memory of
        Just v -> { model | accumulator = (toString v) }
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
            d -> String.toFloat d

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

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
                Result -> "=")
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
        Digit d           -> render (toString d) "digit col-2"
        Operator Plus     -> render "+" "operator col-2 push-1"
        Operator Minus    -> render "-" "operator col-2 push-1"
        Operator Multiply -> render "x" "operator col-2 push-1"
        Operator Divide   -> render "/" "operator col-2 push-1"
        Operator Result   -> render "=" "result col-2"
        MR                -> render "MR" "memory col-2 push-1"
        MC                -> render "MC" "memory col-2 push-1"
        MS                -> render "MS" "memory col-2 push-1"
        Dot               -> render "." "dot col-2"