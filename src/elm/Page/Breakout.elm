module Page.Breakout exposing (..)

import Html exposing (Html, a, div, h2, h3, hr, i, img, li, p, text, ul)
import Html.Attributes exposing (alt, attribute, class, href, id, src, style)
import Markdown
import Page.Common
import Svg exposing (Svg, circle, rect, svg)
import Svg.Attributes exposing (height, r, rx, ry, viewBox, width, x, y)




-- PAGE INFO

info : Page.Common.PageInfo Msg
info = {
     name = "breakout"
     , hash = "breakout"
     , description = Markdown.toHtml [class "info"] """

A clone of the classical game using SVG
       """
     , srcRel = "Page/Breakout.elm"
 }

-- MODEL

-- 'traits'
type alias Positioned a =
    { a | x : Int, y : Int }

type alias Moving a =
    { a | vx : Int, vy : Int}

type alias Sized a =
    { a | w : Int, h : Int}


-- objects

type alias Paddle =
    Moving (Sized (Positioned {}))

type alias Brick =
    Sized (Positioned {})

type alias Model = {
    paddle: Paddle
 }

initialModel : Model
initialModel = {
    paddle = { x = 0
              ,y =0
              ,vx = 0
              ,vy = 0
              ,w = 200
              ,h = 50
             }
  }

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

toPixel : Int -> String
toPixel v = (toString v) ++ "px"

view : Model -> Html Msg
view model =
  div [ class "container" ]
      [ hr [] []
        ,svg [id "breakout-area", viewBox "0 0 1280 720" ]
        [
            viewPaddle model
        ]
      ]

viewPaddle : Model -> Svg msg
viewPaddle model =
    rect [
         id "paddle"
        ,height (toPixel model.paddle.h)
        ,width (toPixel model.paddle.w)
        ,rx "10px"
        ,ry "10px"
        ,x "0"
        ,y "0"
    ] []