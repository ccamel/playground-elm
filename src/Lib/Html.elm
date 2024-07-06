module Lib.Html exposing (classList, onClickNotPropagate, svgClassList)

{-| This function makes it easier to build a space-separated class attribute with SVG
TODO: To replace with equivalent function in core modules when available
-}

import Html
import Html.Attributes as HtmlAtt
import Html.Events exposing (custom)
import Json.Decode as Decode
import Svg
import Svg.Attributes as SvgAtt


classList : List ( String, Bool ) -> Html.Attribute msg
classList =
    List.filter Tuple.second
        >> List.map Tuple.first
        >> String.join " "
        >> HtmlAtt.class


svgClassList : List ( String, Bool ) -> Svg.Attribute msg
svgClassList =
    List.filter Tuple.second
        >> List.map Tuple.first
        >> String.join " "
        >> SvgAtt.class


onClickNotPropagate : a -> Html.Attribute a
onClickNotPropagate msg =
    custom "click"
        (Decode.succeed
            { message = msg
            , stopPropagation = True
            , preventDefault = True
            }
        )
