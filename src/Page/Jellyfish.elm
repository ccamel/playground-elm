module Page.Jellyfish exposing (Model, Msg, info, init, subscriptions, update, view)

import Browser.Events exposing (onAnimationFrameDelta)
import Canvas exposing (Renderable, lineTo, path, rect, shapes)
import Canvas.Settings exposing (fill, stroke)
import Canvas.Settings.Line exposing (LineCap(..), lineCap, lineWidth)
import Color exposing (rgb255, rgba)
import Html exposing (Html, div, section)
import Html.Attributes exposing (class)
import Lib.Page
import Markdown


info : Lib.Page.PageInfo Msg
info =
    { name = "jellyfish"
    , hash = "jellyfish"
    , date = "2026-02-09"
    , description = Markdown.toHtml [ class "content" ] """
A compact [p5.js](https://p5js.org/) one-liner translated into Elm and rendered with [joakin/elm-canvas](https://package.elm-lang.org/packages/joakin/elm-canvas/latest/).

It draws ethereal, jellyfish-like white lineforms on a near-black canvas using trigonometric oscillations and magnitude-based deformation.
       """
    , srcRel = "Page/Jellyfish.elm"
    }


type alias Model =
    { t : Float
    , frame : Int
    }


type Msg
    = Tick


canvasSize : Int
canvasSize =
    400


pointCount : Int
pointCount =
    16000


pointIndices : List Int
pointIndices =
    List.range 0 (pointCount - 1) |> List.reverse


cycleAngle : Float
cycleAngle =
    32 * pi


backgroundColorInitial : Color.Color
backgroundColorInitial =
    rgb255 9 9 9


backgroundColorFade : Color.Color
backgroundColorFade =
    rgba (9 / 255) (9 / 255) (9 / 255) 0.08


strokeAlpha : Float
strokeAlpha =
    96 / 255


strokeColor : Color.Color
strokeColor =
    rgba 1 1 1 strokeAlpha


timeStepPerFrame : Float
timeStepPerFrame =
    pi / 45


pointSize : Float
pointSize =
    1.0


init : ( Model, Cmd Msg )
init =
    ( { t = 0
      , frame = 0
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick ->
            ( { model
                | t = wrapTime (model.t + timeStepPerFrame)
                , frame = model.frame + 1
              }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    onAnimationFrameDelta (\_ -> Tick)


view : Model -> Html Msg
view model =
    section [ class "section pt-1 has-background-black-bis" ]
        [ div [ class "container is-max-tablet" ]
            [ div [ class "columns is-centered" ]
                [ div [ class "column is-four-fifths has-text-centered" ]
                    [ Canvas.toHtml
                        ( canvasSize, canvasSize )
                        [ class "jellyfish" ]
                        [ backgroundShape model.frame
                        , jellyfishShape model.t
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


jellyfishShape : Float -> Renderable
jellyfishShape t =
    shapes
        [ stroke strokeColor
        , lineWidth pointSize
        , lineCap RoundCap
        ]
        (List.map (\i -> dotAt (pointForIndex t i)) pointIndices)


dotAt : Canvas.Point -> Canvas.Shape
dotAt ( x, y ) =
    path ( x - 0.01, y ) [ lineTo ( x + 0.01, y ) ]


pointForIndex : Float -> Int -> Canvas.Point
pointForIndex t i =
    let
        y =
            toFloat i / 99

        ( k, e ) =
            computeKE y

        d =
            computeD k e

        q =
            computeQ t d k e

        c =
            computeC t d e i
    in
    ( q * sin c + 200
    , (q + 40) * cos c + 190
    )


computeKE : Float -> ( Float, Float )
computeKE y =
    ( 8 * cos y
    , y / 8 - 12
    )


computeMagnitude : Float -> Float -> Float
computeMagnitude x y =
    sqrt (x * x + y * y)


computeD : Float -> Float -> Float
computeD k e =
    let
        magnitude =
            computeMagnitude k e
    in
    (magnitude * magnitude * magnitude) / 999 + 1


computeQ : Float -> Float -> Float -> Float -> Float
computeQ t d k e =
    79
        - e
        * sin k
        + (k / d)
        * (8 + 4 * sin (d * d - t + cos (e + t / 2)))


computeC : Float -> Float -> Float -> Int -> Float
computeC t d e i =
    d
        / 2
        + (e / 99)
        * sin (t + d)
        - t
        / 8
        + toFloat (modBy 2 i)
        * 3


wrapTime : Float -> Float
wrapTime t =
    if t < cycleAngle then
        t

    else
        t - cycleAngle * toFloat (floor (t / cycleAngle))
