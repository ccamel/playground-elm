module Page.Cloth exposing (..)

import Array exposing (Array, foldr, get, map, set, toList)
import Basics.Extra exposing (flip)
import Canvas exposing (Renderable, Shape, arc, clear, lineTo, path, rect, shapes)
import Canvas.Settings exposing (fill, stroke)
import Canvas.Settings.Line exposing (lineWidth)
import Canvas.Settings.Text exposing (TextAlign(..), align, font)
import Color exposing (Color, rgb255)
import Color.Interpolate as Color exposing (Space(..), interpolate)
import Html exposing (Html, a, br, button, div, hr, p, text)
import Html.Attributes exposing (class, href, style)
import List exposing (length)
import Markdown
import Maybe exposing (withDefault)
import Page.Common exposing (Frames, addFrame, createFrames, fpsText, onClickNotPropagate)
import Browser.Events exposing (onAnimationFrameDelta)
import Platform.Sub
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
canvas_width      = 400
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
makeDot id p = makeDotWithVelocity id p (makeVector2D (0, 0))

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
           ,color = Color.darkGray
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
        velocity = velocityDot dot
    in
        { dot |
             oldPos = dot.pos
            ,pos = dot.pos |> add velocity |> add dot.gravity
        }

velocityDot: Dot -> Vector2D
velocityDot dot =
    let
        vel = sub dot.pos dot.oldPos
              |> (flip mult) (dot.friction)
    in
     if ((dot.pos |> getY) >= ((toFloat canvas_height) - dot.radius))
        && ((magSq vel) > 0.000001) then
        let
            m = mag vel
        in
            divide vel m
              |> (flip mult) (m * dot.groundFriction)
    else
        vel

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
        ,color = Color.darkGray
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
        tension = stick.length / (dist p1.pos p2.pos)
        color =
            if tension > 1.0 then
                0.0
            else 1.0 - tension
    in
        shapes
            [  stroke (palette color)
              ,lineWidth (1 / tension) ]
            [  path (getXY p1.pos) [ lineTo (getXY p2.pos) ]
            ]

makeCloth: Cloth
makeCloth =
    let
        (w, h) = (22,20)
        startx = 40
        starty = 10
        spacing = 15

        cloth = {
            dots =
                Array.initialize (w*h) (\n ->
                    let
                        (x, y) = (remainderBy w n, n // w)
                        coords = (startx + spacing * (toFloat x), starty + spacing * (toFloat y)) |> makeVector2D
                    in
                        if y == h - 1 then
                            makeDotWithVelocity n coords (makeVector2D (5.0, 0.0))
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
    -- if simulation is started or not
    ,started: Bool
    -- a list containing n last frames, used to compute the fps (frame per seconds)
    ,frames : Frames
    }

init: (Model, Cmd Msg)
init = (
    {
        cloth = makeCloth
       ,mouse = Nothing
       ,started = True
       ,frames = createFrames 100 -- initial capacity
    },
    Cmd.none
    )

-- UPDATE

type Msg =
    MouseDown Button Vector2D
  | MouseMove Vector2D
  | MouseUp Vector2D
  | Start
  | Stop
  | Reset
  | Frame Float

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Frame diff ->
            ({ model |
                cloth = model.cloth |> updateCloth |> interractCloth model.mouse
               ,frames = addFrame model.frames diff}
            ,Cmd.none)
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
        Start -> ({ model | started = True },Cmd.none)
        Stop ->  ({ model | started = False },Cmd.none)
        Reset -> init

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    if model.started then
       onAnimationFrameDelta Frame
    else
        Sub.none

-- VIEW

palette = interpolate Color.RGB Color.darkGray Color.lightRed

view : Model -> Html Msg
view model =
  div [ class "container animated flipInX" ]
      [ hr [] []
       ,Markdown.toHtml [class "info"] """
##### Cloth simulated using [Verlet Integration](https://en.wikipedia.org/wiki/Verlet_integration) and rendered through an HTML5 canvas.

Click on the left button of the mouse to interact with the cloth.
        """
       ,br [] []
       ,div [class "row display"]
            [
            --- canvas for the cloth
            Canvas.toHtml
                (canvas_width, canvas_height)
                [ style "display" "block"
                , Mouse.onDown (\e -> MouseDown e.button (makeVector2D e.offsetPos))
                , Mouse.onMove (.offsetPos >> makeVector2D >> MouseMove)
                , Mouse.onUp (.offsetPos >> makeVector2D >> MouseUp)
                ]
                (List.concat [
                    [
                       shapes [ fill (rgb255 242 242 242) ] [ rect ( 0, 0 ) canvas_width canvas_height ]
                    ]
                    ,(model.cloth
                      |> .sticks
                      |> List.map (renderStick model.cloth))
                    ,(model.cloth
                      |> .dots
                      |> map renderDot
                      |> toList)
                    ,[
                      fpsText model.frames
                      |> Canvas.text
                             [ font { size = 10, family = "serif" }
                             , align Center
                             , fill Color.darkBlue
                             ]
                             ( canvas_width - 25, 12 )
                      ]
                  ])
                 , div [class "description col-sm-6"]
                   [
                      p []
                      [
                          text "You can "
                        , case model.started of
                            False -> a [class "action", href "", onClickNotPropagate Start ] [ text "start" ]
                            True  -> a [class "action", href "", onClickNotPropagate Stop ] [ text "stop" ]
                        , text " the simulation. You can also "
                        , a [class "action", href "", onClickNotPropagate (Reset) ] [ text "reset" ]
                        , text " the values to default."
                      ]
                     ]
            ]
      ]
