module Lib.Svg exposing (classList)

{-| This function makes it easier to build a space-separated class attribute with SVG
TODO: To replace with equivalent function in core modules when available
-}

import Svg
import Svg.Attributes as SvgAtt


classList : List ( String, Bool ) -> Svg.Attribute msg
classList =
    List.filter Tuple.second
        >> List.map Tuple.first
        >> String.join " "
        >> SvgAtt.class
