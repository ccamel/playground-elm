module Page.Organic exposing (Demo, Model, Msg, info, init, subscriptions, update, view)

import Browser.Events exposing (onAnimationFrameDelta)
import Canvas exposing (Renderable, lineTo, path, rect, shapes)
import Canvas.Settings exposing (fill, stroke)
import Canvas.Settings.Line exposing (LineCap(..), lineCap, lineWidth)
import Color exposing (rgb255, rgba)
import Html exposing (Html, button, div, p, section, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Lib.Page
import Markdown


info : Lib.Page.PageInfo Msg
info =
    { name = "organic"
    , hash = "organic"
    , date = "2026-04-01"
    , description = Markdown.toHtml [ class "content" ] """
A compact organic showcase translated into Elm and rendered with [joakin/elm-canvas](https://package.elm-lang.org/packages/joakin/elm-canvas/latest/).
Switch between animated organism-inspired mini demos.
       """
    , srcRel = "Page/Organic.elm"
    }


type alias Model =
    { t : Float
    , frame : Int
    , selectedDemo : Demo
    }


type Demo
    = Jellyfish
    | Anemone


type alias DemoConfig =
    { label : String
    , description : String
    , animation : AnimationConfig
    , pointForIndex : Float -> Int -> Canvas.Point
    }


type alias AnimationConfig =
    { pointIndices : List Int
    , timeStep : Float
    , cycleAngle : Float
    , pointSize : Float
    }


type Msg
    = Tick Float
    | SelectDemo Demo


canvasSize : Int
canvasSize =
    400


backgroundColorInitial : Color.Color
backgroundColorInitial =
    rgb255 0 0 0


backgroundColorFade : Color.Color
backgroundColorFade =
    rgb255 0 0 0


strokeAlpha : Float
strokeAlpha =
    110 / 255


strokeColor : Color.Color
strokeColor =
    rgba 1 1 1 strokeAlpha


init : ( Model, Cmd Msg )
init =
    ( { t = 0
      , frame = 0
      , selectedDemo = Jellyfish
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick deltaMs ->
            let
                config =
                    demoConfig model.selectedDemo

                animation =
                    config.animation

                deltaFactor =
                    deltaMs / baseFrameMs
            in
            ( { model
                | t = wrapTime animation.cycleAngle (model.t + animation.timeStep * deltaFactor)
                , frame = model.frame + 1
              }
            , Cmd.none
            )

        SelectDemo demo ->
            if demo == model.selectedDemo then
                ( model, Cmd.none )

            else
                ( { model
                    | selectedDemo = demo
                    , t = 0
                    , frame = 0
                  }
                , Cmd.none
                )


subscriptions : Model -> Sub Msg
subscriptions _ =
    onAnimationFrameDelta Tick


view : Model -> Html Msg
view model =
    let
        config =
            demoConfig model.selectedDemo
    in
    section [ class "section pt-1 has-background-black" ]
        [ div [ class "container is-max-tablet" ]
            [ div [ class "columns is-centered" ]
                [ div [ class "column is-four-fifths has-text-centered" ]
                    [ demoPicker model.selectedDemo
                    , p [ class "is-size-7 has-text-grey-light mb-3" ] [ text config.description ]
                    , Canvas.toHtml
                        ( canvasSize, canvasSize )
                        [ class "organic" ]
                        [ backgroundShape model.frame
                        , organicShape config model.t
                        ]
                    ]
                ]
            ]
        ]


backgroundShape : Int -> Renderable
backgroundShape frame =
    let
        bgColor =
            if frame == 0 then
                backgroundColorInitial

            else
                backgroundColorFade
    in
    shapes [ fill bgColor ]
        [ rect ( 0, 0 ) (toFloat canvasSize) (toFloat canvasSize) ]


demoPicker : Demo -> Html Msg
demoPicker selectedDemo =
    div [ class "buttons is-centered are-small mb-2" ]
        (List.map (demoButton selectedDemo) demos)


demoButton : Demo -> Demo -> Html Msg
demoButton selectedDemo demo =
    let
        btnClass =
            if demo == selectedDemo then
                "button is-link"

            else
                "button is-dark is-outlined"
    in
    button
        [ class btnClass
        , onClick (SelectDemo demo)
        ]
        [ text (demoLabel demo) ]


demos : List Demo
demos =
    [ Jellyfish, Anemone ]


demoLabel : Demo -> String
demoLabel demo =
    (demoConfig demo).label


jellyfishPointIndices : List Int
jellyfishPointIndices =
    pointIndicesFor 16000


anemonePointIndices : List Int
anemonePointIndices =
    pointIndicesFor 14000


demoConfig : Demo -> DemoConfig
demoConfig demo =
    case demo of
        Jellyfish ->
            { label = "Jellyfish"
            , description = "A translucent jellyfish with soft marine-like motion and trailing filaments."
            , animation =
                { pointIndices = jellyfishPointIndices
                , timeStep = pi / 72
                , cycleAngle = 32 * pi
                , pointSize = 1.0
                }
            , pointForIndex = jellyfishPointForIndex
            }

        Anemone ->
            { label = "Anemone"
            , description = "An organic bell with hanging tendrils and soft, independent sway."
            , animation =
                { pointIndices = anemonePointIndices
                , timeStep = pi / 230
                , cycleAngle = 84 * pi
                , pointSize = 1.0
                }
            , pointForIndex = anemonePointForIndex
            }


pointIndicesFor : Int -> List Int
pointIndicesFor count =
    List.range 0 (count - 1) |> List.reverse


organicShape : DemoConfig -> Float -> Renderable
organicShape config t =
    let
        animation =
            config.animation
    in
    shapes
        [ stroke strokeColor
        , lineWidth animation.pointSize
        , lineCap RoundCap
        ]
        (List.map (\i -> dotAt (config.pointForIndex t i)) animation.pointIndices)


dotAt : Canvas.Point -> Canvas.Shape
dotAt ( x, y ) =
    path ( x - 0.01, y ) [ lineTo ( x + 0.01, y ) ]


jellyfishPointForIndex : Float -> Int -> Canvas.Point
jellyfishPointForIndex t i =
    let
        y =
            toFloat i / 99

        k =
            8 * cos y

        e =
            y / 8 - 12

        magnitude =
            computeMagnitude k e

        d =
            (magnitude * magnitude * magnitude) / 999 + 1

        q =
            79
                - e
                * sin k
                + (k / d)
                * (8 + 4 * sin (d * d - t + cos (e + t / 2)))

        c =
            d
                / 2
                + (e / 99)
                * sin (t + d)
                - t
                / 8
    in
    ( q * sin c + 200
    , (q + 40) * cos c + 190
    )


computeMagnitude : Float -> Float -> Float
computeMagnitude x y =
    sqrt (x * x + y * y)


anemonePointForIndex : Float -> Int -> Canvas.Point
anemonePointForIndex t i =
    let
        strandCount =
            64

        maxDepth =
            230

        bellCut =
            0.34

        strand =
            modBy strandCount i

        depth =
            i // strandCount

        s =
            toFloat strand

        d =
            toFloat depth

        u =
            clamp01 (d / maxDepth)

        theta0 =
            (s / toFloat strandCount) * (2 * pi)

        phase =
            2 * pi * hash01 (s * 53.71 + 7.3)

        theta =
            theta0
                + 0.14
                * sin (t / 2.8 + phase)
                + 0.06
                * u
                * sin (d / 15 - t / 1.9 + phase)

        centerX =
            200 + 5 * sin (t / 3.2)

        centerY =
            165 + 4 * cos (t / 3.8)
    in
    if u < bellCut then
        let
            v =
                u / bellCut

            bellRadius =
                88
                    * sin (v * pi / 2)
                    + 6
                    * sin (4 * theta0 + t / 2 + 3 * v)

            domeY =
                -74 + 56 * v + 4 * sin (3 * theta0 - t / 3)
        in
        ( centerX + bellRadius * cos theta
        , centerY + domeY + 0.32 * bellRadius * sin theta
        )

    else
        let
            w =
                (u - bellCut) / (1 - bellCut)

            seed =
                hash01 (s * 19.17 + 31.8)

            tendrilStrength =
                if modBy 14 strand == 0 then
                    1

                else if modBy 14 strand == 7 then
                    0.8

                else
                    0
        in
        if tendrilStrength > 0 then
            let
                lengthFactor =
                    0.55 + 0.9 * seed

                widthFactor =
                    0.75 + 0.5 * (1 - seed)

                stemRadius =
                    (14 + 10 * widthFactor) * (1 - 0.72 * w)

                sway =
                    tendrilStrength
                        * (3 + 18 * lengthFactor * w)
                        * sin (0.2 * d - t * (0.42 + 0.22 * seed) + phase)

                curl =
                    tendrilStrength
                        * (1 + 7 * w * w)
                        * sin (0.13 * d + t * (0.33 + 0.2 * seed) + phase / 2)

                x =
                    centerX
                        + (stemRadius + sway + curl)
                        * cos (theta + 0.09 * w * sin (t + phase))

                y =
                    centerY
                        - 18
                        + 210
                        * w
                        * (0.72 + 0.58 * lengthFactor)
                        + 6
                        * sin (0.15 * d - t / 2.8 + phase)
            in
            ( x, y )

        else
            let
                lobeWeight =
                    if w < 0.45 then
                        1 - w / 0.45

                    else
                        0

                randomX =
                    2 * hash01 (toFloat i * 0.173 + 13.1) - 1

                randomY =
                    2 * hash01 (toFloat i * 0.137 + 71.7) - 1

                mistRadius =
                    (8 + 22 * sin (w * pi)) * (0.6 + 0.8 * seed)

                x =
                    centerX
                        + lobeWeight
                        * 24
                        * sin (2 * theta0 + phase)
                        + mistRadius
                        * randomX
                        + 3
                        * sin (t / (2.7 + seed) + phase + 6 * w)

                y =
                    centerY
                        - 12
                        + 190
                        * w
                        * (0.88 + 0.3 * seed)
                        + 18
                        * randomY
                        * (1 - 0.3 * w)
                        + 2
                        * cos (t / (3.1 + seed) + phase + 4 * w)
            in
            ( x, y )


wrapTime : Float -> Float -> Float
wrapTime cycleAngle t =
    if cycleAngle <= 0 then
        t

    else if t < cycleAngle then
        t

    else
        t - cycleAngle * toFloat (floor (t / cycleAngle))


baseFrameMs : Float
baseFrameMs =
    1000 / 60


clamp01 : Float -> Float
clamp01 value =
    max 0 (min 1 value)


hash01 : Float -> Float
hash01 value =
    let
        x =
            sin value * 43758.5453123
    in
    x - toFloat (floor x)
