module Page.Common exposing (..)

import Html exposing (Html, a, text)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)

type alias PageInfo a = {
      name : String
    , hash : String
    , description : Html a
    , srcRel: String
    }
