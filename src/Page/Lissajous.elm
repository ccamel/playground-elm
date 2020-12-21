module Page.Lissajous exposing (..)

import GraphicSVG exposing (LineType, Shape, Stencil, circle, filled, fixedwidth, group, line, move, openPolygon, outlined, rect, rotate, solid)
import GraphicSVG.Widget as Widget
import Basics.Extra exposing (flip)
import Color exposing (rgb255, green, red, toCssString)
import ColorPicker
import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Locale, usLocale)
import Html exposing (Html, a, br, button, div, hr, input, p, span, text)
import Html.Attributes exposing (attribute, class, href, id, name, size, step, style, type_, value)
import Html.Events exposing (onInput)
import List exposing (concatMap, drop, length, map, range, sum)
import Markdown
import Maybe exposing (withDefault)
import Page.Common exposing (strToFloatWithMinMax, strToIntWithMinMax)
import Platform.Cmd exposing (batch)
import Round
import String exposing (padLeft)
import String.Interpolate exposing (interpolate)
import Task
import Browser.Events
import Page.Common exposing (onClickNotPropagate)
import String exposing (fromInt)
import Browser.Events exposing (onAnimationFrameDelta)
import String exposing (fromFloat)


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
    -- widget underlying model
    ,widgetState : Widget.Model
  }

type alias LineStyle =
    { color : Color.Color
    , lineType : LineType
    }

init: (Model, Cmd Msg)
init =
    let
        (widgetModel, widgetCmd) = Widget.init (toFloat constants.width) (toFloat constants.height) "lissajous"
    in
        ({
              a = 3
             ,b = 4
             ,p = 90 -- π/2
             ,vp = 1
             ,started = True
             ,curveStyle = { color = Color.rgb255 31 122 31, lineType = solid 2 }
             ,resolution = 500
             ,ticks = createTicks 100 -- initial capacity
             ,foregroundColorPicker = ColorPicker.empty
             ,widgetState = widgetModel
          },
          batch [
            Cmd.map WidgetMessage widgetCmd
          ])

-- UPDATE
type Msg =
      Reset
    | Tick Float
    | Start
    | Stop
    | SetPhaseVelocity String
    | SetAParemeter String
    | SetBParameter String
    | SetResolution String
    | SetPhase String
    | ForegroundColorPickerMsg ColorPicker.Msg
    | WidgetMessage Widget.Msg
    | Batch (List Msg)
    | NoOp

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Reset -> init
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
                Just v -> ({ model | p = modulo 180.0 v }, Cmd.none)
                Nothing -> (model, Cmd.none)
        else
            (model, Cmd.none)
    ForegroundColorPickerMsg msgf ->
            let
                curveStyle = model.curveStyle
                ( state, color ) =
                    ColorPicker.update msgf curveStyle.color model.foregroundColorPicker
            in
                ({ model
                    | foregroundColorPicker = state
                    , curveStyle = { curveStyle | color = Maybe.withDefault curveStyle.color color }
                 }
                 , Cmd.none)
    WidgetMessage msgw ->
            let
                (widgetModel, widgetCmd) = Widget.update msgw model.widgetState
            in
                ({ model | widgetState = widgetModel }, Cmd.map WidgetMessage widgetCmd)
    Batch [] ->
       ( model, Cmd.none )
    Batch (x :: xs) ->
        let
            ( newModel, cmd ) =
                update x model
        in
            ( newModel
            , Cmd.batch [ cmd, sendMsg (Batch xs) ]
            )
    NoOp -> (model, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    if model.started then
        onAnimationFrameDelta Tick
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
       , Markdown.toHtml [class "info"] """
##### Animated [Lissajouss figures](https://en.wikipedia.org/wiki/Lissajouss_curve) using [Scalable Vector Graphics](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics) (SVG).
                    """
       ,br [] []
       ,div [class "row display"]
       [
           -- canvas for the lissajous
           div [ id "lissajous-scope col-sm-6", style "width" (toPixels constants.width), style "height" (toPixels constants.height)]
           [
             Widget.view model.widgetState [
                 backgroundForm (rgb255 0 0 0)
                ,xAxisForm
                ,yAxisForm
                ,(lissajous model.a model.b (toRadian model.p)) model.resolution
                    |> outlined model.curveStyle.lineType (toSvgColor model.curveStyle.color)
                ,interpolate "{0} fps"
                             [ fps model.ticks
                                     |> Maybe.map (format locale1digit)
                                     |> withDefault "-"
                                     |> padLeft 5 ' '
                             ]
                  |> GraphicSVG.text
                  |> fixedwidth
                  |> filled (Color.rgb255 217 217 217 |> toSvgColor)
                  |> move ((constants.height // 2) - (constants.margin + 20) |> toFloat, (constants.width - 20) // 2 |> toFloat)
             ]
           ]
           , div [class "description col-sm-6"]
           [
              p []
              [
                  text "You can "
                , case model.started of
                    False -> a [class "action", href "", onClickNotPropagate Start ] [ text "start" ]
                    True  -> a [class "action", href "", onClickNotPropagate Stop ] [ text "stop" ]
                , text " the animation. You can also "
                , a [class "action", href "", onClickNotPropagate (Reset) ] [ text "reset" ]
                , text " the values to default."
              ]
            , p [] [text "The equations are:"]
            , div [class "equation"] [
                  p [] [ text " •  x = "
                        ,text (fromInt constants.width)
                        ,text " sin("
                        ,input [ class "input-number"
                                  ,name "a-parameter"
                                  ,type_ "number"
                                  ,size 1
                                  ,value (fromInt model.a)
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
                        ,text (fromInt constants.width)
                        ,text " sin("
                        ,input [ class "input-number"
                                  ,name "b-parameter"
                                  ,type_ "number"
                                  ,size 1
                                  ,value (fromInt model.b)
                                  ,onInput SetBParameter] []
                        ,text "t)"
                  ]
             ]
            , let
                deltas = [(1,2),(3,2),(3,4),(5,4)]
                link (pa,pb) =
                    let
                        selected = if (pa,pb) == (model.a, model.b) then " selected" else ""
                        clazz = "action" ++ selected
                    in
                        [  a [class clazz, href "", onClickNotPropagate (Batch [SetAParemeter (fromInt pa), SetBParameter (fromInt pb)]) ]
                           [
                                text (interpolate "({0},{1})" ([pa,pb] |> map fromInt))
                           ]
                          ,text "  " -- add some space, but this is not great
                        ]
              in
                 p [] <|
                   ((text "You can also try some examples of Lissajouss figures with δ = π/2:")
                      :: concatMap link deltas)
            , p[ class "form-inline" ] [
                  text "The color for the plot is"
                 ,div []
                    [
                      button [
                               attribute "aria-expanded" "false"
                              ,attribute "aria-haspopup" "true"
                              ,class "btn btn-light dropdown-toggle"
                              ,attribute "data-toggle" "dropdown"
                              ,id "dropdownForegroundColorPickerButton"
                              ,type_ "button" ]
                              [ span [ class "color-tag"
                                      ,style "background-color" (toCssString model.curveStyle.color)
                                     ] []
                              ]
                     ,div [ attribute "aria-labelledby" "dropdownForegroundColorPickerButton"
                           ,class "dropdown-menu" ]
                          [ ColorPicker.view model.curveStyle.color model.foregroundColorPicker |> Html.map ForegroundColorPickerMsg ]
                    ]
                 ,text " (click to change)."
              ]
            , p []
              [
                  text "The animation consists in shifting the phase by "
                , input [ class "input-number"
                     ,name "phase-velocity"
                     ,type_ "number"
                     ,size 3
                     ,value (fromFloat model.vp)
                     ,onInput SetPhaseVelocity] []
                , a [href "https://en.wikipedia.org/wiki/Revolutions_per_minute" ] [text "rev/min"]
                , text ". The resolution is "
                , input [ class "input-number"
                                     ,name "curve-resolution"
                                     ,type_ "number"
                                     ,size 4
                                     ,value (fromInt model.resolution)
                                     ,step "10"
                                     ,onInput SetResolution] []
                , text ", which represents the total number of points used to draw the curve (more is better)."
              ]
           ]
        ]
      ]

xAxisForm : Shape Msg
xAxisForm =
    let
        halfW = constants.width // 2
        halfH = constants.height // 2
        axis = line (-halfW |> toFloat, 0) ( halfH  |> toFloat, 0)
        ticks = rangeStep -halfW halfW 10 -- TODO: not sure it's optimal
          |> List.map toFloat
          |> List.map (\v -> line (v, 0) (v, 5))

    in
        axis :: ticks
         |> map (outlined  (solid 1) (Color.rgb255 89 89 89 |> toSvgColor) )
         |> group

yAxisForm : Shape Msg
yAxisForm =
    xAxisForm
      |> rotate (degrees 90)

backgroundForm : Color.Color -> Shape Msg
backgroundForm color =
    let
        halfW = constants.width // 2
        halfH = constants.height // 2
        circleAt (x,y) = circle 1.0
                        |> filled (Color.rgb255 64 64 64 |> toSvgColor)
                        |> move ((toFloat x),(toFloat y))
    in
        group [
            (rect (constants.width |> toFloat) (constants.height |> toFloat)
              |> filled (toSvgColor color))
            ,(cartesian (rangeStep -halfW halfW 25) (rangeStep -halfH halfH 25)
              |> map circleAt
              |> group )
          ]



-- Functions

-- returns a function that compute the path for the lissajous given the desired resolution.
-- the curve is computed according to the given parameters a, b and phase
lissajous : Int -> Int -> Float -> (Int-> Stencil)
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
          |> openPolygon

modulo : Float -> Float -> Float
modulo range v =
    case (v >= range, v < 0) of
        (True, False) -> modulo range (v - range)
        (False, True) -> modulo range (range + v)
        _ -> v

toRadian : Float -> Float
toRadian deg = deg * pi / 180.0

locale1digit : Locale
locale1digit = {
    usLocale | 
        decimals = 1,
        thousandSeparator = ",",
        decimalSeparator = ".",
        negativePrefix = "−"    
  }

-- the ticks data type

-- ticks holds a sequence of times.
-- the list is bounded to accept a max number of elements -> inserting a new only discards the oldest one
type alias Ticks = {
    times : List Float,
    capacity: Int
  }

createTicks : Int -> Ticks
createTicks capacity = { times = [], capacity = capacity }

addTick : Ticks -> Float -> Ticks
addTick ticks time =
    let
        delta = (length ticks.times) - ticks.capacity
        makePlace ticks2 = if delta >= 0 then (drop (delta + 1) ticks2) else ticks2
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
    rangeRec lo2 hi2 step2 list =
      if lo2 <= hi2 then
        rangeRec lo2 (hi2 - step2) step2 (hi2 :: list)
      else
        list
  in
    rangeRec lo hi step []

toSvgColor : Color.Color -> GraphicSVG.Color
toSvgColor c =
  let
    { red, green, blue, alpha } = Color.toRgba c
  in
    GraphicSVG.rgb (255.0 * red) (255.0 * green) (255.0 * blue)

sendMsg : msg -> Cmd msg
sendMsg msg =
    Task.succeed msg |> Task.perform identity

toPixels: Int -> String
toPixels size =
    size
      |> fromInt
      |> (flip String.append) "px"