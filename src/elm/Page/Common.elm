module Page.Common exposing (..)

import Html exposing (Html)

type alias PageInfo a = {
      name : String
    , hash : String
    , description : Html a
    }