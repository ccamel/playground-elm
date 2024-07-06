module Lib.Page exposing (PageInfo)

import Html exposing (Html)


{-| A type alias for a page's metadata.
-}
type alias PageInfo a =
    { name : String
    , hash : String
    , date : String
    , description : Html a
    , srcRel : String
    }
