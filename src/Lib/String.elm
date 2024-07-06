module Lib.String exposing (strToFloatWithMinMax, strToIntWithMinMax)

{-| convert the string to float preserving the bounds [min, max]
-}

import Lib.Range exposing (limitRange)
import Maybe exposing (map)


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
