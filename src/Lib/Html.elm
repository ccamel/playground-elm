module Lib.Html exposing (classList, onClickNotPropagate)

{-| This function makes it easier to build a space-separated class attribute with SVG
TODO: To replace with equivalent function in core modules when available
-}

import Html
import Html.Attributes exposing (class)
import Html.Events exposing (custom)
import Json.Decode as Decode
import Svg


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
