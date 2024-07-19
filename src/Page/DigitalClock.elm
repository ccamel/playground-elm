module Page.DigitalClock exposing (Model, Msg, info, init, subscriptions, update, view)

import Browser.Events
import Color exposing (Color, rgb255, toCssString)
import ColorPicker
import Html exposing (Html, div, input, p, section, text)
import Html.Attributes exposing (class, name, size, style, type_, value)
import Html.Events exposing (onInput)
import Lib.ColorSelector as ColorSelector
import Lib.Decoder exposing (outsideTarget)
import Lib.Page
import Lib.String exposing (strToIntWithMinMax)
import Lib.Svg exposing (classList)
import List exposing (map, member)
import Markdown
import Maybe exposing (withDefault)
import String exposing (fromInt, padLeft)
import String.Interpolate exposing (interpolate)
import Svg exposing (Svg, circle, g, path, svg)
import Svg.Attributes as SvgAtt exposing (cx, cy, d, height, r, transform, version, viewBox, width)
import Time exposing (Posix, Zone, every, toHour, toMinute, toSecond, utc)



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "digital-clock"
    , hash = "digital-clock"
    , date = "2020-12-19"
    , description = Markdown.toHtml [ class "content" ] """

A demo rendering a digital clock in [SVG](https://fr.wikipedia.org/wiki/Scalable_Vector_Graphics).
       """
    , srcRel = "Page/DigitalClock.elm"
    }



-- MODEL


type alias ModelRecord =
    { time : Maybe Posix
    , timeZone : Zone
    , spaceX : Int
    , tilt : Int
    , refreshInterval : Int -- in ms
    , colorPicker : ColorPicker.State
    , colorPickerVisible : Bool
    , color : Color
    }


type Model
    = Model ModelRecord


init : ( Model, Cmd Msg )
init =
    ( Model initialModel, initialCmd )


initialModel : ModelRecord
initialModel =
    { time = Nothing
    , timeZone = utc
    , spaceX = 5
    , tilt = -12
    , refreshInterval = 500
    , colorPicker = ColorPicker.empty
    , colorPickerVisible = False
    , color = rgb255 0 200 0
    }


initialCmd : Cmd Msg
initialCmd =
    Cmd.none



-- UPDATE


type Msg
    = Tick Posix
    | SetSpaceX String
    | SetTilt String
    | SetRefreshInterval String
    | ColorPickerMsg ColorPicker.Msg
    | ShowColorPicker Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    Tuple.mapFirst Model <|
        case msg of
            Tick t ->
                ( { model | time = Just t }, Cmd.none )

            SetSpaceX s ->
                ( case strToIntWithMinMax s 0 25 of
                    Just v ->
                        { model | spaceX = v }

                    Nothing ->
                        model
                , Cmd.none
                )

            SetTilt s ->
                ( case strToIntWithMinMax s -45 45 of
                    Just v ->
                        { model | tilt = v }

                    Nothing ->
                        model
                , Cmd.none
                )

            SetRefreshInterval s ->
                ( case strToIntWithMinMax s 25 2000 of
                    Just v ->
                        { model | refreshInterval = v }

                    Nothing ->
                        model
                , Cmd.none
                )

            ShowColorPicker b ->
                ( { model | colorPickerVisible = b }, Cmd.none )

            ColorPickerMsg msgPicker ->
                let
                    ( state, color ) =
                        ColorPicker.update msgPicker model.color model.colorPicker
                in
                ( { model
                    | colorPicker = state
                    , color = color |> Maybe.withDefault model.color
                  }
                , Cmd.none
                )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions (Model model) =
    Sub.batch
        [ every (toFloat model.refreshInterval) Tick
        , Browser.Events.onMouseDown (outsideTarget "color-picker" (ShowColorPicker False))
        ]



-- VIEW


view : Model -> Html Msg
view (Model model) =
    section [ class "section pt-1 has-background-black-bis" ]
        [ div [ class "columns" ]
            [ div [ class "column is-8 is-offset-2" ]
                [ div [ class "content is-medium" ]
                    [ p []
                        [ text "Here is the current time." ]
                    ]
                , div [ class "block" ]
                    [ digitalClock model ]
                , div [ class "content is-medium" ]
                    [ p []
                        [ text "You can adjust some display settings if you wish. The space between digit is "
                        , input
                            [ class "input input-number is-small is-inline"
                            , name "space-x"
                            , type_ "number"
                            , size 1
                            , value (fromInt model.spaceX)
                            , onInput SetSpaceX
                            ]
                            []
                        , text ", the tilt is "
                        , input
                            [ class "input input-number is-small is-inline"
                            , name "tilt"
                            , type_ "number"
                            , size 1
                            , value (fromInt model.tilt)
                            , onInput SetTilt
                            ]
                            []
                        , text ", the color used for the lcd is "
                        , ColorSelector.view
                            { elementId = "color-picker"
                            , visible = model.colorPickerVisible
                            , color = model.color
                            , onVisibilityChange = ShowColorPicker
                            , state = model.colorPicker
                            , toMsg = ColorPickerMsg
                            }
                        , text " (click to change)"
                        , text ", and the refresh interval is "
                        , input
                            [ class "input input-number is-small is-inline"
                            , name "refresh-interval"
                            , type_ "number"
                            , size 1
                            , value (fromInt model.refreshInterval)
                            , onInput SetRefreshInterval
                            ]
                            []
                        , text "."
                        ]
                    ]
                ]
            ]
        ]


{-| segments code (7 segments display)
A

F |.| B . H
G -
E |.| C . I

D

-}
type Segment
    = A
    | B
    | C
    | D
    | E
    | F
    | G
    | H
    | I


type Figure
    = D0
    | D1
    | D2
    | D3
    | D4
    | D5
    | D6
    | D7
    | D8
    | D9
    | Coma
    | Dash
    | None
    | All


{-| returns the segments that compose a given figure
-}
figureToSegments : Figure -> List Segment
figureToSegments fig =
    case fig of
        D0 ->
            [ A, B, C, D, E, F ]

        D1 ->
            [ B, C ]

        D2 ->
            [ A, B, D, E, G ]

        D3 ->
            [ A, B, C, D, G ]

        D4 ->
            [ F, B, G, C ]

        D5 ->
            [ A, F, G, C, D ]

        D6 ->
            [ A, F, G, E, C, D ]

        D7 ->
            [ A, B, C ]

        D8 ->
            [ A, B, C, D, E, F, G ]

        D9 ->
            [ A, B, C, D, F, G ]

        Coma ->
            [ H, I ]

        Dash ->
            [ G ]

        None ->
            []

        All ->
            [ A, B, C, D, E, F, G, H, I ]


figureToName : Figure -> String
figureToName fig =
    case fig of
        D0 ->
            "0"

        D1 ->
            "1"

        D2 ->
            "2"

        D3 ->
            "3"

        D4 ->
            "4"

        D5 ->
            "5"

        D6 ->
            "6"

        D7 ->
            "7"

        D8 ->
            "8"

        D9 ->
            "9"

        Coma ->
            "coma"

        Dash ->
            "dash"

        All ->
            "all"

        None ->
            "none"


charToFigure : Char -> Figure
charToFigure c =
    case c of
        '0' ->
            D0

        '1' ->
            D1

        '2' ->
            D2

        '3' ->
            D3

        '4' ->
            D4

        '5' ->
            D5

        '6' ->
            D6

        '7' ->
            D7

        '8' ->
            D8

        '9' ->
            D9

        ':' ->
            Coma

        '-' ->
            Dash

        _ ->
            None


stringToFigures : String -> List Figure
stringToFigures s =
    s
        |> String.toList
        |> List.map charToFigure


timeToString : Zone -> Posix -> String
timeToString zone date =
    let
        isEven x =
            modBy 2 x == 0

        params =
            [ toHour zone date, toMinute zone date, toSecond zone date ]
                |> map fromInt
                |> map (padLeft 2 '0')

        pattern =
            if toSecond zone date |> isEven then
                "{0}:{1}:{2}"

            else
                "{0} {1} {2}"
    in
    interpolate pattern params


{-| returns an SVG representation for the given segment decorated with the given svg attributes.
-}
segmentSvgView : List (Svg.Attribute msg) -> Segment -> Svg msg
segmentSvgView attr segment =
    case segment of
        A ->
            path (attr ++ [ d "M10,8L14,4L42,4L46,8L42,12L14,12L10,8z" ]) []

        B ->
            path (attr ++ [ d "M48,10L52,14L52,42L48,46L44,42L44,14L48,10z" ]) []

        C ->
            path (attr ++ [ d "M48,50L52,54L52,82L48,86L44,82L44,54L48,50z" ]) []

        D ->
            path (attr ++ [ d "M10,88L14,84L42,84L46,88L42,92L14,92L10,88z" ]) []

        E ->
            path (attr ++ [ d "M8,50L12,54L12,82L8,86L4,82L4,54L8,50z" ]) []

        F ->
            path (attr ++ [ d "M8,10L12,14L12,42L8,46L4,42L4,14L8,10z" ]) []

        G ->
            path (attr ++ [ d "M10,48L14,44L42,44L46,48L42,52L14,52L10,48z" ]) []

        H ->
            circle (attr ++ [ r "4", cx "28", cy "28" ]) []

        I ->
            circle (attr ++ [ r "4", cx "28", cy "68" ]) []


figureSvgView : Figure -> Svg msg
figureSvgView fig =
    let
        segments =
            figureToSegments fig

        asView seg =
            let
                lit =
                    member seg segments
            in
            segmentSvgView
                [ classList
                    [ ( "lit", lit )
                    , ( "unlit", not lit )
                    ]
                ]
                seg
    in
    g [ SvgAtt.class <| "figure figure-" ++ figureToName fig ]
        (All
            |> figureToSegments
            |> List.map asView
        )


stringToSvgView : ModelRecord -> String -> List (Svg msg)
stringToSvgView model s =
    stringToFigures s
        |> List.map figureSvgView
        |> List.indexedMap
            (\index svg ->
                g
                    [ [ model.tilt, (48 + model.spaceX) * index, 0 ]
                        |> map fromInt
                        |> interpolate "skewX({0}) translate({1},{2})"
                        |> transform
                    ]
                    [ svg
                    ]
            )


digitalClock : ModelRecord -> Html msg
digitalClock model =
    let
        styles =
            Svg.style []
                [ text <| interpolate """
                    .digital-clock .lit {
                      fill: {0};
                    }

                    .digital-clock .unlit {
                      fill: #1e1f1d;
                    }
                 """ [ toCssString model.color ]
                ]
    in
    div [ class "digital-clock br-15 mb-4 px-3 py-1 has-background-black", style "max-width" "450px" ]
        [ svg
            [ version "1.1"
            , width "100%"
            , height "100%"
            , SvgAtt.style "max-width: 450px"
            , viewBox "0 0 450 96"
            ]
            (styles
                :: (model.time
                        |> Maybe.map (timeToString model.timeZone)
                        |> withDefault "--:--:--"
                        |> stringToSvgView model
                   )
            )
        ]
