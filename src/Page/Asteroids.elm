module Page.Asteroids exposing (..)

import Angle exposing (inRadians)
import AngularAcceleration exposing (AngularAcceleration, radiansPerSecondSquared)
import AngularSpeed exposing (AngularSpeed, degreesPerSecond, radiansPerSecond)
import Basics as Math
import Browser.Events exposing (onAnimationFrameDelta)
import Direction2d exposing (Direction2d, rotateBy, toAngle)
import Duration exposing (Duration, Seconds, milliseconds)
import Ecs
import Ecs.Components11
import Ecs.EntityComponents exposing (foldFromRight2)
import Ecs.Singletons4
import GraphicSVG exposing (Shape, blue, brown, group, ident, isosceles, line, move, moveT, outlined, polygon, red, rotate, scaleT, solid, transform)
import GraphicSVG.Widget as Widget
import Html exposing (Html, div, hr, p)
import Html.Attributes as Attributes exposing (class)
import Keyboard exposing (Key(..), KeyChange(..))
import Keyboard.Arrows as Keyboard exposing (Direction(..))
import List exposing (concat, foldl)
import Markdown
import Maybe exposing (withDefault)
import Page.Common exposing (Frames, addFrame, createFrames, fpsText)
import Pixels exposing (Pixels, PixelsPerSecond, PixelsPerSecondSquared, inPixels, pixels, pixelsPerSecond, pixelsPerSecondSquared)
import Point2d exposing (Point2d, translateBy, xCoordinate, yCoordinate)
import Quantity exposing (Product, Quantity, Rate, lessThanOrEqualToZero, plus, zero)
import Random exposing (Generator, Seed)
import Task
import Time
import Tuple exposing (first)
import Vector2d exposing (Vector2d, scaleTo)



-- PAGE INFO


info : Page.Common.PageInfo Msg
info =
    { name = "asteroids"
    , hash = "asteroids"
    , description = Markdown.toHtml [ class "info" ] """

A simple Asteroids clone in [Elm](https://elm-lang.org/).
       """
    , srcRel = "Page/Asteroids.elm"
    }



-- ENTITY


type alias EntityId =
    Int



-- UNITS


type CanvasCoordinates
    = CanvasCoordinates



-- COMPONENTS


type alias Position =
    Point2d Pixels CanvasCoordinates


type alias PositionVelocity =
    Vector2d PixelsPerSecond CanvasCoordinates


type alias RotationVelocity =
    AngularSpeed


type alias Orientation =
    Direction2d CanvasCoordinates


type alias Sprite =
    Shape Msg


type alias ThrustCommand =
    Quantity Float PixelsPerSecondSquared


type alias SideThrustCommand =
    AngularAcceleration


type alias VelocityFriction =
    Quantity Float PixelsPerSecondSquared


type alias AngularFriction =
    AngularAcceleration


type FireCommand
    = FireCommand


type alias Ttl =
    { durationTime : Duration
    , remainingTime : Duration
    }


newTtl : Duration -> Ttl
newTtl durationTime =
    { durationTime = zero, remainingTime = durationTime }


type alias Components =
    Ecs.Components11.Components11
        EntityId
        Position
        PositionVelocity
        Orientation
        RotationVelocity
        Sprite
        ThrustCommand
        SideThrustCommand
        FireCommand
        VelocityFriction
        AngularFriction
        Ttl



-- SINGLETONS


type alias Singletons =
    Ecs.Singletons4.Singletons4 Frame EntityId Keys Random.Seed


type alias Frame =
    { deltaTime : Duration
    , totalTime : Duration
    }


type alias Keys =
    ( List Key, Maybe KeyChange )


type alias Specs =
    { all : AllComponentsSpec
    , position : ComponentSpec Position
    , positionVelocity : ComponentSpec PositionVelocity
    , orientation : ComponentSpec Orientation
    , rotationVelocity : ComponentSpec RotationVelocity
    , sprite : ComponentSpec Sprite
    , thrustCommand : ComponentSpec ThrustCommand
    , sideThrustCommand : ComponentSpec SideThrustCommand
    , fireCommand : ComponentSpec FireCommand
    , velocityFriction : ComponentSpec VelocityFriction
    , angularFriction : ComponentSpec AngularFriction
    , ttl : ComponentSpec Ttl
    , frame : SingletonSpec Frame
    , nextEntityId : SingletonSpec EntityId
    , keys : SingletonSpec Keys
    , randomSeed : SingletonSpec Random.Seed
    }


type alias AllComponentsSpec =
    Ecs.AllComponentsSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


type alias SingletonSpec a =
    Ecs.SingletonSpec a Singletons


specs : Specs
specs =
    Specs |> Ecs.Components11.specs |> Ecs.Singletons4.specs



-- SYSTEMS


systems : Duration -> ( List Key, Maybe KeyChange ) -> List (World -> World)
systems delta keys =
    [ frameSystem delta
    , ttlSystem
    , keyboardInputSystem keys
    , controlCommandSystem
    , firingCommandSystem
    , forwardThrustSystem
    , sideThrustSystem
    , firingSystem
    , positionVelocitySystem
    , rotationVelocitySystem
    , velocityFrictionSystem
    , angularFrictionSystem
    , worldBoundsSystem
    ]


theSystem : Duration -> ( List Key, Maybe KeyChange ) -> World -> World
theSystem delta keys =
    foldl (>>) identity (systems delta keys)


keyboardInputSystem : ( List Key, Maybe KeyChange ) -> World -> World
keyboardInputSystem keys world =
    Ecs.setSingleton specs.keys
        keys
        world


controlCommandSystem : World -> World
controlCommandSystem world =
    let
        keys =
            Ecs.getSingleton specs.keys world |> Tuple.first |> Keyboard.arrowsDirection
    in
    world
        |> Ecs.onEntity shipEntityId
        |> (case keys of
                North ->
                    Ecs.insertComponent specs.thrustCommand (pixelsPerSecondSquared 100.0)

                NorthEast ->
                    Ecs.insertComponent specs.thrustCommand (pixelsPerSecondSquared 100.0) >> Ecs.insertComponent specs.sideThrustCommand (radiansPerSecondSquared -5.0)

                East ->
                    Ecs.insertComponent specs.sideThrustCommand (radiansPerSecondSquared -5.0)

                SouthEast ->
                    Ecs.insertComponent specs.sideThrustCommand (radiansPerSecondSquared -5.0)

                SouthWest ->
                    Ecs.insertComponent specs.sideThrustCommand (radiansPerSecondSquared 5.0)

                West ->
                    Ecs.insertComponent specs.sideThrustCommand (radiansPerSecondSquared 5.0)

                NorthWest ->
                    Ecs.insertComponent specs.thrustCommand (pixelsPerSecondSquared 100.0) >> Ecs.insertComponent specs.sideThrustCommand (radiansPerSecondSquared 5.0)

                _ ->
                    Ecs.removeComponent specs.thrustCommand >> Ecs.removeComponent specs.sideThrustCommand
           )


firingCommandSystem : World -> World
firingCommandSystem world =
    let
        ( keys, maybeKeyChange ) =
            Ecs.getSingleton specs.keys world
    in
    world
        |> Ecs.onEntity shipEntityId
        |> (case maybeKeyChange of
                Just (KeyDown Spacebar) ->
                    Ecs.insertComponent specs.fireCommand FireCommand >> Ecs.setSingleton specs.keys ( keys, Nothing )

                _ ->
                    Ecs.removeComponent specs.fireCommand
           )


frameSystem : Duration -> World -> World
frameSystem delta world =
    Ecs.updateSingleton specs.frame
        (\frame ->
            { totalTime = frame.totalTime |> plus delta
            , deltaTime = delta
            }
        )
        world


forwardThrustSystem : World -> World
forwardThrustSystem world =
    let
        dt =
            deltaTime world
    in
    Ecs.EntityComponents.processFromLeft3
        specs.thrustCommand
        specs.positionVelocity
        specs.orientation
        (\_ thrust pv o w ->
            Ecs.insertComponent specs.positionVelocity
                (pv
                    |> Vector2d.plus (Vector2d.withLength thrust o |> Vector2d.for dt)
                    |> vectorLimit constants.speedLimit
                )
                w
        )
        world


sideThrustSystem : World -> World
sideThrustSystem world =
    let
        dt =
            deltaTime world
    in
    Ecs.EntityComponents.processFromLeft2
        specs.sideThrustCommand
        specs.rotationVelocity
        (\_ thrust rv w ->
            Ecs.insertComponent specs.rotationVelocity
                (rv
                    |> Quantity.plus (thrust |> Quantity.for dt)
                    |> quantityRange ( Quantity.negate constants.angularSpeedLimit, constants.angularSpeedLimit )
                )
                w
        )
        world


firingSystem : World -> World
firingSystem world =
    Ecs.EntityComponents.processFromLeft3
        specs.fireCommand
        specs.orientation
        specs.position
        (\_ _ o p ->
            spawnBulletEntity o p >> Ecs.removeComponent specs.fireCommand
        )
        world


rotationVelocitySystem : World -> World
rotationVelocitySystem world =
    let
        dt =
            deltaTime world
    in
    Ecs.EntityComponents.processFromLeft
        specs.rotationVelocity
        (\_ rv w ->
            w
                |> Ecs.updateComponent
                    specs.orientation
                    (Maybe.map <| rotateBy (rv |> Quantity.for dt))
        )
        world


positionVelocitySystem : World -> World
positionVelocitySystem world =
    let
        dt =
            deltaTime world
    in
    Ecs.EntityComponents.processFromLeft
        specs.positionVelocity
        (\_ velocity w ->
            w
                |> Ecs.updateComponent
                    specs.position
                    (Maybe.map <| translateBy (velocity |> Vector2d.for dt))
        )
        world


velocityFrictionSystem : World -> World
velocityFrictionSystem world =
    let
        dt =
            deltaTime world

        app vf v =
            let
                f =
                    v
                        |> scaleTo vf
                        |> Vector2d.for dt
                        |> Vector2d.reverse
            in
            if Vector2d.length f |> Quantity.greaterThan (Vector2d.length v) then
                Vector2d.zero

            else
                v |> Vector2d.plus f
    in
    Ecs.EntityComponents.processFromLeft
        specs.velocityFriction
        (\_ vf w ->
            w
                |> Ecs.updateComponent
                    specs.positionVelocity
                    (Maybe.map (app vf))
        )
        world


angularFrictionSystem : World -> World
angularFrictionSystem world =
    let
        dt =
            deltaTime world

        app af v =
            let
                f =
                    af |> Quantity.for dt

                v2 =
                    if f |> Quantity.greaterThan (Quantity.abs v) then
                        zero

                    else if v |> Quantity.greaterThanOrEqualToZero then
                        v |> Quantity.minus f

                    else
                        v |> Quantity.plus f
            in
            v2 |> quantityRangeAbs constants.angularSpeedLimit
    in
    Ecs.EntityComponents.processFromLeft
        specs.angularFriction
        (\_ vf w ->
            w
                |> Ecs.updateComponent
                    specs.rotationVelocity
                    (Maybe.map (app vf))
        )
        world


worldBoundsSystem : World -> World
worldBoundsSystem world =
    Ecs.EntityComponents.processFromLeft
        specs.positionVelocity
        (\_ _ w ->
            w
                |> Ecs.updateComponent
                    specs.position
                    (Maybe.map <|
                        \p ->
                            let
                                x =
                                    xCoordinate p |> quantityRangeMod ( zero, constants.width )

                                y =
                                    yCoordinate p |> quantityRangeMod ( zero, constants.height )
                            in
                            Point2d.xy x y
                    )
        )
        world


ttlSystem : World -> World
ttlSystem world =
    let
        dt =
            deltaTime world
    in
    world
        |> Ecs.EntityComponents.processFromLeft
            specs.ttl
            (\_ ttl w ->
                Ecs.insertComponent specs.ttl
                    { ttl
                        | durationTime = ttl.durationTime |> Quantity.plus dt
                        , remainingTime = ttl.remainingTime |> Quantity.minus dt
                    }
                    w
            )
        |> Ecs.EntityComponents.processFromLeft
            specs.ttl
            (\_ { remainingTime } w ->
                if remainingTime |> lessThanOrEqualToZero then
                    Ecs.removeEntity specs.all w

                else
                    w
            )



-- MODEL


type alias World =
    Ecs.World EntityId Components Singletons


type alias Model =
    { world : Maybe World
    , playground : Widget.Model
    , keys : ( List Key, Maybe KeyChange )

    -- a list containing n last frames, used to compute the fps (frame per seconds)
    , frames : Frames
    }



-- INIT


constants : { width : Quantity Float Pixels, height : Quantity Float Pixels, speedLimit : Quantity Float PixelsPerSecond, angularSpeedLimit : AngularSpeed }
constants =
    { -- width of the canvas
      width = 320.0 |> pixels

    -- height of the canvas
    , height = 240.0 |> pixels
    , speedLimit = 90.0 |> pixelsPerSecond
    , angularSpeedLimit = 100.0 |> degreesPerSecond
    }


center : Point2d Pixels coordinates
center =
    Point2d.xy (constants.width |> Quantity.half) (constants.height |> Quantity.half)


init : ( Model, Cmd Msg )
init =
    let
        ( playgroundModel, playgroundCmd ) =
            Widget.init (inPixels constants.width) (inPixels constants.height) "asteroids-game"
    in
    ( { world = Nothing
      , playground = playgroundModel
      , keys = ( [], Nothing )
      , frames = createFrames 10 -- initial capacity
      }
    , Cmd.batch
        [ Cmd.map PlaygroundMessage playgroundCmd
        , Task.perform GotTime Time.now
        ]
    )


initWorld : Time.Posix -> World
initWorld time =
    Ecs.emptyWorld specs.all (initSingletons <| Time.posixToMillis time)


initSingletons : Int -> Singletons
initSingletons seed =
    Ecs.Singletons4.init
        { deltaTime = Quantity.zero
        , totalTime = Quantity.zero
        }
        1
        ( [], Nothing )
        (Random.initialSeed seed)


initEntities : World -> World
initEntities world =
    let
        x =
            10.0 |> pixels

        y =
            10.0 |> pixels

        w =
            constants.width |> Quantity.minus x

        h =
            constants.height |> Quantity.minus y
    in
    world
        |> spawnShipEntity
        |> spawnAsteroidEntity (Point2d.xy x y)
        |> spawnAsteroidEntity (Point2d.xy x h)
        |> spawnAsteroidEntity (Point2d.xy w y)
        |> spawnAsteroidEntity (Point2d.xy w h)


newEntity : World -> World
newEntity world =
    world
        |> Ecs.insertEntity (Ecs.getSingleton specs.nextEntityId world)
        |> Ecs.updateSingleton specs.nextEntityId (\id -> id + 1)


shipEntityId : Int
shipEntityId =
    0


spawnShipEntity : World -> World
spawnShipEntity world =
    world
        |> Ecs.insertEntity shipEntityId
        |> Ecs.insertComponent specs.position center
        |> Ecs.insertComponent specs.orientation Direction2d.positiveY
        |> Ecs.insertComponent specs.rotationVelocity Quantity.zero
        |> Ecs.insertComponent specs.positionVelocity Vector2d.zero
        |> Ecs.insertComponent specs.velocityFriction (pixelsPerSecondSquared 10.0)
        |> Ecs.insertComponent specs.angularFriction (AngularAcceleration.degreesPerSecondSquared 20.0)
        |> Ecs.insertComponent specs.sprite shipSprite


shipSprite : Sprite
shipSprite =
    isosceles 5 8
        |> outlined (solid 0.5) blue


spawnBulletEntity : Orientation -> Position -> World -> World
spawnBulletEntity orientation position world =
    world
        |> newEntity
        |> Ecs.insertComponent specs.position position
        |> Ecs.insertComponent specs.orientation orientation
        |> Ecs.insertComponent specs.positionVelocity
            (orientation |> Direction2d.toVector |> Vector2d.scaleTo (pixelsPerSecond 150.0))
        |> Ecs.insertComponent specs.ttl (5 |> Duration.seconds |> newTtl)
        |> Ecs.insertComponent specs.sprite bulletSprite


bulletSprite : Sprite
bulletSprite =
    line ( 0, 0 ) ( -0.7, 0 ) |> outlined (solid 5) red


spawnAsteroidEntity : Position -> World -> World
spawnAsteroidEntity position world =
    let
        mapper positionVelocity orientation rotationVelocity ( minSize, width ) =
            { positionVelocity = positionVelocity
            , orientation = orientation
            , rotationVelocity = rotationVelocity
            , minRadius = minSize
            , maxRadius = minSize + width
            , granularity = width
            }

        ( w, randoms ) =
            randomStep
                (Random.map4 mapper
                    asteroidsPositionVelocityGenerator
                    asteroidsOrientationGenerator
                    asteroidsRotationVelocityGenerator
                    asteroidsSizeGenerator
                )
                world
    in
    w
        |> newEntity
        |> Ecs.insertComponent specs.position position
        |> Ecs.insertComponent specs.positionVelocity randoms.positionVelocity
        |> Ecs.insertComponent specs.orientation randoms.orientation
        |> Ecs.insertComponent specs.rotationVelocity randoms.rotationVelocity
        |> asteroidSprite randoms.minRadius randoms.maxRadius randoms.granularity
        |> uncurry3 (Ecs.insertComponent specs.sprite)


asteroidSprite : Float -> Float -> Float -> World -> ( Sprite, World )
asteroidSprite minRadius maxRadius granularity world =
    let
        seed =
            Ecs.getSingleton specs.randomSeed world

        ( seed2, shape ) =
            randomPolyline seed minRadius maxRadius granularity
    in
    ( shape
        |> polygon
        |> outlined (solid 0.5) brown
    , world |> Ecs.setSingleton specs.randomSeed seed2
    )



-- UPDATE


type Msg
    = GotAnimationFrameDeltaMilliseconds Float
    | GotTime Time.Posix
    | PlaygroundMessage Widget.Msg
    | KeyboardMsg Keyboard.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ world, keys } as model) =
    case ( msg, world ) of
        ( GotTime time, Nothing ) ->
            ( { model
                | world =
                    initWorld time
                        |> initEntities
                        |> Just
              }
            , Cmd.none
            )

        ( GotAnimationFrameDeltaMilliseconds delta, Just w ) ->
            ( { model
                | world = Just <| updateWorld (delta |> milliseconds) model.keys w
                , frames = addFrame model.frames delta
                , keys = ( first model.keys, Nothing )
              }
            , Cmd.none
            )

        ( PlaygroundMessage svgMsg, _ ) ->
            let
                ( playgroundModel, playgroundCmd ) =
                    Widget.update svgMsg model.playground
            in
            ( { model | playground = playgroundModel }, Cmd.map PlaygroundMessage playgroundCmd )

        ( KeyboardMsg keyMsg, _ ) ->
            ( { model
                | keys = Keyboard.updateWithKeyChange Keyboard.anyKeyUpper keyMsg (first model.keys)
                , world = world
              }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )


updateWorld : Duration -> ( List Key, Maybe KeyChange ) -> World -> World
updateWorld delta keys world =
    theSystem delta keys world



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ onAnimationFrameDelta GotAnimationFrameDeltaMilliseconds
        , Sub.map PlaygroundMessage Widget.subscriptions
        , Sub.map KeyboardMsg Keyboard.subscriptions
        ]



-- VIEW


view : Model -> Html Msg
view { world, playground, frames } =
    div [ class "container" ]
        (concat
            [ [ hr [] []
              , p [ class "text-muted" ]
                    [ Markdown.toHtml [ class "info" ] """
  Simple Asteroids clone in [Elm](https://elm-lang.org/) .
  """
                    ]
              ]
            , case world of
                Just w ->
                    [ div [ class "asteroids" ]
                        [ div
                            [ Attributes.style "font-family" "monospace"
                            ]
                            [ Html.text ("entities: " ++ (Ecs.worldEntityCount w |> String.fromInt))
                            , Html.text " - "
                            , Html.text ("components: " ++ (Ecs.worldComponentCount specs.all w |> String.fromInt))
                            , Html.text " - "
                            , Html.text <| fpsText frames
                            ]
                        , div [ class "world" ]
                            [ Widget.view
                                playground
                                [ renderWorld w ]
                            ]
                        ]
                    ]

                _ ->
                    []
            ]
        )


renderWorld : World -> Shape Msg
renderWorld world =
    let
        spriteCollector entityId sprite position acc =
            let
                maybeRotate =
                    world
                        |> Ecs.onEntity entityId
                        |> Ecs.getComponent specs.orientation
                        |> Maybe.map (rotate << (+) (-pi / 2) << inRadians << toAngle)
            in
            (sprite
                |> withDefault identity maybeRotate
                |> move (position |> Point2d.toTuple inPixels)
            )
                :: acc
    in
    foldFromRight2
        specs.sprite
        specs.position
        spriteCollector
        []
        world
        |> group
        |> move (Vector2d.from center Point2d.origin |> Vector2d.toTuple inPixels)



-- CONVENIENT FUNS


tau : Float
tau =
    2 * Math.pi


deltaTime : World -> Duration
deltaTime world =
    Ecs.getSingleton specs.frame world |> .deltaTime


randomStep : Random.Generator a -> World -> ( World, a )
randomStep generator world =
    let
        seed =
            Ecs.getSingleton specs.randomSeed world

        ( r, seed2 ) =
            Random.step generator seed
    in
    ( Ecs.setSingleton specs.randomSeed seed2 world, r )


asteroidsPositionVelocityGenerator : Random.Generator PositionVelocity
asteroidsPositionVelocityGenerator =
    let
        vectorPixelsPerSeconds x y =
            Vector2d.xy (x |> pixelsPerSecond) (y |> pixelsPerSecond)
    in
    Random.map2 vectorPixelsPerSeconds
        (Random.float -20 20)
        (Random.float -20 20)


asteroidsRotationVelocityGenerator : Random.Generator RotationVelocity
asteroidsRotationVelocityGenerator =
    Random.map
        degreesPerSecond
        (Random.float -20 20)


asteroidsOrientationGenerator : Random.Generator Orientation
asteroidsOrientationGenerator =
    Random.map
        Direction2d.degrees
        (Random.float 0 360)


asteroidsSizeGenerator : Random.Generator ( Float, Float )
asteroidsSizeGenerator =
    Random.map2 Tuple.pair
        (Random.float 5 10)
        (Random.float 4 10)


randomPolyline : Seed -> Float -> Float -> Float -> ( Seed, List ( Float, Float ) )
randomPolyline seed minRadius maxRadius granularity =
    let
        increment =
            tau / granularity

        rnd =
            Random.float minRadius maxRadius

        randomPolylineRec seed2 ang points =
            if ang < tau then
                let
                    ( radius, seed3 ) =
                        Random.step rnd seed2

                    p =
                        ( cos ang, sin ang ) |> vMult radius
                in
                randomPolylineRec seed3 (ang + increment) (p :: points)

            else
                ( seed2, points )
    in
    randomPolylineRec seed 0 []



-- HELPERS


uncurry3 : (a -> b -> c) -> ( a, b ) -> c
uncurry3 f ( a, b ) =
    f a b


vectorLimit : Quantity Float units -> Vector2d units coordinates -> Vector2d units coordinates
vectorLimit limit v =
    if Vector2d.length v |> Quantity.greaterThan limit then
        scaleTo limit v

    else
        v


quantityRange : ( Quantity number units, Quantity number units ) -> Quantity number units -> Quantity number units
quantityRange ( minv, maxv ) v =
    v
        |> Quantity.min maxv
        |> Quantity.max minv


quantityRangeAbs : Quantity number units -> Quantity number units -> Quantity number units
quantityRangeAbs l v =
    let
        labs =
            Quantity.abs l
    in
    quantityRange ( labs |> Quantity.negate, labs ) v


quantityRangeMod : ( Quantity number units, Quantity number units ) -> Quantity number units -> Quantity number units
quantityRangeMod (( minv, maxv ) as limit) v =
    let
        range =
            maxv |> Quantity.minus minv
    in
    if v |> Quantity.lessThan minv then
        quantityRangeMod limit (v |> Quantity.plus range)

    else if v |> Quantity.greaterThan maxv then
        quantityRangeMod limit (v |> Quantity.minus range)

    else
        v


vApply : (Float -> Float) -> ( Float, Float ) -> ( Float, Float )
vApply f ( a, b ) =
    ( f a, f b )


vMult : Float -> ( Float, Float ) -> ( Float, Float )
vMult by =
    vApply <| (*) by
