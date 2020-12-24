module Page.Common exposing (..)

import Array exposing (Array)
import Html exposing (Html)
import Html.Events exposing (..)
import Json.Decode
import List exposing (drop, length, sum)
import Maybe exposing (andThen)
import Svg
import Svg.Attributes exposing (class)
import String
import Json.Decode as Decode

type alias PageInfo a = {
      name : String
    , hash : String
    , description : Html a
    , srcRel: String
    }


-- convert the string to float preserving the bounds [min, max]
strToIntWithMinMax : String -> Int -> Int -> Maybe Int
strToIntWithMinMax s minv maxv  = strToNumberWithMinMax s String.toInt minv maxv

-- convert the string to float preserving the bounds [min, max]
strToFloatWithMinMax : String -> Float -> Float -> Maybe Float
strToFloatWithMinMax s minv maxv  = strToNumberWithMinMax s String.toFloat minv maxv

-- convert the string to a number preserving the bounds [min, max]
strToNumberWithMinMax : String -> (String -> Maybe comparable) -> comparable -> comparable -> Maybe comparable
strToNumberWithMinMax s converter minv maxv  =
    case s of
        "" -> Just minv
        x -> x
            |> converter
            |> andThen (Just << Basics.min maxv)
            |> andThen (Just << Basics.max minv)

{-| This function makes it easier to build a space-separated class attribute with SVG
    TODO: To replace with equivalent function in core modules when available
-}
classList : List (String, Bool) -> Svg.Attribute msg
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

indexOfHelper: Array a -> a -> Int -> Int
indexOfHelper array elem offset =
    case (Array.get offset array) of
        Just x ->
            if x == elem then
                offset
            else
               indexOfHelper array elem (offset + 1)
        Nothing ->
            -1

indexOf: Array a -> a -> Int
indexOf array elem = indexOfHelper array elem 0


-- frames holds a sequence of times.
-- the list is bounded to accept a max number of elements -> inserting a new only discards the oldest one
type alias Frames = {
    times : List Float,
    capacity: Int
  }

createFrames : Int -> Frames
createFrames capacity = { times = [], capacity = capacity }

addFrame : Frames -> Float -> Frames
addFrame frames time =
    let
        delta = (length frames.times) - frames.capacity
        makePlace theFrames = if delta >= 0 then (drop (delta + 1) theFrames) else theFrames
    in
    { frames | times = frames.times
                                |> makePlace
                                |> (::) time
    }

resetFrames : Frames -> Frames
resetFrames frames = {frames | times = [] }

-- compute the FPS from the given fps set (if possible)
fps : Frames -> Maybe Float
fps frames =
    let
        size = length frames.times
    in if size > 1 then
        frames.times
          |> sum
          |> (/) (toFloat size)
          |> (*) 1000.0
          |> Just
    else
        Nothing
