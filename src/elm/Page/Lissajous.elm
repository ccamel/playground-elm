module Page.Lissajous exposing (..)

import AnimationFrame
import Collage exposing (Form, LineStyle, Path, circle, collage, defaultLine, filled, group, move, moveY, oval, path, rect, rotate, segment, traced)
import Color exposing (Color, darkPurple, green, lightGrey, red, rgb)
import ColorPicker
import Element exposing (container, middle, toHtml)
import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Locale, usLocale)
import Html exposing (Html, a, br, button, code, div, form, h2, h3, hr, i, img, input, label, li, p, span, text, u, ul)
import Html.Attributes exposing (alt, attribute, class, href, id, max, min, name, size, src, step, style, type_, value)
import Html.Events exposing (defaultOptions, onClick, onInput, onWithOptions)
import Json.Decode exposing (succeed)
import List exposing (append, concatMap, drop, length, map, range, sum)
import Markdown
import Maybe exposing (andThen, withDefault)
import Page.Common exposing (asCss, strToFloatWithMinMax, strToIntWithMinMax)
import Result exposing (toMaybe)
import Round
import String exposing (padLeft)
import String.Interpolate exposing (interpolate)
import Text exposing (color, fromString, monospace)
import Time exposing (Time)



-- PAGE INFO

info : Page.Common.PageInfo Msg
info = {
     name = "lissajous"
     , hash = "lissajous"
     , description = Markdown.toHtml [class "info"] """
Animated [Lissajous figures](https://en.wikipedia.org/wiki/Lissajouss_curve).

This demo allows to visualize Lissajous curves in motion and adjust some parameters in real-time.


       """
     , srcRel = "Page/Lissajous.elm"
 }

-- MODEL

type alias Model = {
    -- parameter a for the lissajous curve
     a : Int
    -- parameter b for the lissajous curve
    ,b : Int
    -- phase for the lissajous curve (in degrees, more simpler for humans)
    ,p: Float
    -- velocity of the phase in turns (2*pi) per minutes
    ,vp: Float
    -- if animation is started or not
    ,started: Bool
    -- style for the curve
    ,curveStyle : LineStyle
    -- resolution of the line - i.e. total number of points to draw the curve (1 period), more is best
    ,resolution : Int
    -- a list containing n last ticks, used to compute the fps (frame per seconds)
    ,ticks : Ticks
    ,foregroundColorPicker : ColorPicker.State
  }

initialModel : Model
initialModel = {
      a = 3
     ,b = 4
     ,p = 90 -- π/2
     ,vp = 1
     ,started = True
     ,curveStyle = { defaultLine | width = 2, color = rgb 31 122 31 }
     ,resolution = 500
     ,ticks = createTicks 100 -- initial capacity
     ,foregroundColorPicker = ColorPicker.empty
  }

initialCmd : Cmd Msg
initialCmd = Cmd.none

-- UPDATE
type Msg =
      Reset Model
    | Tick Time
    | Start
    | Stop
    | SetPhaseVelocity String
    | SetAParemeter String
    | SetBParameter String
    | SetResolution String
    | SetPhase String
    | ForegroundColorPickerMsg ColorPicker.Msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Reset m -> (m, initialCmd)
    Tick diff ->
        let
          -- compute the new phase according to velocity (diff is in ms)
          v = model.p + (diff*model.vp * 2 * 360/60000)
               |> modulo 180
        in
          ({ model | p = v
                   ,ticks = addTick model.ticks diff}
           ,Cmd.none)
    Start -> ({ model | started = True
                      ,ticks = resetTick model.ticks }
              ,Cmd.none)
    Stop ->  ({ model | started = False },Cmd.none)
    SetPhaseVelocity s ->
        (case (strToFloatWithMinMax s 0 1000) of
            Just v -> { model | vp = v }
            Nothing -> model
         ,Cmd.none)
    SetAParemeter s ->
        (case (strToIntWithMinMax s 1 10) of
            Just v -> { model | a = v }
            Nothing -> model
         ,Cmd.none)
    SetBParameter s ->
        (case (strToIntWithMinMax s 1 10) of
            Just v -> { model | b = v }
            Nothing -> model
         ,Cmd.none)
    SetResolution s ->
        (case (strToIntWithMinMax s 5 1000) of
            Just v -> { model | resolution = v }
            Nothing -> model
         ,Cmd.none)
    SetPhase p ->
        if not model.started then
            case (String.toFloat p) of
                Ok v -> ({ model | p = modulo 180.0 v }, Cmd.none)
                Err _ -> (model, Cmd.none)
        else
            (model, Cmd.none)
    ForegroundColorPickerMsg msg ->
            let
                curveStyle = model.curveStyle
                ( state, color ) =
                    ColorPicker.update msg curveStyle.color model.foregroundColorPicker
            in
                ({ model
                    | foregroundColorPicker = state
                    , curveStyle = { curveStyle | color = color |> Maybe.withDefault curveStyle.color }
                 }
                 , Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    if model.started then
        AnimationFrame.diffs Tick
    else
        Sub.none


-- VIEW
constants : { width: Int, height: Int, period: Float, margin : Int }
constants = {
   -- width of the canvas
    width = 400
   -- height of the canvas
   ,height = 400
   -- period
   ,period = 2 * pi

   ,margin = 50
  }

view : Model -> Html Msg
view model =
  div [ class "container animated flipInX" ]
      [ hr [] []
       -- canvas for the lissajous
       ,div [class "row display"]
       [
           div [ id "lissajous-scope col-sm-6" ]
           [
             toHtml <|
              container constants.width constants.height middle  <|
                  collage constants.width constants.height
                    [
                       backgroundForm (rgb 0 0 0)
                      ,xAxisForm
                      ,yAxisForm
                      ,(lissajous model.a model.b (toRadian model.p)) model.resolution
                        |> traced model.curveStyle
                      ,interpolate "{0} fps"
                                   [ fps model.ticks
                                           |> Maybe.map (format locale1digit)
                                           |> withDefault "-"
                                           |> padLeft 5 ' '
                                   ]
                        |> fromString
                        |> monospace
                        |> color (rgb 217 217 217)
                        |> Collage.text
                        |> move ((constants.height // 2) - constants.margin |> toFloat, (constants.width - 12) // 2 |> toFloat)
                    ]
           ]
           , div [class "description col-sm-5 col-sm-offset-1"]
           [
              Markdown.toHtml [class "info"] """
##### Animated [Lissajouss figures](https://en.wikipedia.org/wiki/Lissajouss_curve) using HTML5 canvas.
            """
            , br [] []
            , p []
              [
                  text "You can "
                , case model.started of
                    False -> a [class "action", href "", onClickNotPropagate Start ] [ text "start" ]
                    True  -> a [class "action", href "", onClickNotPropagate Stop ] [ text "stop" ]
                , text " the animation. You can also "
                , a [class "action", href "", onClickNotPropagate (Reset initialModel) ] [ text "reset" ]
                , text " the values to default."
              ]
            , let
                deltas = [(1,2),(3,2),(3,4),(5,4)]
                link (pa,pb) =
                    let
                        selected = if (pa,pb) == (model.a, model.b) then " selected" else ""
                        clazz = "action" ++ selected
                    in
                        [  a [class clazz, href "", onClickNotPropagate (Reset { model | a = pa, b = pb }) ]
                           [
                                text (interpolate "({0},{1})" ([pa,pb] |> map toString))
                           ]
                          ,text "  " -- add some space, but this is not great
                        ]
              in
                 p [] <|
                   ((text "You can also try some examples of Lissajouss figures with δ = π/2:")
                      :: concatMap link deltas)

            , p []
              [
                  text "The animation consists in shifting the phase by "
                , input [ class "input-number"
                     ,name "phase-velocity"
                     ,type_ "number"
                     ,size 3
                     ,value (toString model.vp)
                     ,onInput SetPhaseVelocity] []
                , a [href "https://en.wikipedia.org/wiki/Revolutions_per_minute" ] [text "rev/min"]
                , text ". The resolution is "
                , input [ class "input-number"
                                     ,name "curve-resolution"
                                     ,type_ "number"
                                     ,size 4
                                     ,value (toString model.resolution)
                                     ,step "10"
                                     ,onInput SetResolution] []
                , text ", which represents the total number of points used to draw the curve (more is better)."
              ]
            , p[ class "form-inline" ] [
                  text "The color for the plot is"
                 ,div []
                    [
                      button [ attribute "aria-expanded" "false"
                              ,attribute "aria-haspopup" "true"
                              ,class "btn btn-secondary dropdown-toggle"
                              ,attribute "data-toggle" "dropdown"
                              ,id "dropdownForegroundColorPickerButton"
                              ,type_ "button" ]
                              [ span [ class "color-tag"
                                      ,Html.Attributes.style [("background-color", asCss model.curveStyle.color)]
                                     ] []
                              ]
                     ,div [ attribute "aria-labelledby" "dropdownForegroundColorPickerButton"
                           ,class "dropdown-menu" ]
                          [ ColorPicker.view model.curveStyle.color model.foregroundColorPicker |> Html.map ForegroundColorPickerMsg ]
                    ]
                 ,text " (click to change)."
              ]
            , p [] [text "The equations are:"]
            , div [class "equation"] [
                  p [] [ text " •  x = "
                        ,text (toString constants.width)
                        ,text " sin("
                        ,input [ class "input-number"
                                  ,name "a-parameter"
                                  ,type_ "number"
                                  ,size 1
                                  ,value (toString model.a)
                                  ,onInput SetAParemeter] []
                        ,text "t + "
                        ,input [ class "input-number"
                                  ,name "phase"
                                  ,type_ "number"
                                  ,size 1
                                  ,value (Round.round 2 model.p)
                                  ,onInput SetPhase] []
                        ,text "°)"
                  ]
                 ,p [] [ text " •  y = "
                        ,text (toString constants.width)
                        ,text " sin("
                        ,input [ class "input-number"
                                  ,name "b-parameter"
                                  ,type_ "number"
                                  ,size 1
                                  ,value (toString model.b)
                                  ,onInput SetBParameter] []
                        ,text "t)"
                  ]
             ]
           ]
        ]
      ]

xAxisForm : Form
xAxisForm =
    let
        halfW = constants.width // 2
        halfH = constants.height // 2
        axis = segment (-halfW |> toFloat, 0) ( halfH  |> toFloat, 0)
        ticks = rangeStep -halfW halfW 10 -- TODO: not sure it's optimal
          |> List.map toFloat
          |> List.map (\v -> segment (v, 0) (v, 5))

    in
        axis :: ticks
         |> map (traced { defaultLine | color = rgb 89 89 89 })
         |> group

yAxisForm : Form
yAxisForm =
    xAxisForm
      |> rotate (degrees 90)

backgroundForm : Color -> Form
backgroundForm color =
    let
        halfW = constants.width // 2
        halfH = constants.height // 2
        circleAt (x,y) = circle 1.0
                        |> filled (rgb 64 64 64)
                        |> move ((toFloat x),(toFloat y))
    in
        group [
            (rect (constants.width |> toFloat) (constants.height |> toFloat)
              |> filled color)
            ,(cartesian (rangeStep -halfW halfW 25) (rangeStep -halfH halfH 25)
              |> map circleAt
              |> group )
          ]



-- Functions

-- returns a function that compute the path for the lissajous given the desired resolution.
-- the curve is computed according to the given parameters a, b and phase
lissajous : Int -> Int -> Float -> (Int-> Path)
lissajous a b phase =
  let
    half v = toFloat v / 2
    m = (toFloat a)
    n = (toFloat b)
    coord t = (  half (constants.width - constants.margin) * sin (m*t+phase)
                ,half (constants.height - constants.margin) * sin (n*t))
  in
    \res ->
        range 0 res
          |> map (\step -> (toFloat step) * (constants.period) / (toFloat res))
          |> map (coord)
          |> path

modulo : Float -> Float -> Float
modulo range v =
    case (v >= range, v < 0) of
        (True, False) -> modulo range (v - range)
        (False, True) -> modulo range (range + v)
        _ -> v

toRadian : Float -> Float
toRadian deg = deg * pi / 180.0

locale1digit : Locale
locale1digit =
    Locale 1 "," "." "−" ""

onClickNotPropagate : a -> Html.Attribute a
onClickNotPropagate msg = onWithOptions "click" {defaultOptions | preventDefault = True} (succeed msg)

-- the ticks data type

-- ticks holds a sequence of times.
-- the list is bounded to accept a max number of elements -> inserting a new only discards the oldest one
type alias Ticks = {
    times : List Time,
    capacity: Int
  }

createTicks : Int -> Ticks
createTicks capacity = { times = [], capacity = capacity }

addTick : Ticks -> Time -> Ticks
addTick ticks time =
    let
        delta = (length ticks.times) - ticks.capacity
        makePlace ticks = if delta >= 0 then (drop (delta + 1) ticks) else ticks
    in
    { ticks | times = ticks.times
                                |> makePlace
                                |> (::) time

    }

resetTick : Ticks -> Ticks
resetTick ticks = {ticks | times = [] }

-- compute the FPS from the given fps set (if possible)
fps : Ticks -> Maybe Float
fps ticks =
    let
        size = length ticks.times
    in if size > 1 then
        ticks.times
          |> sum
          |> (/) (toFloat size)
          |> (*) 1000.0
          |> Just
    else
        Nothing

cartesian : List a -> List b -> List (a,b)
cartesian xs ys =
  List.concatMap
    ( \x -> List.map ( \y -> (x, y) ) ys )
    xs

rangeStep : Int -> Int -> Int -> List Int
rangeStep lo hi step =
  let
    rangeRec lo hi step list =
      if lo <= hi then
        rangeRec lo (hi - step) step (hi :: list)
      else
        list
  in
    rangeRec lo hi step []
