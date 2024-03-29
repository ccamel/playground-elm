module Page.Common exposing (BoundedArray, Frames, PageInfo, addFrame, appendToBoundedArray, classList, createBoundedArray, createFrames, fpsText, onClickNotPropagate, resetFrames, resizeBoundedArray, strToFloatWithMinMax, strToIntWithMinMax, toPixels, withAlpha)

import Array exposing (Array, foldl, get, indexedMap)
import Basics.Extra exposing (flip)
import Color exposing (Color, fromRgba, toRgba)
import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Decimals(..), Locale, usLocale)
import Html exposing (Html)
import Html.Events exposing (custom)
import Json.Decode as Decode
import Maybe exposing (map, withDefault)
import String exposing (fromInt, padLeft)
import String.Interpolate exposing (interpolate)
import Svg
import Svg.Attributes exposing (class)


type alias PageInfo a =
    { name : String
    , hash : String
    , description : Html a
    , srcRel : String
    }


{-| convert the string to float preserving the bounds [min, max]
-}
strToIntWithMinMax : String -> Int -> Int -> Maybe Int
strToIntWithMinMax s minv maxv =
    strToNumberWithMinMax s String.toInt minv maxv


{-| convert the string to float preserving the bounds [min, max]
-}
strToFloatWithMinMax : String -> Float -> Float -> Maybe Float
strToFloatWithMinMax s minv maxv =
    strToNumberWithMinMax s String.toFloat minv maxv


{-| convert the string to a number preserving the bounds [min, max]
-}
strToNumberWithMinMax : String -> (String -> Maybe comparable) -> comparable -> comparable -> Maybe comparable
strToNumberWithMinMax s converter minv maxv =
    case s of
        "" ->
            Just minv

        x ->
            x
                |> converter
                |> map (limitRange ( minv, maxv ))


{-| ensures that the given comparable is limited to the given range [min, max]
-}
limitRange : ( comparable, comparable ) -> comparable -> comparable
limitRange ( minv, maxv ) v =
    v
        |> Basics.min maxv
        |> Basics.max minv


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


type alias BoundedArray a =
    { values : Array a
    , length : Int
    , capacity : Int
    , default : () -> a
    }


{-| append a value to the end of the bounded array.
if length of the array has reached the capacity, the elements are shifted to the left to make
a new place for the inserted value.
-}
appendToBoundedArray : a -> BoundedArray a -> BoundedArray a
appendToBoundedArray value ({ values, length, capacity, default } as array) =
    let
        withDefaultValue =
            withDefault (default ())

        shiftLeft i _ =
            get (i + 1) values |> withDefaultValue

        ( shiftedValues, newLength ) =
            if length == capacity then
                ( indexedMap shiftLeft values
                , capacity - 1
                )

            else
                ( values, length )
    in
    { array
        | values = Array.set newLength value shiftedValues
        , length = newLength + 1
    }


createBoundedArray : Int -> (() -> a) -> BoundedArray a
createBoundedArray capacity default =
    { values = Array.initialize capacity (always <| default ()), length = 0, capacity = capacity, default = default }


resetBoundedArray : BoundedArray a -> BoundedArray a
resetBoundedArray { capacity, default } =
    createBoundedArray capacity default


resizeBoundedArray : Int -> BoundedArray a -> BoundedArray a
resizeBoundedArray capacity { default } =
    createBoundedArray capacity default


{-| frames holds a sequence of times.
the list is bounded to accept a max number of elements -> inserting a new only discards the oldest one
-}
type alias Frames =
    BoundedArray Float


createFrames : Int -> Frames
createFrames =
    flip createBoundedArray (\_ -> 0.0)


addFrame : Frames -> Float -> Frames
addFrame =
    flip appendToBoundedArray


resetFrames : Frames -> Frames
resetFrames =
    resetBoundedArray


{-| compute the FPS from the given fps set (if possible)
-}
fps : Frames -> Maybe Float
fps frames =
    if frames.length > 1 then
        frames.values
            |> foldl (+) 0
            |> (\f ->
                    toFloat frames.length
                        / f
                        |> (\v ->
                                1000.0
                                    * v
                                    |> Just
                           )
               )

    else
        Nothing


locale1digit : Locale
locale1digit =
    { usLocale
        | decimals = Exact 1
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


toPixels : Int -> String
toPixels size =
    size
        |> fromInt
        |> flip String.append "px"
