module Page.Terrain exposing (Model, Msg, info, init, subscriptions, update, view)

import Basics.Extra exposing (curry)
import Browser.Events exposing (onAnimationFrameDelta)
import Html exposing (Html, div, section)
import Html.Attributes as Attr
import Lib.Page
import Markdown
import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Random exposing (Seed)
import String exposing (fromFloat, fromInt, join)
import Svg exposing (Svg, rect, svg)
import Svg.Attributes exposing (class, d, fill, height, points, stroke, strokeWidth, style, transform, version, viewBox, width, x, y)



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
    , depth : Int
    , hurst : Float
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
            Random.initialSeed 42

        curveGenerator =
            generateFractal parameters.depth parameters.hurst

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
    , speed = 20
    , nbCurves = 40
    , near = 300
    , offsetFactor = 20.0
    , depth = 4
    , hurst = 0.3
    }



-- MESSAGES


type Msg
    = GotAnimationFrameDeltaMilliseconds Float



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
                        generateFractal parameters.depth parameters.hurst

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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    onAnimationFrameDelta GotAnimationFrameDeltaMilliseconds



-- VIEW


view : Model -> Html Msg
view (Model { parameters, terrain }) =
    let
        scaleFactor =
            2

        offsetX =
            toFloat parameters.width * (1 - scaleFactor) / 2

        offsetYPct =
            0.4

        offsetY =
            offsetYPct * toFloat parameters.height
    in
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
                                [ svg
                                    [ version "1.1"
                                    , class "world mx-auto"
                                    , width "100%"
                                    , style "max-width: 1024px"
                                    , height "100%"
                                    , viewBox (join " " [ "0", "0", fromInt parameters.width, fromInt parameters.height ])
                                    ]
                                    [ Svg.g
                                        [ Attr.id "background" ]
                                        [ rect
                                            [ x "0"
                                            , y "0"
                                            , width (fromInt parameters.width)
                                            , height (fromInt parameters.height)
                                            , fill "black"
                                            , strokeWidth "0"
                                            ]
                                            []
                                        ]
                                    , Svg.g
                                        [ transform ("translate(" ++ fromFloat offsetX ++ "," ++ fromFloat (toFloat parameters.height + offsetY) ++ ") scale(" ++ fromFloat scaleFactor ++ ", -1)") ]
                                        [ Svg.g
                                            [ Attr.id "terrain" ]
                                            (viewTerrain parameters terrain)
                                        ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


type alias ViewTerrainParams a =
    { a | width : Int, near : Float, offsetFactor : Float }


viewTerrain : ViewTerrainParams a -> Terrain -> List (Svg Msg)
viewTerrain { width, near, offsetFactor } terrain =
    terrain
        |> List.reverse
        |> List.indexedMap
            (\idx { curve, offset } ->
                let
                    z =
                        offset * offsetFactor

                    ( zoomX, zoomY ) =
                        ( toFloat width / (toFloat <| List.length curve)
                        , 1
                        )

                    perspectiveFactor =
                        near / (near + z)

                    ( perspectiveX, perspectiveY ) =
                        ( perspectiveFactor, perspectiveFactor )

                    ( scaleX, scaleY ) =
                        ( zoomX * perspectiveX
                        , zoomY * perspectiveY
                        )

                    ( translateX, translateY ) =
                        ( toFloat width * (1 - perspectiveX) / 2
                        , z * perspectiveY
                        )
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
                    (viewCurve curve)
            )


viewCurve : Curve -> List (Svg Msg)
viewCurve curve =
    let
        pts =
            curve
                |> curvePoints
                |> List.map (\p -> ( p |> Vec2.getX, p |> Vec2.getY ))
                |> List.map (\( x, y ) -> String.fromFloat x ++ "," ++ String.fromFloat y)

        path =
            "M 0,0 "
                ++ List.foldl (\p acc -> acc ++ " L " ++ p) "" pts
                ++ " V 0 Z"

        polyline =
            join " " pts
    in
    [ Svg.path [ d path, fill "black", stroke "none" ] []
    , Svg.polyline [ points polyline, fill "none", stroke "blue", strokeWidth "0.5" ] []
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


initialCurve : Random.Generator Curve
initialCurve =
    Random.list 7
        (Random.float 0 100
            |> Random.andThen
                (\p ->
                    if p < 70 then
                        Random.float 10 100

                    else
                        Random.constant 0
                )
        )


generateFractal : Int -> Float -> Random.Generator Curve
generateFractal depth hurst =
    fBm depth hurst initialCurve



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



-- MISCELLANEOUS


fBm : Int -> Float -> Random.Generator Curve -> Random.Generator Curve
fBm depth hurst baseGenerator =
    List.foldl
        (\_ gen -> fBmAtDepth depth hurst gen)
        baseGenerator
        (List.range 1 depth)


fBmAtDepth : Int -> Float -> Random.Generator Curve -> Random.Generator Curve
fBmAtDepth depth hurst curveGenerator =
    if depth == 0 then
        curveGenerator

    else
        let
            generateMidpoint : Random.Generator Float -> Random.Generator Float -> Random.Generator Float
            generateMidpoint a b =
                Random.map2 (curry (midpointDisplacementGenerator (2 * hurst * (depth |> toFloat)))) a b
                    |> Random.andThen identity

            refine : List Float -> Random.Generator Curve
            refine =
                List.map Random.constant
                    >> insertBetween generateMidpoint
                    >> combineGenerators
        in
        curveGenerator
            |> Random.andThen refine


midpointDisplacementGenerator : Float -> ( Float, Float ) -> Random.Generator Float
midpointDisplacementGenerator hurst ( a, b ) =
    let
        midpoint : Float
        midpoint =
            (a + b) / 2

        delta : Float
        delta =
            abs (a - b) * 2 ^ -hurst

        rg : Random.Generator Float
        rg =
            Random.float -delta delta
    in
    rg |> Random.map (\r -> midpoint + r)


combineGenerators : List (Random.Generator a) -> Random.Generator (List a)
combineGenerators list =
    case list of
        [] ->
            Random.constant []

        gen :: gens ->
            Random.map2 (::) gen (combineGenerators gens)


insertBetween : (a -> a -> a) -> List a -> List a
insertBetween f list =
    case list of
        [] ->
            []

        [ x ] ->
            [ x ]

        x :: y :: rest ->
            x :: f x y :: insertBetween f (y :: rest)
