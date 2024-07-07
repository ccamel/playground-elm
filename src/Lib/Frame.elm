module Lib.Frame exposing (Frames, addFrame, createFrames, fpsText, resetFrames)

import Array exposing (foldl)
import Basics.Extra exposing (flip)
import FormatNumber exposing (format)
import Lib.Array exposing (BoundedArray, appendToBoundedArray, createBoundedArray, resetBoundedArray)
import Lib.Locale exposing (locale1digit)
import Maybe exposing (withDefault)
import String exposing (padLeft)
import String.Interpolate exposing (interpolate)


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
        let
            totalTime =
                foldl (+) 0 frames.values

            averageTime =
                totalTime / 1000.0 / toFloat frames.length
        in
        Just (1.0 / averageTime)

    else
        Nothing


{-| returns a representation of the FPS value as a string
-}
fpsText : Frames -> String
fpsText frames =
    interpolate "{0} fps"
        [ fps frames
            |> Maybe.map (format locale1digit)
            |> withDefault "-"
            |> padLeft 5 ' '
        ]
