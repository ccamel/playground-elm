module Lib.Decoder exposing (outsideTarget)

import Json.Decode as Decode


{-| Returns a decoder that checks if the target of the event is outside the target element and
returns the message if it is.
-}
outsideTarget : String -> msg -> Decode.Decoder msg
outsideTarget targetId msg =
    let
        decodeComparison id currentId =
            if id == currentId then
                Decode.succeed False

            else
                Decode.fail "continue"

        isOutsideDecoder id =
            Decode.oneOf
                [ Decode.field "id" Decode.string
                    |> Decode.andThen (decodeComparison id)
                , Decode.field "parentNode" (Decode.lazy (\_ -> isOutsideDecoder id))
                , Decode.succeed True
                ]

        toMsgDecoder isOutside =
            if isOutside then
                Decode.succeed msg

            else
                Decode.fail ("inside target " ++ targetId)
    in
    Decode.field "target" (isOutsideDecoder targetId)
        |> Decode.andThen toMsgDecoder
