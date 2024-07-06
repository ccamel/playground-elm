module Lib.Range exposing (limitRange)

{-| ensures that the given comparable is limited to the given range [min, max]
-}


limitRange : ( comparable, comparable ) -> comparable -> comparable
limitRange ( minv, maxv ) v =
    v
        |> Basics.min maxv
        |> Basics.max minv
