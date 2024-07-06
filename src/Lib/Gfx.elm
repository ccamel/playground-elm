module Lib.Gfx exposing (withAlpha)

import Color exposing (Color, fromRgba, toRgba)


withAlpha : Float -> Color -> Color
withAlpha alpha color =
    let
        rgba =
            toRgba color
    in
    { rgba | alpha = alpha } |> fromRgba
