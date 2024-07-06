module Lib.Locale exposing (locale1digit)

import FormatNumber.Locales exposing (Decimals(..), Locale, usLocale)


{-| returns the locale for the US with 1 digit precision
-}
locale1digit : Locale
locale1digit =
    { usLocale
        | decimals = Exact 1
        , thousandSeparator = ","
        , decimalSeparator = "."
        , negativePrefix = "−"
    }
