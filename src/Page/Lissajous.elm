module Page.Lissajous exposing (Model, Msg, info, init, subscriptions, update, view)

import Array
import Browser.Events exposing (onAnimationFrameDelta)
import Color exposing (rgb255)
import ColorPicker
import GraphicSVG exposing (LineType, Shape, Stencil, circle, filled, fixedwidth, group, line, move, openPolygon, outlined, rect, rotate, solid)
import GraphicSVG.Widget as Widget
import Html exposing (Html, a, div, input, p, section, text)
import Html.Attributes exposing (class, href, id, name, size, step, style, type_, value)
import Html.Events exposing (onInput)
import Html.Events.Extra exposing (onClickPreventDefaultAndStopPropagation)
import Lib.Array exposing (BoundedArray, appendToBoundedArray, createBoundedArray, resizeBoundedArray)
import Lib.ColorSelector as ColorSelector
import Lib.Decoder exposing (outsideTarget)
import Lib.Frame exposing (Frames, addFrame, createFrames, fpsText, resetFrames)
import Lib.Page
import Lib.String exposing (strToFloatWithMinMax, strToIntWithMinMax)
import List exposing (concat, concatMap, filterMap, indexedMap, map, range)
import Markdown
import Round
import String exposing (fromFloat, fromInt)
import String.Interpolate exposing (interpolate)
import Task



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "lissajous"
    , hash = "lissajous"
    , date = "2020-11-15"
    , description = Markdown.toHtml [ class "content" ] """
Animated [Lissajous figures](https://en.wikipedia.org/wiki/Lissajous_curve).

This demo allows to visualize Lissajous curves in motion and adjust some parameters in real-time.


       """
    , srcRel = "Page/Lissajous.elm"
    }



-- MODEL


type alias ModelRecord =
    { -- parameter a for the lissajous curve
      a : Int

    -- parameter b for the lissajous curve
    , b : Int

    -- phase for the lissajous curve (in degrees, more simpler for humans)
    , p : Float

    -- velocity of the phase in turns (2*pi) per minutes
    , vp : Float

    -- if animation is started or not
    , started : Bool

    -- style for the curve
    , curveStyle : LineStyle

    -- resolution of the line - i.e. total number of points to draw the curve (1 period), more is best
    , resolution : Int

    -- the afterglow effect (0: none)
    , afterglow : Int

    -- the list of stencils that represents the shapes of the lissajous figures, during time
    , lissajousStencils : BoundedArray (Maybe Stencil)

    -- a list containing n last ticks, used to compute the fps (frame per seconds)
    , ticks : Frames

    -- the foreground color picker
    , foregroundColorPicker : ColorPicker.State

    -- the visibility of the foreground color picker
    , foregroundColorPickerVisible : Bool

    -- widget underlying model
    , widgetState : Widget.Model
    }


type Model
    = Model ModelRecord


type alias LineStyle =
    { color : Color.Color
    , lineType : LineType
    }


init : ( Model, Cmd Msg )
init =
    let
        initialAfterGlow =
            0

        ( widgetModel, widgetCmd ) =
            Widget.init (toFloat constants.width) (toFloat constants.height) "lissajous"
    in
    ( Model
        { a = 3
        , b = 4
        , p = 90 -- π/2
        , vp = 1
        , started = True
        , curveStyle = { color = Color.rgb255 31 122 31, lineType = solid 2 }
        , resolution = 400
        , afterglow = initialAfterGlow
        , lissajousStencils = createBoundedArray (initialAfterGlow + 1) (always Nothing)
        , ticks = createFrames 20 -- initial capacity
        , foregroundColorPicker = ColorPicker.empty
        , foregroundColorPickerVisible = False
        , widgetState = widgetModel
        }
    , Cmd.map WidgetMessage widgetCmd
    )



-- UPDATE


type Msg
    = Reset
    | Tick Float
    | Start
    | Stop
    | SetPhaseVelocity String
    | SetAParemeter String
    | SetBParameter String
    | SetResolution String
    | SetPhase String
    | SetAfterglow String
    | ForegroundColorPickerMsg ColorPicker.Msg
    | ShowForegroundColorPicker Bool
    | WidgetMessage Widget.Msg
    | Batch (List Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    Tuple.mapFirst Model <|
        case msg of
            Reset ->
                let
                    ( Model m, c ) =
                        init
                in
                ( m, c )

            Tick diff ->
                let
                    -- compute the new phase according to velocity (diff is in ms)
                    v =
                        model.p
                            + (diff * model.vp * 2 * 360 / 60000)
                            |> modulo 180

                    lissajousStencils =
                        appendToBoundedArray (Just <| lissajous model.a model.b (toRadian model.p) model.resolution) model.lissajousStencils
                in
                ( { model
                    | p = v
                    , ticks = addFrame model.ticks diff
                    , lissajousStencils = lissajousStencils
                  }
                , Cmd.none
                )

            Start ->
                ( { model
                    | started = True
                    , ticks = resetFrames model.ticks
                  }
                , Cmd.none
                )

            Stop ->
                ( { model | started = False }, Cmd.none )

            SetPhaseVelocity s ->
                ( case strToFloatWithMinMax s 0 1000 of
                    Just v ->
                        { model | vp = v }

                    Nothing ->
                        model
                , Cmd.none
                )

            SetAParemeter s ->
                ( case strToIntWithMinMax s 1 10 of
                    Just v ->
                        { model | a = v }

                    Nothing ->
                        model
                , Cmd.none
                )

            SetBParameter s ->
                ( case strToIntWithMinMax s 1 10 of
                    Just v ->
                        { model | b = v }

                    Nothing ->
                        model
                , Cmd.none
                )

            SetResolution s ->
                ( case strToIntWithMinMax s 5 1000 of
                    Just v ->
                        { model | resolution = v }

                    Nothing ->
                        model
                , Cmd.none
                )

            SetPhase p ->
                if not model.started then
                    case String.toFloat p of
                        Just v ->
                            ( { model | p = modulo 180.0 v }, Cmd.none )

                        Nothing ->
                            ( model, Cmd.none )

                else
                    ( model, Cmd.none )

            SetAfterglow s ->
                ( case strToIntWithMinMax s 0 10 of
                    Just v ->
                        { model
                            | afterglow = v
                            , lissajousStencils = resizeBoundedArray (v + 1) model.lissajousStencils
                        }

                    Nothing ->
                        model
                , Cmd.none
                )

            ForegroundColorPickerMsg msgf ->
                let
                    curveStyle =
                        model.curveStyle

                    ( state, color ) =
                        ColorPicker.update msgf curveStyle.color model.foregroundColorPicker
                in
                ( { model
                    | foregroundColorPicker = state
                    , curveStyle = { curveStyle | color = Maybe.withDefault curveStyle.color color }
                  }
                , Cmd.none
                )

            ShowForegroundColorPicker b ->
                ( { model | foregroundColorPickerVisible = b }, Cmd.none )

            WidgetMessage msgw ->
                let
                    ( widgetModel, widgetCmd ) =
                        Widget.update msgw model.widgetState
                in
                ( { model | widgetState = widgetModel }, Cmd.map WidgetMessage widgetCmd )

            Batch [] ->
                ( model, Cmd.none )

            Batch (x :: xs) ->
                let
                    ( Model m, c ) =
                        update x (Model model)
                in
                ( m
                , Cmd.batch [ c, sendMsg (Batch xs) ]
                )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions (Model model) =
    Sub.batch
        [ if model.started then
            onAnimationFrameDelta Tick

          else
            Sub.none
        , Browser.Events.onMouseDown (outsideTarget "foreground-color-picker" (ShowForegroundColorPicker False))
        ]



-- VIEW


constants : { width : Int, height : Int, period : Float, margin : Int }
constants =
    { -- width of the canvas
      width = 400

    -- height of the canvas
    , height = 400

    -- period
    , period = 2 * pi
    , margin = 50
    }


view : Model -> Html Msg
view (Model model) =
    section [ class "section pt-1 has-background-black-bis" ]
        [ div [ class "columns" ]
            [ div [ class "column is-8 is-offset-2" ]
                [ div [ class "content is-medium" ]
                    [ p []
                        [ text "You can "
                        , if not model.started then
                            a [ class "action", href "#lissajous", onClickPreventDefaultAndStopPropagation Start ] [ text "start" ]

                          else
                            a [ class "action", href "#lissajous", onClickPreventDefaultAndStopPropagation Stop ] [ text "stop" ]
                        , text " the animation. You can also "
                        , a [ class "action", href "#lissajous", onClickPreventDefaultAndStopPropagation Reset ] [ text "reset" ]
                        , text " the values to default."
                        ]
                    , p [] [ text "The equations are:" ]
                    , p []
                        [ text " •  x = "
                        , text (fromInt constants.width)
                        , text " sin("
                        , input
                            [ class "input input-number is-small is-inline"
                            , name "a-parameter"
                            , type_ "number"
                            , size 1
                            , value (fromInt model.a)
                            , onInput SetAParemeter
                            ]
                            []
                        , text "t + "
                        , input
                            [ class "input input-number is-small is-inline"
                            , name "phase"
                            , type_ "number"
                            , size 1
                            , value (Round.round 2 model.p)
                            , onInput SetPhase
                            ]
                            []
                        , text "°)"
                        ]
                    , p []
                        [ text " •  y = "
                        , text (fromInt constants.width)
                        , text " sin("
                        , input
                            [ class "input input-number is-small is-inline"
                            , name "b-parameter"
                            , type_ "number"
                            , size 1
                            , value (fromInt model.b)
                            , onInput SetBParameter
                            ]
                            []
                        , text "t)"
                        ]
                    , let
                        deltas =
                            [ ( 1, 2 ), ( 3, 2 ), ( 3, 4 ), ( 5, 4 ) ]

                        link ( pa, pb ) =
                            let
                                selected =
                                    if ( pa, pb ) == ( model.a, model.b ) then
                                        " selected"

                                    else
                                        ""

                                clazz =
                                    "action" ++ selected
                            in
                            [ a [ class clazz, href "#lissajous", onClickPreventDefaultAndStopPropagation (Batch [ SetAParemeter (fromInt pa), SetBParameter (fromInt pb) ]) ]
                                [ text (interpolate "({0},{1})" ([ pa, pb ] |> map fromInt))
                                ]
                            , text " "
                            ]
                      in
                      p [] <|
                        (text "You can also try some examples of Lissajouss figures with δ = π/2: "
                            :: concatMap link deltas
                        )
                    ]
                , div [ class "block" ]
                    [ lissajouComponent model
                    ]
                , div [ class "content is-medium" ]
                    [ p []
                        [ text "The color for the plot is "
                        , ColorSelector.view
                            { elementId = "foreground-color-picker"
                            , visible = model.foregroundColorPickerVisible
                            , color = model.curveStyle.color
                            , onVisibilityChange = ShowForegroundColorPicker
                            , state = model.foregroundColorPicker
                            , toMsg = ForegroundColorPickerMsg
                            }
                        , text " "
                        , text " (click to change)."
                        ]
                    , p []
                        [ text "The afterglow effect is "
                        , input
                            [ class "input input-number is-small is-inline"
                            , name "afterglow"
                            , type_ "number"
                            , size 3
                            , value (fromInt model.afterglow)
                            , onInput SetAfterglow
                            ]
                            []
                        , text " (0 means no after glow)."
                        ]
                    , p []
                        [ text "The animation consists in shifting the phase by "
                        , input
                            [ class "input input-number is-small is-inline"
                            , name "phase-velocity"
                            , type_ "number"
                            , size 3
                            , value (fromFloat model.vp)
                            , onInput SetPhaseVelocity
                            ]
                            []
                        , a [ href "https://en.wikipedia.org/wiki/Revolutions_per_minute" ] [ text "rev/min" ]
                        , text ". The resolution is "
                        , input
                            [ class "input input-number is-small is-normal is-inline"
                            , name "curve-resolution"
                            , type_ "number"
                            , size 4
                            , value (fromInt model.resolution)
                            , step "10"
                            , onInput SetResolution
                            ]
                            []
                        , text ", which represents the total number of points used to draw the curve (more is better)."
                        ]
                    ]
                ]
            ]
        ]


lissajouComponent : ModelRecord -> Html Msg
lissajouComponent model =
    div [ id "lissajous-scope", style "max-width" (fromInt constants.width ++ "px"), class "mx-auto" ]
        [ Widget.view model.widgetState
            (concat
                [ [ backgroundForm (rgb255 0 0 0)
                  , xAxisForm
                  , yAxisForm
                  ]
                , model.lissajousStencils.values
                    |> Array.toList
                    |> filterMap identity
                    |> indexedMap
                        (\i s ->
                            let
                                length =
                                    model.lissajousStencils.length

                                f =
                                    if length == 0 then
                                        0.0

                                    else if length == i + 1 then
                                        1.0

                                    else
                                        toFloat (i + 1) / toFloat length / 1.5

                                color =
                                    model.curveStyle.color |> fadeColor f |> toSvgColor

                                lineType =
                                    if length == i + 1 then
                                        model.curveStyle.lineType

                                    else
                                        solid 3
                            in
                            outlined lineType color s
                        )
                , [ fpsText model.ticks
                        |> GraphicSVG.text
                        |> fixedwidth
                        |> filled (Color.rgb255 217 217 217 |> toSvgColor)
                        |> move ( (constants.height // 2) - (constants.margin + 20) |> toFloat, (constants.width - 20) // 2 |> toFloat )
                  ]
                ]
            )
        ]


xAxisForm : Shape Msg
xAxisForm =
    let
        halfW =
            constants.width // 2

        halfH =
            constants.height // 2

        axis =
            line ( -halfW |> toFloat, 0 ) ( halfH |> toFloat, 0 )

        ticks =
            rangeStep -halfW halfW 10
                -- not sure it's optimal
                |> List.map toFloat
                |> List.map (\v -> line ( v, 0 ) ( v, 5 ))
    in
    axis
        :: ticks
        |> map (outlined (solid 1) (Color.rgb255 89 89 89 |> toSvgColor))
        |> group


yAxisForm : Shape Msg
yAxisForm =
    xAxisForm
        |> rotate (degrees 90)


backgroundForm : Color.Color -> Shape Msg
backgroundForm color =
    let
        halfW =
            constants.width // 2

        halfH =
            constants.height // 2

        circleAt ( x, y ) =
            circle 1.0
                |> filled (Color.rgb255 64 64 64 |> toSvgColor)
                |> move ( toFloat x, toFloat y )
    in
    group
        [ rect (constants.width |> toFloat) (constants.height |> toFloat)
            |> filled (toSvgColor color)
        , cartesian (rangeStep -halfW halfW 25) (rangeStep -halfH halfH 25)
            |> map circleAt
            |> group
        ]



-- Functions


{-| returns a function that compute the path for the lissajous given the desired resolution.
The curve is computed according to the given parameters a, b and phase
-}
lissajous : Int -> Int -> Float -> (Int -> Stencil)
lissajous a b phase =
    let
        half v =
            toFloat v / 2

        m =
            toFloat a

        n =
            toFloat b

        coord t =
            ( half (constants.width - constants.margin) * sin (m * t + phase)
            , half (constants.height - constants.margin) * sin (n * t)
            )
    in
    \res ->
        range 0 res
            |> map (\step -> toFloat step * constants.period / toFloat res)
            |> map coord
            |> openPolygon


modulo : Float -> Float -> Float
modulo range v =
    case ( v >= range, v < 0 ) of
        ( True, False ) ->
            modulo range (v - range)

        ( False, True ) ->
            modulo range (range + v)

        _ ->
            v


toRadian : Float -> Float
toRadian deg =
    deg * pi / 180.0


cartesian : List a -> List b -> List ( a, b )
cartesian xs ys =
    List.concatMap
        (\x -> List.map (\y -> ( x, y )) ys)
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
        { red, green, blue, alpha } =
            Color.toRgba c
    in
    GraphicSVG.rgba (255.0 * red) (255.0 * green) (255.0 * blue) alpha


fadeColor : Float -> Color.Color -> Color.Color
fadeColor f c =
    let
        hsla =
            Color.toHsla c
    in
    Color.fromHsla
        { hsla
            | lightness = hsla.lightness * f
        }


sendMsg : msg -> Cmd msg
sendMsg msg =
    Task.succeed msg |> Task.perform identity
