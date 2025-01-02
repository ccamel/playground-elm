module Page.Terrain exposing (Model, Msg, info, init, subscriptions, update, view)

import Browser.Events exposing (onAnimationFrameDelta)
import Color exposing (black, blue, toCssString)
import Color.Manipulate exposing (darken)
import Html exposing (Html, div, input, p, section, text)
import Html.Attributes as Attr exposing (name, size, type_, value)
import Html.Events exposing (onInput)
import Lib.Page
import Lib.String exposing (strToFloatWithMinMax)
import Markdown
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Random exposing (Seed)
import String exposing (fromFloat, fromInt, join)
import Svg exposing (Svg, rect)
import Svg.Attributes as SvgAttr exposing (class, d, fill, points, stroke, strokeWidth, style, transform, version, viewBox, x, y)



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "terrain"
    , hash = "terrain"
    , date = "2024-12-31"
    , description = Markdown.toHtml [ Attr.class "content" ] """
A retro-inspired endless terrain flyover, featuring a procedurally generated 1D landscape.
       """
    , srcRel = "Page/Terrain.elm"
    }



-- MODEL


type alias Parameters =
    { width : Int
    , height : Int
    , speed : Float
    , nbCurves : Int
    , near : Float
    , offsetFactor : Float
    , xScale : Float
    , yScale : Float
    , depth : Int
    , hurst : Float
    , mountainProbability : Float
    , shapeColor : Color.Color
    , groundColor : Color.Color
    }


type alias ModelRecord =
    { parameters : Parameters
    , terrain : Terrain -- the terrain to render
    , time : Float -- for animation, in milliseconds
    , seed : Seed -- for random
    }


type Model
    = Model ModelRecord


init : ( Model, Cmd Msg )
init =
    let
        parameters =
            initialParameters

        initialSeed =
            Random.initialSeed 40

        curveGenerator =
            generateFractal parameters.depth parameters.hurst (initialCurve parameters.mountainProbability)

        ( curves, finalSeed ) =
            Random.step (terrainGenerator (\idx -> toFloat idx) curveGenerator parameters.nbCurves) initialSeed
    in
    ( Model
        { parameters = parameters
        , terrain = curves
        , time = 0.0
        , seed = finalSeed
        }
    , Cmd.none
    )


initialParameters : Parameters
initialParameters =
    { width = 320
    , height = 200
    , speed = 2
    , nbCurves = 40
    , near = 300
    , offsetFactor = 20.0
    , xScale = 3.5
    , yScale = 1.5
    , depth = 4
    , hurst = 1.2
    , mountainProbability = 0.1
    , shapeColor = blue
    , groundColor = darken 0.3 blue
    }



-- MESSAGES


type Msg
    = GotAnimationFrameDeltaMilliseconds Float
    | SetSpeed String
    | SetMountainProbability String



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model ({ terrain, time, parameters, seed } as model)) =
    Tuple.mapFirst Model <|
        case msg of
            GotAnimationFrameDeltaMilliseconds delta ->
                let
                    deltaZ =
                        -1 * (parameters.speed * delta / 1000)

                    updatedTerrain =
                        terrain
                            |> moveTerrain deltaZ
                            |> List.filter (\{ offset } -> offset > 0)

                    terrainSize =
                        List.length updatedTerrain

                    neededLayers =
                        parameters.nbCurves - terrainSize

                    curveGenerator =
                        generateFractal parameters.depth parameters.hurst (initialCurve parameters.mountainProbability)

                    ( newTerrain, newSeed ) =
                        Random.step (terrainGenerator (\idx -> toFloat (terrainSize + idx + 1)) curveGenerator neededLayers) seed
                in
                ( { model
                    | time = time + delta
                    , terrain = updatedTerrain ++ newTerrain
                    , seed = newSeed
                  }
                , Cmd.none
                )

            SetSpeed newSpeed ->
                ( case strToFloatWithMinMax newSpeed 0 25 of
                    Just v ->
                        { model | parameters = { parameters | speed = v } }

                    Nothing ->
                        model
                , Cmd.none
                )

            SetMountainProbability newPMountain ->
                ( case strToFloatWithMinMax newPMountain 0 100 of
                    Just v ->
                        { model | parameters = { parameters | mountainProbability = v / 100 } }

                    Nothing ->
                        model
                , Cmd.none
                )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    onAnimationFrameDelta GotAnimationFrameDeltaMilliseconds



-- VIEW


view : Model -> Html Msg
view (Model { parameters, terrain }) =
    section [ Attr.class "section pt-1 has-background-black-bis" ]
        [ div [ Attr.class "container is-max-tablet" ]
            [ div
                [ Attr.id "terrain" ]
                [ div [ class "columns is-centered mt-1" ]
                    [ div [ class "column is-four-fifths" ]
                        [ div [ class "has-text-centered" ]
                            [ div
                                [ style ""
                                ]
                                [ viewTerrain parameters terrain
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        , div [ class "columns" ]
            [ div [ class "column is-8 is-offset-2" ]
                [ div [ class "content is-medium" ]
                    [ div [ class "content is-medium" ]
                        [ p []
                            [ text "The speed of the flyover is "
                            , input
                                [ class "input input-number is-small is-inline"
                                , name "speed"
                                , type_ "number"
                                , size 3
                                , value (fromFloat parameters.speed)
                                , onInput SetSpeed
                                ]
                                []
                            , text ". You can also change the probability (%) of a mountain: "
                            , input
                                [ class "input input-number is-small is-inline"
                                , name "mountainProbability"
                                , type_ "number"
                                , size 3
                                , value (fromFloat <| parameters.mountainProbability * 100)
                                , onInput SetMountainProbability
                                ]
                                []
                            ]
                        ]
                    ]
                ]
            ]
        ]


type alias ViewTerrainParams a =
    { a | width : Int, height : Int, near : Float, offsetFactor : Float, xScale : Float, yScale : Float, shapeColor : Color.Color, groundColor : Color.Color }


viewTerrain : ViewTerrainParams a -> Terrain -> Svg Msg
viewTerrain ({ width, height, near, offsetFactor, xScale, yScale } as params) terrain =
    let
        offsetYPct =
            0.5

        ( offsetX, offsetY ) =
            ( toFloat width * (1 - xScale) / 2, offsetYPct * toFloat height )

        terrains =
            terrain
                |> List.reverse
                |> List.indexedMap
                    (\idx { curve, offset } ->
                        let
                            z =
                                offset * offsetFactor

                            ( zoomX, zoomY ) =
                                ( toFloat width / (toFloat <| List.length curve), yScale )

                            perspectiveFactor =
                                near / (near + z)

                            ( perspectiveX, perspectiveY ) =
                                ( perspectiveFactor, perspectiveFactor )

                            ( scaleX, scaleY ) =
                                ( zoomX * perspectiveX, zoomY * perspectiveY )

                            ( translateX, translateY ) =
                                ( toFloat width * (1 - perspectiveX) / 2, z * perspectiveY )
                        in
                        Svg.g
                            [ Attr.id ("layer-" ++ fromInt idx)
                            , transform
                                ("translate("
                                    ++ fromFloat translateX
                                    ++ ","
                                    ++ fromFloat translateY
                                    ++ ") "
                                    ++ "scale("
                                    ++ fromFloat scaleX
                                    ++ ","
                                    ++ fromFloat scaleY
                                    ++ ")"
                                )
                            ]
                            (viewCurve params curve)
                    )
    in
    Svg.svg
        [ version "1.1"
        , class "world mx-auto"
        , SvgAttr.width "100%"
        , style "max-width: 1024px"
        , SvgAttr.height "100%"
        , viewBox (join " " [ "0", "0", fromInt width, fromInt height ])
        ]
        [ Svg.g
            [ Attr.id "background" ]
            [ rect
                [ x "0"
                , y "0"
                , SvgAttr.width (fromInt width)
                , SvgAttr.height (fromInt height)
                , fill <| toCssString black
                , strokeWidth "0"
                ]
                []
            ]
        , Svg.g
            [ transform ("translate(" ++ fromFloat offsetX ++ "," ++ fromFloat (toFloat height + offsetY) ++ ") scale(" ++ fromFloat xScale ++ ", -1)") ]
            [ Svg.g
                [ Attr.id "terrain" ]
                terrains
            ]
        ]


type alias ViewCurveParams a =
    { a | shapeColor : Color.Color, groundColor : Color.Color }


viewCurve : ViewCurveParams a -> Curve -> List (Svg Msg)
viewCurve { shapeColor, groundColor } curve =
    let
        pts =
            curve
                |> curvePoints
                |> List.map (\p -> String.fromFloat (Vec2.getX p) ++ "," ++ String.fromFloat (Vec2.getY p))

        path =
            "M 0,0 " ++ String.join " L " pts ++ " V 0 Z"

        polyline =
            String.join " " pts

        groundPath =
            "M 0,0 L " ++ String.fromInt (List.length curve) ++ ",0"
    in
    [ Svg.path [ d path, fill "black", stroke "none" ] []
    , Svg.polyline [ points polyline, fill "none", stroke <| toCssString shapeColor, strokeWidth "0.5" ]
        []
    , Svg.path [ d groundPath, fill "none", stroke <| toCssString groundColor, strokeWidth "2" ] []
    ]



-- CURVE


{-| A curve is a list of floats representing the height of the terrain at each point.
-}
type alias Curve =
    List Float


{-| A curve located at a specific offset.
-}
type alias LocatedCurve =
    { curve : Curve
    , offset : Float -- the offset of the curve in the z direction. 0 is the front of the screen.
    }


curveAt : Float -> Curve -> LocatedCurve
curveAt offset curve =
    { curve = curve
    , offset = offset
    }


moveCurve : Float -> LocatedCurve -> LocatedCurve
moveCurve delta { curve, offset } =
    { curve = curve, offset = offset + delta }


curvePointsWith : (Int -> Float) -> Curve -> List Vec2
curvePointsWith indexToX curve =
    List.indexedMap (\i y -> vec2 (indexToX i) y) curve


curvePoints : Curve -> List Vec2
curvePoints =
    curvePointsWith toFloat


initialCurve : Float -> Random.Generator Curve
initialCurve mountainProbability =
    Random.list 7
        (Random.float 0 1
            |> Random.andThen
                (\p ->
                    if p < mountainProbability then
                        Random.float 10 100

                    else
                        Random.constant 0
                )
        )


generateFractal : Int -> Float -> Random.Generator Curve -> Random.Generator Curve
generateFractal depth hurst curveGenerator =
    fBm depth hurst curveGenerator



-- TERRAIN


{-| A list of curves representing the terrain.
-}
type alias Terrain =
    List LocatedCurve


moveTerrain : Float -> Terrain -> Terrain
moveTerrain delta =
    List.map (moveCurve delta)


terrainGenerator : (Int -> Float) -> Random.Generator Curve -> Int -> Random.Generator Terrain
terrainGenerator indexToOffset curveGenerator nbCurves =
    Random.list nbCurves curveGenerator
        |> Random.map (List.indexedMap (\idx curve -> curveAt (indexToOffset idx) curve))



-- FBM


fBm : Int -> Float -> Random.Generator Curve -> Random.Generator Curve
fBm depth hurst genCurve =
    if depth <= 0 then
        genCurve

    else
        genCurve
            |> Random.andThen
                (\points ->
                    subdivideAndCombine points (\( a, b ) -> midpointDisplacementGenerator hurst ( a, b ))
                        |> Random.andThen
                            (\refinedPoints ->
                                fBm (depth - 1) hurst (Random.constant refinedPoints)
                            )
                )


midpointDisplacementGenerator : Float -> ( Float, Float ) -> Random.Generator Float
midpointDisplacementGenerator hurst ( a, b ) =
    let
        midpoint =
            (a + b) / 2

        delta =
            abs (a - b) * (2 ^ -hurst)

        randomDisplacement =
            Random.float -delta delta
    in
    Random.map (\d -> midpoint + d) randomDisplacement


subdivideAndCombine :
    List Float
    -> (( Float, Float ) -> Random.Generator Float)
    -> Random.Generator Curve
subdivideAndCombine points combine =
    case points of
        [] ->
            Random.constant []

        [ x ] ->
            Random.constant [ x ]

        x :: y :: rest ->
            Random.map2
                (\mid newTail -> x :: mid :: newTail)
                (combine ( x, y ))
                (subdivideAndCombine (y :: rest) combine)
