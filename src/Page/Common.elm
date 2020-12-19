module Page.Common exposing (..)

-- importColor exposing (Color, rgb, toCssString)
import GraphicSVG exposing (Color)
import Html exposing (Html)
import Html.Events exposing (..)
import Json.Decode exposing (succeed)
import List exposing (map)
import Maybe exposing (andThen)
import Result exposing (toMaybe)
import String.Interpolate exposing (interpolate)
import Svg
import Svg.Attributes exposing (class)
import String exposing (fromInt)
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
