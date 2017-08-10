module Page.Common exposing (..)

import Html exposing (Html)
import Maybe exposing (andThen)
import Result exposing (toMaybe)

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
strToNumberWithMinMax : String -> (String -> Result String comparable) -> comparable -> comparable -> Maybe comparable
strToNumberWithMinMax s converter minv maxv  =
    case s of
        "" -> Just 0
        x -> x
            |> converter
            |> toMaybe
            |> andThen (Just << Basics.min maxv)
            |> andThen (Just << Basics.max minv)