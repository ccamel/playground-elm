module Page.Cloth exposing (..)

import Array exposing (Array, foldr, fromList, get, map, set, toList)
import Basics.Extra exposing (flip)
import Canvas exposing (Renderable, Shape, arc, clear, lineTo, path, shapes)
import Canvas.Settings exposing (fill, stroke)
import Color exposing (Color)
import Html exposing (Html, button, div, hr, text)
import Html.Attributes exposing (class, style, type_)
import Html.Events as Html
import List
import Markdown
import Maybe exposing (withDefault)
import Page.Common
import Browser.Events exposing (onAnimationFrameDelta)
import Platform.Sub exposing (batch)
import Vector2 exposing (Index(..), Vector2, map2)
import Html.Events.Extra.Mouse as Mouse exposing (Button(..))

-- PAGE INFO

info : Page.Common.PageInfo Msg
info = {
     name = "cloth"
     , hash = "cloth"
     , description = Markdown.toHtml [class "info"] """
A cloth rendered using HTML5 canvas simulated with simple [Verlet](https://en.wikipedia.org/wiki/Verlet_integration)
integration.
       """
     , srcRel = "Page/Cloth.elm"
 }

-- MODEL

-- constants
canvas_height     = 400
canvas_width      = 800
physics_iteration = 3
mouse_influence   = 10

type alias ID = Int

type alias Vector2D = Vector2 Float

makeVector2D: (Float, Float) -> Vector2D
makeVector2D (x, y) = Vector2.from2 x y

getX: Vector2D -> Float
getX v = Vector2.get Index0 v

getY: Vector2D -> Float
getY v = Vector2.get Index1 v

getXY: Vector2D -> (Float, Float)
getXY v = (getX v, getY v)

distSq: Vector2D -> Vector2D -> Float
distSq v1 v2 =
    let
        (dx, dy) = sub v1 v2 |> getXY
    in
        dx * dx + dy * dy

dist: Vector2D -> Vector2D -> Float
dist v1 v2 = sqrt (distSq v1 v2)

add: Vector2D -> Vector2D -> Vector2D
add v1 v2 = map2 (+) v1 v2

sub: Vector2D -> Vector2D -> Vector2D
sub v1 v2 = map2 (-) v1 v2

mult: Vector2D -> Float -> Vector2D
mult v a = Vector2.map ((*) a) v

divide: Vector2D -> Float -> Vector2D
divide v a = Vector2.map ((/) a) v

magSq: Vector2D -> Float
magSq v = Vector2.foldl (\x r -> x*x + r ) 0 v

mag: Vector2D -> Float
mag v = sqrt (magSq v)

type alias Dot = {
      id: ID
     ,pos: Vector2D
     ,oldPos: Vector2D
     ,friction: Float
     ,groundFriction: Float
     ,gravity: Vector2D
     ,radius: Float
     ,color: Color
     ,mass: Float
     ,pin: Maybe Vector2D
    }

type alias Stick =
    {
         p1Id: ID
        ,p2Id: ID
        ,stiffness: Float
        ,color: Color
        ,length: Float
    }

type alias Cloth =
    {
      dots: Array Dot
     ,sticks: List Stick
    }

makeDot: ID -> Vector2D -> Dot
makeDot id v =
        {
            id = id
           ,pos = v
           ,oldPos = v
           ,friction = 0.97
           ,groundFriction = 0.7
           ,gravity = makeVector2D (0, 1)
           ,radius = 2.0
           ,color = Color.red
           ,mass = 1
           ,pin = Nothing
        }

makeDotWithVelocity: ID -> Vector2D -> Vector2D -> Dot
makeDotWithVelocity id p v =
        {
            id = id
           ,pos = p
           ,oldPos = (add p v)
           ,friction = 0.97
           ,groundFriction = 0.7
           ,gravity = makeVector2D (0, 1)
           ,radius = 2.0
           ,color = Color.red
           ,mass = 1
           ,pin = Nothing
        }

pinDot: Dot -> Vector2D -> Dot
pinDot p pin =
    { p | pin = Just pin }

unpinDot: Dot -> Vector2D -> Dot
unpinDot p pin =
    {  p | pin = Nothing }

updateDot: Dot -> Dot
updateDot dot =
  let
      vel = sub dot.pos dot.oldPos
              |> (flip mult) (dot.friction)

      vel2 = if ((dot.pos |> getY) >= ((toFloat canvas_height) - dot.radius))
                && ((magSq vel) > 0.000001) then
                let
                    m = mag vel
                in
                    divide vel m
                      |> (flip mult) (m * dot.groundFriction)
              else
                vel
  in
    { dot |
         oldPos = dot.pos
        ,pos = dot.pos |> add vel2 |> add dot.gravity
    }

interractCloth: Maybe MouseState -> Cloth -> Cloth
interractCloth mousestate cloth =
    case mousestate of
        Just mouse ->
            { cloth |
                  dots = cloth.dots
                  |> map (\dot ->
                    let
                        d = dist dot.pos mouse.pos
                    in
                        if d < mouse_influence then
                            { dot |
                                oldPos = sub dot.pos (sub mouse.pos mouse.oldPos |> (flip mult) 1.8)
                            }
                       else
                            dot
                  )
            }
        _ ->
            cloth

constraintDot: Dot -> Dot
constraintDot dot =
    let
        d = dot.radius * 2
        (x, y) = dot.pos |> getXY
        (limitHighW, limitHighH) = (canvas_width - d, canvas_height - d)
        (limitLowW, limitLowH) = (d, d)

        p =
            case dot.pin of
                Nothing ->
                    (
                        if x > limitHighW then
                            limitHighW
                        else if x < limitLowW then
                            limitLowW
                        else x
                       ,if y > limitHighH then
                            limitHighH
                        else if y < limitLowH then
                            limitLowH
                        else y) |> makeVector2D
                Just pin ->
                    pin
    in
        { dot |
            pos = p
        }

renderDot: Dot -> Renderable
renderDot dot =
    shapes
        [ fill dot.color ]
        [  arc (getXY dot.pos) dot.radius { startAngle = degrees 0, endAngle = degrees 360, clockwise = True }
        ]

makeStick: Dot -> Dot -> Maybe Float -> Stick
makeStick p1 p2 length =
    {
         p1Id = p1.id
        ,p2Id = p2.id
        ,stiffness = 2.5
        ,color = Color.black
        ,length =
            case length of
                Just alength -> alength
                Nothing -> dist p1.pos p2.pos
    }


addStick: ID -> ID -> Cloth -> Cloth
addStick p1Id p2Id cloth =
    let
        (p1, p2) = (getDot p1Id cloth, getDot p2Id cloth)
    in
    { cloth |
        sticks = makeStick p1 p2 Nothing :: cloth.sticks
    }

updateStick: Cloth -> Stick -> Cloth
updateStick cloth stick =
    let
        (p1, p2) = (getDot stick.p1Id cloth, getDot stick.p2Id cloth)
        delta = sub p2.pos p1.pos
        d = dist p1.pos p2.pos
        diff = (stick.length - d) / d * stick.stiffness

        offset = delta |> (flip mult) (diff * 0.5)

        m = p1.mass + p2.mass
        m2 = p1.mass / m
        m1 = p2.mass / m

        p1u =
            if p1.pin == Nothing then
                { p1 | pos = p1.pos |> (flip sub) (mult offset m1) }
            else
                p1

        p2u =
            if p2.pin == Nothing then
                { p2 | pos = p2.pos |> (flip add) (mult offset m2) }
            else
                p2
    in
        cloth
        |> setDot p1u
        |> setDot p2u


renderStick: Cloth -> Stick -> Renderable
renderStick cloth stick =
    let
        (p1, p2) = (getDot stick.p1Id cloth, getDot stick.p2Id cloth)
    in
        shapes
            [ stroke stick.color ]
            [  path (getXY p1.pos) [ lineTo (getXY p2.pos) ]
            ]

makeCloth2: Cloth
makeCloth2 =
    let
        p0 = makeDotWithVelocity 0 (makeVector2D (100, 100)) (makeVector2D (20.43, 0))
        p1 = makeDot 1 (makeVector2D (200, 100))
        p2 = makeDot 2 (makeVector2D (200, 200))
        p3 = makeDot 3 (makeVector2D (100, 200))
        dots = [ p0, p1, p2, p3] |> fromList
        sticks = [
             makeStick p0 p1 Nothing
            ,makeStick p1 p2 Nothing
            ,makeStick p2 p3 Nothing
            ,makeStick p3 p0 Nothing
            ,makeStick p3 p1 Nothing
           ]
    in
        {
             dots = dots
            ,sticks = sticks
        }

makeCloth: Cloth
makeCloth =
    let
        (w, h) = (20,10)
        startx = 100
        starty = 10
        spacing = 7

        cloth = {
            dots =
                Array.initialize (w*h) (\n ->
                    let
                        (x, y) = (remainderBy w n, n // w)
                        coords = (startx + spacing * (toFloat x), starty + spacing * (toFloat y)) |> makeVector2D
                    in
                        if y == h - 1 then
                            makeDotWithVelocity n coords (makeVector2D (10.0, 0.0))
                        else
                            makeDot n coords
                                |> (if y == 0 then (flip pinDot) coords else identity)
                )
            ,sticks = []
            }
    in
        foldr
                (\d acc ->
                    let
                         n = d.id
                         (x, y) = (remainderBy w n, n // w)

                         step1 = if x /= 0 then addStick n (n - 1) acc else acc
                         step2 = if y /= 0 then addStick n (x + (y - 1) * w) step1 else step1
                    in
                         step2)
                cloth
                cloth.dots

updateCloth: Cloth -> Cloth
updateCloth cloth =
    cloth
      |> updateClothSticksHelper physics_iteration
      |> updateClothDots
      |> updateClothSticks

constraintClothDots: Cloth -> Cloth
constraintClothDots cloth =
    { cloth |
        dots = map constraintDot cloth.dots
    }

updateClothDots: Cloth -> Cloth
updateClothDots cloth =
    { cloth |
        dots = map updateDot cloth.dots
    }

updateClothSticks: Cloth -> Cloth
updateClothSticks cloth =
    List.foldl
        (flip updateStick)
        cloth
        cloth.sticks

updateClothSticksHelper: Int -> Cloth -> Cloth
updateClothSticksHelper n cloth =
    if n > 0 then
        (updateClothSticksHelper
            (n - 1)
            (cloth
             |> constraintClothDots
             |> updateClothSticks))
    else
        cloth

getDot: ID -> Cloth -> Dot
getDot id cloth =
    get id cloth.dots |> withDefault (makeDot id (makeVector2D (0.0, 0.0)))

setDot: Dot -> Cloth -> Cloth
setDot p cloth =
    { cloth |
        dots = set p.id p cloth.dots
    }

type MouseButton =
     Left
    |Right

type alias MouseState = {
     pos: Vector2D
    ,oldPos: Vector2D
    ,button: MouseButton
    }

initMouseState: Vector2D -> MouseButton -> MouseState
initMouseState pos button =
    {
         pos = pos
        ,oldPos = pos
        ,button = button
    }

updateMousePos: MouseState -> Vector2D -> MouseState
updateMousePos mouse pos =
    { mouse |
         oldPos = mouse.pos
        ,pos = pos
    }

type alias Model = {
     cloth: Cloth
    ,mouse: Maybe MouseState
    }

init: (Model, Cmd Msg)
init = (
    {
        cloth = makeCloth
       ,mouse = Nothing
    },
    Cmd.none
    )

-- UPDATE

type Msg =
    MouseDown Button Vector2D
  | MouseMove Vector2D
  | MouseUp Vector2D
  | Frame Float

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Frame _ ->
            ({ model | cloth = model.cloth |> updateCloth |> interractCloth model.mouse }, Cmd.none)
        MouseDown b pos ->
            case b of
                MainButton ->
                    ({ model | mouse = Just <| initMouseState pos Left }, Cmd.none)
                SecondButton ->
                    ({ model | mouse = Just <| initMouseState pos Right }, Cmd.none)
                _ ->
                    (model, Cmd.none)
        MouseUp _ ->
            ({ model | mouse = Nothing}, Cmd.none)
        MouseMove pos ->
            case model.mouse of
                Just state ->
                    ({ model | mouse = Just <| updateMousePos state pos }, Cmd.none)
                Nothing ->
                    (model, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    batch [
       onAnimationFrameDelta Frame
    ]

-- VIEW

view : Model -> Html Msg
view model =
  div [ class "container animated flipInX" ]
      [ hr [] []
       ,Markdown.toHtml [class "info"] """
##### Elastic rope
        """
        ,Html.button
                       [  type_ "button"
                        , class ("btn")
                        , Html.onClick (Frame 0.0)
                       ]
                       [
                         text "step"
                       ]
       ,Canvas.toHtml
            (canvas_width, canvas_height)
            [ style "display" "block"
            , Mouse.onDown (\e -> MouseDown e.button (makeVector2D e.offsetPos))
            , Mouse.onMove (.offsetPos >> makeVector2D >> MouseMove)
            , Mouse.onUp (.offsetPos >> makeVector2D >> MouseUp)
            ]
            (List.concat [
                [
                    clear ( 0, 0 ) canvas_width canvas_height
                ]
                ,(model.cloth
                  |> .dots
                  |> map renderDot
                  |> toList)
                ,(model.cloth
                  |> .sticks
                  |> List.map (renderStick model.cloth))
              ])
      ]
