module Page.DigitalClock exposing (..)

import Date exposing (fromTime, hour, minute, second)
import Html exposing (Html, a, div, h2, h3, hr, i, img, input, li, p, text, ul)
import Html.Attributes exposing (alt, attribute, class, href, name, size, src, style, type_, value)
import Html.Events exposing (onInput)
import Maybe exposing (withDefault)
import String exposing (padLeft)
import String.Interpolate exposing (interpolate)
import Svg.Attributes as SvgAtt exposing (style, transform)
import List exposing (append, map, member)
import Markdown
import Page.Common exposing (classList, strToIntWithMinMax)
import Svg exposing (Svg, circle, g, path, rect, svg)
import Svg.Attributes exposing (cx, cy, d, fill, height, id, r, stroke, strokeWidth, viewBox, width, x, y)
import Time exposing (Time, every, millisecond, now)





-- PAGE INFO

info : Page.Common.PageInfo Msg
info = {
     name = "digital-clock"
     , hash = "digital-clock"
     , description = Markdown.toHtml [class "info"] """

A demo rendering a digital clock in [SVG](https://fr.wikipedia.org/wiki/Scalable_Vector_Graphics)
       """
     , srcRel = "Page/DigitalClock.elm"
 }

-- MODEL


type alias Model = {
        time : Maybe Time
       ,spaceX : Int
       ,tilt: Int
       ,refreshInterval: Int -- in ms
 }

initialModel : Model
initialModel = {
        time = Nothing
       ,spaceX = 0
       ,tilt = -12
       ,refreshInterval = 500
    }

-- UPDATE

type Msg =
      Reset
    | Tick Time
    | SetSpaceX String
    | SetTilt String
    | SetRefreshInterval String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Reset -> initialModel
    Tick t -> { model | time = Just t }
    SetSpaceX s ->
        case (strToIntWithMinMax s 0 20) of
            Just v -> { model | spaceX = v }
            Nothing -> model
    SetTilt s ->
        case (strToIntWithMinMax s -45 45) of
            Just v -> { model | tilt = v }
            Nothing -> model
    SetRefreshInterval s ->
        case (strToIntWithMinMax s 25 2000) of
            Just v -> { model | refreshInterval = v }
            Nothing -> model

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =  every (toFloat (model.refreshInterval) * millisecond) Tick

-- VIEW

view : Model -> Html Msg
view model =
  div [ class "container" ]
      [  hr [] []
        ,div [class "description"]
        [
             p []
               [ text "Here is the current time." ]
            ,p []
               [ text "You can adjust some display settings if you wish. The space between digit is "
                ,input [ class "input-number"
                     ,name "space-x"
                     ,type_ "number"
                     ,size 3
                     ,value (toString model.spaceX)
                     ,onInput SetSpaceX] []
                 ,text ", the tilt is "
                 ,input [ class "input-number"
                      ,name "tilt"
                      ,type_ "number"
                      ,size 3
                      ,value (toString model.tilt)
                      ,onInput SetTilt] []
                 ,text ", and the refresh interval is "
                 ,input [ class "input-number"
                      ,name "refresh-interval"
                      ,type_ "number"
                      ,size 3
                      ,value (toString model.refreshInterval)
                      ,onInput SetRefreshInterval] []
               ]
         ]
        ,svgView model
      ]


-- segments code (7 segments display)
{-
     A
     -
  F |.| B   . H
  G  -
  E |.| C   . I
     -
     D
-}
type Segment= A | B | C | D | E | F | G | H | I

type Figure = D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | D8 | D9 | Coma | Dash | None | All

-- returns the segments that compose a given figure
figureToSegments : Figure -> List Segment
figureToSegments fig =
    case fig of
        D0 -> [ A, B , C, D, E, F ]
        D1 -> [ B, C ]
        D2 -> [ A, B, D, E, G]
        D3 -> [ A, B, C, D, G]
        D4 -> [ F, B, G, C ]
        D5 -> [ A, F, G, C, D ]
        D6 -> [ A, F, G, E, C, D ]
        D7 -> [ A, B, C ]
        D8 -> [ A, B, C, D, E, F, G ]
        D9 -> [ A, B, C, D, F, G ]
        Coma -> [H, I]
        Dash -> [G]
        None -> []
        All -> [ A, B, C, D, E, F, G, H, I ]

figureToName : Figure -> String
figureToName fig =
    case fig of
        D0 -> "0"
        D1 -> "1"
        D2 -> "2"
        D3 -> "3"
        D4 -> "4"
        D5 -> "5"
        D6 -> "6"
        D7 -> "7"
        D8 -> "8"
        D9 -> "9"
        Coma -> "coma"
        Dash -> "dash"
        All -> "all"
        None -> "none"

charToFigure : Char -> Figure
charToFigure c =
    case c of
        '0' -> D0
        '1' -> D1
        '2' -> D2
        '3' -> D3
        '4' -> D4
        '5' -> D5
        '6' -> D6
        '7' -> D7
        '8' -> D8
        '9' -> D9
        ':' -> Coma
        '-' -> Dash
        _ -> None

stringToFigures : String -> List Figure
stringToFigures s =
    s
    |> String.toList
    |> List.map charToFigure

segmentToName : Segment -> String
segmentToName seg =
    case seg of
        A -> "A"
        B -> "B"
        C -> "C"
        D -> "D"
        E -> "E"
        F -> "F"
        G -> "G"
        H -> "H"
        I -> "I"

timeToString : Time -> String
timeToString time =
    let
        date = fromTime time
        params = [ (hour date), (minute date), (second date) ]
                        |> map toString
                        |> map (padLeft 2 '0')
        pattern = if (second date) % 2 == 0
                  then "{0}:{1}:{2}"
                  else "{0} {1} {2}"
    in
        interpolate pattern params

-- returns an SVG representation for the given segment decorated with the given svg attributes.
segmentSvgView :  List (Svg.Attribute msg) -> Segment -> Svg msg
segmentSvgView attr segment =
    case segment of
        A -> path (attr ++ [ d "M10,8L14,4L42,4L46,8L42,12L14,12L10,8z" ]) []
        B -> path (attr ++ [ d "M48,10L52,14L52,42L48,46L44,42L44,14L48,10z" ]) []
        C -> path (attr ++ [ d "M48,50L52,54L52,82L48,86L44,82L44,54L48,50z" ]) []
        D -> path (attr ++ [ d "M10,88L14,84L42,84L46,88L42,92L14,92L10,88z" ]) []
        E -> path (attr ++ [ d "M8,50L12,54L12,82L8,86L4,82L4,54L8,50z" ]) []
        F -> path (attr ++ [ d "M8,10L12,14L12,42L8,46L4,42L4,14L8,10z" ]) []
        G -> path (attr ++ [ d "M10,48L14,44L42,44L46,48L42,52L14,52L10,48z" ]) []
        H -> circle (attr ++ [ r "4", cx "28", cy "28"]) []
        I -> circle (attr ++ [ r "4", cx "28", cy "68"]) []

figureSvgView : Figure -> Svg msg
figureSvgView fig =
    let
        segments = figureToSegments fig
        asView seg = let
                        lit = member seg segments
                     in
                        segmentSvgView
                                [   classList
                                       [  ("lit", lit)
                                         ,("unlit", not lit)
                                       ]
                                ]
                                seg
    in
        g [ SvgAtt.class ("figure figure-" ++ (figureToName fig)) ]
            ((figureToSegments All)
                |> List.map asView)

stringToSvgView : Model -> String -> List (Svg msg)
stringToSvgView model s =
        stringToFigures s
        |> List.map figureSvgView
        |> List.indexedMap ( \index svg ->
            g [  transform (interpolate "skewX({0}) translate({1},{2})" ([model.tilt, (55+model.spaceX)*index, 0] |> map toString) )

              ]
              [
                svg
              ]
           )

svgView : Model -> Html msg
svgView model =
        div [class "wrapper"]
        [
           svg [ id "digital-clock-display", width "450", height "96", viewBox "0 0 450 96" ]
                   ( model.time
                       |> Maybe.map timeToString
                       |> withDefault "--:--:--"
                       |> stringToSvgView model
                   )

        ]
