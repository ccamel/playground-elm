module Page.Terrain exposing (Model, Msg, info, init, subscriptions, update, view)

import Browser.Events exposing (onAnimationFrameDelta)
import Html exposing (Html, div, input, p, section, text)
import Html.Attributes as Attr exposing (class, name, size, type_, value)
import Html.Events exposing (onInput)
import Json.Encode as Encode
import Lib.Page
import Lib.String exposing (strToFloatWithMinMax)
import Markdown
import Random exposing (Seed)
import String exposing (fromFloat)


info : Lib.Page.PageInfo Msg
info =
    { name = "terrain"
    , hash = "terrain"
    , date = "2024-12-31"
    , description = Markdown.toHtml [ Attr.class "content" ] "A retro-inspired endless terrain flyover, featuring a procedurally generated 1D landscape."
    , srcRel = "Page/Terrain.elm"
    }


type alias Parameters =
    { speed : Float
    , mountainProbability : Float
    }


type alias Slice =
    { heights : List Float, distance : Float }


type alias Landscape =
    { start : List Float
    , target : List Float
    , step : Int
    , seed : Seed
    }


type Model
    = Model
        { parameters : Parameters
        , terrain : List Slice
        , landscape : Landscape
        }


sliceSpacing : Float
sliceSpacing =
    24


sliceCount : Int
sliceCount =
    18


init : ( Model, Cmd Msg )
init =
    let
        parameters =
            { speed = 3, mountainProbability = 0.42 }

        ( start, seed1 ) =
            Random.step (profile parameters.mountainProbability) (Random.initialSeed 40)

        ( target, seed2 ) =
            Random.step (profile parameters.mountainProbability) seed1

        ( terrain, landscape ) =
            appendSlices parameters.mountainProbability sliceCount 0 { start = start, target = target, step = 0, seed = seed2 }
    in
    ( Model { parameters = parameters, terrain = terrain, landscape = landscape }, Cmd.none )


type Msg
    = GotAnimationFrameDeltaMilliseconds Float
    | SetSpeed String
    | SetMountainProbability String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    let
        parameters =
            model.parameters
    in
    case msg of
        GotAnimationFrameDeltaMilliseconds delta ->
            let
                -- Discard long pauses when the tab resumes; keep ordinary motion time based.
                travel =
                    parameters.speed * 12 * clamp 0 100 delta / 1000

                remaining =
                    model.terrain
                        |> List.map (\slice -> { slice | distance = slice.distance - travel })
                        |> List.filter (\slice -> slice.distance > 0)

                farthest =
                    remaining |> List.reverse |> List.head |> Maybe.map .distance |> Maybe.withDefault 0

                ( added, landscape ) =
                    appendSlices parameters.mountainProbability (sliceCount - List.length remaining) farthest model.landscape
            in
            ( Model { model | terrain = remaining ++ added, landscape = landscape }, Cmd.none )

        SetSpeed raw ->
            ( Model { model | parameters = { parameters | speed = strToFloatWithMinMax raw 0 25 |> Maybe.withDefault parameters.speed } }, Cmd.none )

        SetMountainProbability raw ->
            ( Model { model | parameters = { parameters | mountainProbability = strToFloatWithMinMax raw 0 100 |> Maybe.map (\v -> v / 100) |> Maybe.withDefault parameters.mountainProbability } }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    onAnimationFrameDelta GotAnimationFrameDeltaMilliseconds


view : Model -> Html Msg
view (Model { parameters, terrain }) =
    section [ Attr.class "section pt-1 has-background-black-bis" ]
        [ div [ Attr.class "container is-max-tablet" ]
            [ div
                [ Attr.id "terrain" ]
                [ div [ class "columns is-centered mt-1" ]
                    [ div [ class "column is-four-fifths" ]
                        [ div [ class "has-text-centered" ]
                            [ div []
                                [ viewTerrain terrain
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


viewTerrain : List Slice -> Html Msg
viewTerrain terrain =
    let
        curves =
            List.map projectSlice terrain

        attributes =
            [ Attr.style "display" "block"
            , Attr.style "width" "100%"
            , Attr.style "max-width" "1024px"
            , Attr.style "background" "black"
            , Attr.style "aspect-ratio" "8 / 5"
            , Attr.class "world mx-auto"
            , Attr.attribute "role" "img"
            , Attr.attribute "aria-label" "Blue contour lines moving across a black landscape"
            ]
    in
    Html.node "terrain-raster"
        (Attr.property "curves" (Encode.list (Encode.list (\( x, y ) -> Encode.list Encode.float [ x, y ])) curves) :: attributes)
        []


projectSlice : Slice -> List ( Float, Float )
projectSlice slice =
    let
        -- Both renderers use this exact projection, before raster quantization.
        perspective =
            120 / (8 + slice.distance)

        intervals =
            toFloat (List.length slice.heights - 1)
    in
    slice.heights
        |> List.indexedMap
            (\index height ->
                ( 160 + (toFloat index / intervals - 0.5) * 1800 * perspective
                , 112 + (70 - height) * perspective
                )
            )


{-| Low control points describe broad hills. Mountain probability adds
occasional taller relief, without turning the rest of the landscape into flats.
-}
profile : Float -> Random.Generator (List Float)
profile probability =
    Random.list 17
        (Random.float 0 1
            |> Random.andThen
                (\chance ->
                    if chance < probability then
                        Random.float 35 53

                    else
                        Random.float 5 28
                )
        )
        |> Random.andThen (subdivide 5 12)
        |> Random.map (List.map (clamp 0 60))


{-| Interpolate between target profiles over eight slices. Both adjacent
segments share their end profile; smoothstep prevents a crease at the join.
-}
nextSlice : Float -> Landscape -> ( List Float, Landscape )
nextSlice probability landscape =
    if landscape.step >= 8 then
        let
            ( target, seed ) =
                Random.step (profile probability) landscape.seed
        in
        nextSlice probability { start = landscape.target, target = target, step = 0, seed = seed }

    else
        let
            t =
                toFloat landscape.step / 8

            blend =
                t * t * (3 - 2 * t)

            heights =
                List.map2 (\a b -> a + (b - a) * blend) landscape.start landscape.target
        in
        ( heights, { landscape | step = landscape.step + 1 } )


{-| Random midpoint displacement at five scales. Amplitude decays at each
subdivision, independently of the endpoint slope, so flat spans also gain detail.
Profiles are generated once, then interpolated in depth: no per-frame noise.
-}
subdivide : Int -> Float -> List Float -> Random.Generator (List Float)
subdivide depth amplitude heights =
    if depth <= 0 then
        Random.constant heights

    else
        midpoints amplitude heights
            |> Random.andThen (subdivide (depth - 1) (amplitude * 0.55))


midpoints : Float -> List Float -> Random.Generator (List Float)
midpoints amplitude heights =
    case heights of
        a :: b :: rest ->
            Random.map2
                (\displacement tail -> a :: ((a + b) / 2 + displacement) :: tail)
                (Random.float -amplitude amplitude)
                (midpoints amplitude (b :: rest))

        _ ->
            Random.constant heights


appendSlices : Float -> Int -> Float -> Landscape -> ( List Slice, Landscape )
appendSlices probability count distance landscape =
    if count <= 0 then
        ( [], landscape )

    else
        let
            ( heights, nextLandscape ) =
                nextSlice probability landscape

            nextDistance =
                distance + sliceSpacing

            ( rest, finalLandscape ) =
                appendSlices probability (count - 1) nextDistance nextLandscape
        in
        ( { heights = heights, distance = nextDistance } :: rest, finalLandscape )
