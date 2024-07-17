module Page.SoundWaveToggle exposing (Model, Msg, info, init, subscriptions, update, view)

import Array exposing (Array)
import Browser.Events exposing (onAnimationFrame)
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Html.Attributes.Aria as Aria
import Html.Events exposing (onClick)
import Lib.Page
import Lib.Svg as Svg
import List.Extra exposing (unfoldr)
import Markdown
import String exposing (fromFloat, join)
import Svg exposing (svg)
import Svg.Attributes as SvgAttr
import Time exposing (Posix)



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "sound-wave-toggle"
    , hash = "sound-wave-toggle"
    , date = "2024-07-14"
    , description = Markdown.toHtml [ class "info" ] """

An amazing Sound Wave Toggle in pure SVG (as it can be found in [SOTD](https://rogierdeboeve.com/) website).

       """
    , srcRel = "Page/SoundWaveToggle.elm"
    }



-- MODEL


constants : { width : Float, height : Float, rectCount : Int, rectWidth : Float, rectHeight : Float, rectRx : Float, initialX : Float, initialY : Float, horizontalShift : Float, minTranslationY : Float, maxTranslationY : Float, animationSpeed : Float }
constants =
    { width = 28
    , height = 28
    , rectCount = 16
    , rectWidth = 1.75
    , rectHeight = 1.75
    , rectRx = 0.875
    , initialX = 6.125
    , initialY = 14
    , horizontalShift = 1.75 / 2
    , minTranslationY = -3
    , maxTranslationY = 3
    , animationSpeed = 200
    }


type alias Rect =
    { x : Float
    , y : Float
    , w : Float
    , h : Float
    , rx: Float
    , translationY : Float
    }


type Generator a
    = Generator (() -> ( a, Generator a ))


step : Generator a -> ( a, Generator a )
step (Generator f) =
    f ()


{-| Generate a list of values by applying a generator function `n` times.
-}
stepN : Int -> Generator a -> List a
stepN n generator =
    unfoldr
        (\( remainingCount, gen ) ->
            if remainingCount <= 0 then
                Nothing

            else
                let
                    ( value, nextGen ) =
                        step gen
                in
                Just ( value, ( remainingCount - 1, nextGen ) )
        )
        ( n, generator )


linearRectGenerator : Float -> Float -> Float -> Float -> Float -> Float -> Generator Rect
linearRectGenerator x y w h rx hShift =
    let
        generateRect state =
            let
                rect =
                    { x = state.x, y = y, w = w, h = h, rx = rx, translationY = 0 }

                nextState =
                    { x = state.x + hShift }
            in
            ( rect, Generator <| \() -> generateRect nextState )
    in
    Generator <| \() -> generateRect { x = x }

type PlayState =
    Playing
    | Paused

type alias ModelRecord =
    { rects : Array Rect
    , playState : PlayState
    }


type Model
    = Model ModelRecord


init : ( Model, Cmd Msg )
init =
    ( Model
        { rects = initRects
        , playState = Paused
        }
    , Cmd.none
    )


initRects : Array Rect
initRects =
    let
        { rectCount, initialX, initialY, rectWidth, rectHeight, rectRx, horizontalShift } =
            constants

        generator =
            linearRectGenerator initialX initialY rectWidth rectHeight rectRx horizontalShift
    in
    stepN rectCount generator |> Array.fromList



-- MESSAGES


type Msg
    = TogglePlay
    | Tick Posix



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    Tuple.mapFirst Model <|
        case msg of
            TogglePlay ->
                ( case  model.playState of
                    Playing ->
                        { model | playState = Paused, rects = initRects }

                    Paused ->
                        { model | playState = Playing }
                , Cmd.none
                )

            Tick timestamp ->
                ( { model | rects = updateRects timestamp model.rects }, Cmd.none )


updateRects : Time.Posix -> Array Rect -> Array Rect
updateRects timestamp rects =
    Array.indexedMap (updateRect timestamp) rects


updateRect : Time.Posix -> Int -> Rect -> Rect
updateRect timestamp index rect =
    let
        { animationSpeed, minTranslationY, maxTranslationY } =
            constants

        t =
            (toFloat (Time.posixToMillis timestamp) + toFloat index * 100) / animationSpeed

        newTranslationY =
            lerp minTranslationY maxTranslationY ((sin t + 1) / 2)
    in
    { rect | translationY = newTranslationY }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions (Model { playState }) =
    case playState of
    Playing ->
        onAnimationFrame Tick

    _ ->
        Sub.none



-- VIEW


view : Model -> Html Msg
view (Model model) =
    div [ class "columns" ]
        [ div [ class "column is-8 is-offset-2" ]
            [ div [ class "content is-medium" ]
                [ Markdown.toHtml [ class "mt-4" ] """
The component is an SVG element featured on the [SOTD](https://rogierdeboeve.com/) website, translated
from a JavaScript implementation by [Lodz](https://codepen.io/loiclaudet/pen/RwzPajb) to Elm.
"""
                ]
            , div [ class "section has-text-centered" ]
                [ div [ class "has-text-centered" ]
                    [ viewSoundWaveToggle model
                    ]
                ]
            ]
        ]


viewSoundWaveToggle : ModelRecord -> Html Msg
viewSoundWaveToggle { playState, rects } =
    svg
        [ SvgAttr.version "1.1"
        , SvgAttr.width  <| fromFloat constants.width
        , SvgAttr.height <| fromFloat constants.height
        , SvgAttr.viewBox (join " " [ "0", "0", fromFloat constants.width, fromFloat constants.height ])
        , SvgAttr.class "sound-wave-toggle"
        , Aria.role "button"
        , Aria.ariaLabel "Toggle sound wave"
        , Aria.ariaPressed (playState == Playing)
        , onClick TogglePlay
        ]
        [ Svg.rect
            [ SvgAttr.class "sound-wave-toggle-dash"
            , SvgAttr.x "0.5"
            , SvgAttr.y "0.5"
            , SvgAttr.width "27"
            , SvgAttr.height "27"
            , SvgAttr.rx "13.5"
            , SvgAttr.stroke "currentColor"
            , SvgAttr.strokeOpacity "0.5"
            , SvgAttr.strokeDasharray "2 2"
            , SvgAttr.fill "none"
            ]
            []
        , Svg.g
            [ Svg.classList [ ( "sound-wave-toggle-rects", playState == Paused ) ]
            ]
            (let
                rectView rect =
                    Svg.rect
                        [ SvgAttr.x <| fromFloat rect.x
                        , SvgAttr.y <| fromFloat rect.y
                        , SvgAttr.width <| fromFloat rect.w
                        , SvgAttr.height <| fromFloat rect.h
                        , SvgAttr.rx <| fromFloat rect.rx
                        , SvgAttr.fill "currentColor"
                        , SvgAttr.transform <| "translate(0 " ++ fromFloat rect.translationY ++ ")"
                        ]
                        []
             in
             Array.map
                rectView
                rects
                |> Array.toList
            )
        ]



-- HELPER


{-| Linear interpolation between two values
-}
lerp : Float -> Float -> Float -> Float
lerp start end t =
    start + (end - start) * t
