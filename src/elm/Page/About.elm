module Page.About exposing (..)

import Html exposing (Html, div, text)
import Page.Common


-- PAGE INFO

info : Page.Common.PageInfo Msg
info = {
     name = "about"
     , hash = "about"
     , description =
        div []
            [ text "Short description about this playgound" ]
 }

-- MODEL

type alias Model = {

 }

initialModel : Model
initialModel = {}

-- UPDATE

type Msg = Reset

update : Msg -> Model -> Model
update msg model =
  case msg of
    Reset -> model

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- VIEW

view : Model -> Html Msg
view model =
  div []
     [ text "About" ]