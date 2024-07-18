module Page.SoundWaveToggle exposing (Model, Msg, info, init, subscriptions, update, view)

import Array exposing (Array)
import Browser.Events exposing (onAnimationFrame)
import Css exposing (Style, num, opacity)
import Css.Global as Global exposing (global)
import Html
import Html.Attributes as HtmlAttr
import Html.Attributes.Aria as Aria
import Html.Styled exposing (Html, div, fromUnstyled, toUnstyled)
import Html.Styled.Attributes exposing (class, css)
import Html.Styled.Events exposing (onClick)
import Lib.Page
import List.Extra exposing (unfoldr)
import Markdown
import String exposing (fromFloat, join)
import String.Interpolate exposing (interpolate)
import Svg.Styled exposing (g, rect, svg)
import Svg.Styled.Attributes as SvgAttr
import Svg.Styled.Keyed as SvgStyledKeyed
import Time exposing (Posix)



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "sound-wave-toggle"
    , hash = "sound-wave-toggle"
    , date = "2024-07-14"
    , description = Markdown.toHtml [ HtmlAttr.class "info" ] """

An amazing Sound Wave Toggle in pure SVG (as it can be found in [SOTD](https://rogierdeboeve.com/) website).

       """
    , srcRel = "Page/SoundWaveToggle.elm"
    }



-- MODEL


constants : { width : Float, height : Float, rectCount : Int, rectWidth : Float, rectHeight : Float, rectRx : Float, initialX : Float, initialY : Float, horizontalShift : Float, minTranslationY : Float, maxTranslationY : Float, animationSpeed : Float, color : Css.Color }
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
    , color = Css.rgb 188 188 188
    }


type alias Rect =
    { x : Float
    , y : Float
    , w : Float
    , h : Float
    , rx : Float
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


linearWaveGenerator : Float -> Float -> Float -> Float -> Float -> Float -> Generator Rect
linearWaveGenerator x y w h rx hShift =
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


type PlayState
    = Playing
    | Paused


type alias ModelRecord =
    { wave : Array Rect
    , playState : PlayState
    }


type Model
    = Model ModelRecord


init : ( Model, Cmd Msg )
init =
    ( Model
        { wave = initWave
        , playState = Paused
        }
    , Cmd.none
    )


initWave : Array Rect
initWave =
    let
        { rectCount, initialX, initialY, rectWidth, rectHeight, rectRx, horizontalShift } =
            constants

        generator =
            linearWaveGenerator initialX initialY rectWidth rectHeight rectRx horizontalShift
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
                ( case model.playState of
                    Playing ->
                        { model | playState = Paused, wave = initWave }

                    Paused ->
                        { model | playState = Playing }
                , Cmd.none
                )

            Tick timestamp ->
                ( { model | wave = applyTransformer (sineWaveTransformer timestamp) model.wave }, Cmd.none )


{-| Type alias for a generic transformer function that modifies elements of a specific type based on their index.
-}
type alias Transformer a =
    Int -> a -> a


{-| Specialized transformer for Rect type.
-}
type alias RectTransformer =
    Transformer Rect


applyTransformer : Transformer a -> Array a -> Array a
applyTransformer transformer a =
    Array.indexedMap transformer a


{-| Transform the Rect elements based on a sine function.
-}
sineWaveTransformer : Time.Posix -> RectTransformer
sineWaveTransformer timestamp index point =
    let
        { animationSpeed, minTranslationY, maxTranslationY } =
            constants

        t =
            (toFloat (Time.posixToMillis timestamp) + toFloat index * 100) / animationSpeed

        newTranslationY =
            lerp minTranslationY maxTranslationY ((sin t + 1) / 2)
    in
    { point | translationY = newTranslationY }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions (Model { playState }) =
    case playState of
        Playing ->
            onAnimationFrame Tick

        _ ->
            Sub.none



-- VIEW


view : Model -> Html.Html Msg
view (Model model) =
    toUnstyled <|
        div [ class "columns" ]
            [ div [ class "column is-8 is-offset-2" ]
                [ div [ class "content is-medium" ]
                    [ fromUnstyled (Markdown.toHtml [ HtmlAttr.class "mt-4" ] """
The component is an SVG element featured on the [SOTD](https://rogierdeboeve.com/) website, translated
from a JavaScript implementation by [Lodz](https://codepen.io/loiclaudet/pen/RwzPajb) to Elm.
""")
                    ]
                , div [ class "section has-text-centered" ]
                    [ div [ class "has-text-centered" ]
                        [ viewSoundWaveToggle model
                        ]
                    ]
                ]
            ]


viewSoundWaveToggle : ModelRecord -> Html Msg
viewSoundWaveToggle { playState, wave } =
    svg
        [ SvgAttr.version "1.1"
        , SvgAttr.width <| fromFloat constants.width
        , SvgAttr.height <| fromFloat constants.height
        , SvgAttr.viewBox (join " " [ "0", "0", fromFloat constants.width, fromFloat constants.height ])
        , SvgAttr.class "sound-wave-toggle"
        , SvgAttr.fromUnstyled <| Aria.role "button"
        , SvgAttr.fromUnstyled <| Aria.ariaLabel "Toggle sound wave"
        , SvgAttr.fromUnstyled <| Aria.ariaPressed (playState == Playing)
        , css [ soundWaveToggleSvgStyle, soundWaveToggleStyle ]
        , onClick TogglePlay
        ]
        [ globalSvgStyle
        , rect
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
            , css
                [ soundWaveToggleCircleStyle ]
            ]
            []
        , g
            [ css
                (soundWaveToggleWaveStyle
                    :: (if playState == Paused then
                            [ soundWaveTogglePausedWaveStyle ]

                        else
                            []
                       )
                )
            ]
            (let
                rectView r =
                    SvgStyledKeyed.node "rect"
                        [ SvgAttr.x <| fromFloat r.x
                        , SvgAttr.y <| fromFloat r.y
                        , SvgAttr.width <| fromFloat r.w
                        , SvgAttr.height <| fromFloat r.h
                        , SvgAttr.rx <| fromFloat r.rx
                        , SvgAttr.fill "currentColor"
                        , SvgAttr.transform <| "translate(0 " ++ fromFloat r.translationY ++ ")"
                        , css [ soundWaveToggleRectStyle ]
                        ]
                        []
             in
             Array.map
                rectView
                wave
                |> Array.toList
            )
        ]



-- STYLES


globalSvgStyle : Html msg
globalSvgStyle =
    global
        [ Global.typeSelector "svg:hover"
            [ Global.descendants
                [ Global.class "sound-wave-toggle-dash"
                    [ Css.opacity (num 1)
                    , Css.property "stroke-dashoffset" "50"
                    , Css.property "stroke-dasharray" "10 0"
                    ]
                ]
            ]
        ]


soundWaveToggleStyle : Style
soundWaveToggleStyle =
    Css.property "cursor" "pointer"


soundWaveToggleSvgStyle : Style
soundWaveToggleSvgStyle =
    Css.batch
        [ Css.color constants.color
        , Css.transform <| Css.scale 5
        , Css.borderRadius (50 |> Css.pct)
        ]


soundWaveToggleCircleStyle : Style
soundWaveToggleCircleStyle =
    let
        circOut =
            "cubic-bezier(.075, .82, .165, 1)"
    in
    Css.batch
        [ opacity (num 0.6)
        , Css.property "transform-origin" "center center"
        , Css.transformBox Css.fillBox
        , Css.property "transition"
            (interpolate "transform {0} {1}, stroke-dashoffset {0} {1}, stroke-dasharray {0} {1}"
                [ ".8s"
                , circOut
                ]
            )
        ]


soundWaveToggleWaveStyle : Style
soundWaveToggleWaveStyle =
    Css.batch
        [ Css.property "transform-origin" "center"
        , Css.transformBox Css.fillBox
        , Css.transform <|
            Css.scaleX 0.7
        ]


soundWaveTogglePausedWaveStyle : Style
soundWaveTogglePausedWaveStyle =
    Css.batch
        [ Css.opacity (num 0.6)
        , Css.transform <|
            Css.scaleX 0.5
        ]


soundWaveToggleRectStyle : Style
soundWaveToggleRectStyle =
    let
        expoOut =
            "cubic-bezier(.19, 1, .22, 1)"
    in
    Css.batch
        [ Css.property "transform-origin" "center"
        , Css.property "transform" "translate(0 0)"
        , Css.property "transition"
            (interpolate "transform {0} {1}"
                [ "1.2s"
                , expoOut
                ]
            )
        ]



-- HELPER


{-| Linear interpolation between two values
-}
lerp : Float -> Float -> Float -> Float
lerp start end t =
    start + (end - start) * t
