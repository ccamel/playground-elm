module Page.Common exposing (..)

import Array exposing (Array, foldl, get, indexedMap)
import Color exposing (Color, fromRgba, toRgba)
import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Locale, usLocale)
import Html exposing (Html)
import Html.Events exposing (..)
import Json.Decode as Decode
import List exposing (length)
import Maybe exposing (andThen, withDefault)
import String exposing (padLeft)
import String.Interpolate exposing (interpolate)
import Svg
import Svg.Attributes exposing (class)


type alias PageInfo a =
    { name : String
    , hash : String
    , description : Html a
    , srcRel : String
    }



-- convert the string to float preserving the bounds [min, max]


strToIntWithMinMax : String -> Int -> Int -> Maybe Int
strToIntWithMinMax s minv maxv =
    strToNumberWithMinMax s String.toInt minv maxv



-- convert the string to float preserving the bounds [min, max]


strToFloatWithMinMax : String -> Float -> Float -> Maybe Float
strToFloatWithMinMax s minv maxv =
    strToNumberWithMinMax s String.toFloat minv maxv



-- convert the string to a number preserving the bounds [min, max]


strToNumberWithMinMax : String -> (String -> Maybe comparable) -> comparable -> comparable -> Maybe comparable
strToNumberWithMinMax s converter minv maxv =
    case s of
        "" ->
            Just minv

        x ->
            x
                |> converter
                |> andThen (Just << Basics.min maxv)
                |> andThen (Just << Basics.max minv)


{-| This function makes it easier to build a space-separated class attribute with SVG
TODO: To replace with equivalent function in core modules when available
-}
classList : List ( String, Bool ) -> Svg.Attribute msg
classList list =
    list
        |> List.filter Tuple.second
        |> List.map Tuple.first
        |> String.join " "
        |> class


onClickNotPropagate : a -> Html.Attribute a
onClickNotPropagate msg =
    custom "click"
        (Decode.succeed
            { message = msg
            , stopPropagation = True
            , preventDefault = True
            }
        )


indexOfHelper : Array a -> a -> Int -> Int
indexOfHelper array elem offset =
    case Array.get offset array of
        Just x ->
            if x == elem then
                offset

            else
                indexOfHelper array elem (offset + 1)

        Nothing ->
            -1


indexOf : Array a -> a -> Int
indexOf array elem =
    indexOfHelper array elem 0



-- frames holds a sequence of times.
-- the list is bounded to accept a max number of elements -> inserting a new only discards the oldest one


type alias Frames =
    { times : Array Float
    , length : Int
    , capacity : Int
    }


createFrames : Int -> Frames
createFrames capacity =
    { times = Array.initialize capacity (always 0), length = 0, capacity = capacity }


addFrame : Frames -> Float -> Frames
addFrame frames time =
    let
        ( times, length ) =
            if frames.length == frames.capacity then
                ( frames.times
                    |> indexedMap (\i _ -> get (i + 1) frames.times |> withDefault 0.0)
                , frames.capacity - 1
                )

            else
                ( frames.times, frames.length )
    in
    { frames
        | times = Array.set length time times
        , length = length + 1
    }


resetFrames : Frames -> Frames
resetFrames { capacity } =
    createFrames capacity



-- compute the FPS from the given fps set (if possible)


fps : Frames -> Maybe Float
fps frames =
    if frames.length > 1 then
        frames.times
            |> foldl (+) 0
            |> (/) (toFloat frames.length)
            |> (*) 1000.0
            |> Just

    else
        Nothing


locale1digit : Locale
locale1digit =
    { usLocale
        | decimals = 1
        , thousandSeparator = ","
        , decimalSeparator = "."
        , negativePrefix = "−"
    }


fpsText : Frames -> String
fpsText frames =
    interpolate "{0} fps"
        [ fps frames
            |> Maybe.map (format locale1digit)
            |> withDefault "-"
            |> padLeft 5 ' '
        ]


withAlpha : Float -> Color -> Color
withAlpha alpha color =
    let
        rgba =
            toRgba color
    in
    { rgba | alpha = alpha } |> fromRgba
