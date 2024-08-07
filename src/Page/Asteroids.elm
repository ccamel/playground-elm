module Page.Asteroids exposing (Model, Msg, info, init, subscriptions, update, view)

import Angle exposing (inDegrees)
import AngularAcceleration exposing (AngularAcceleration, radiansPerSecondSquared)
import AngularSpeed exposing (AngularSpeed, degreesPerSecond)
import Basics as Math
import Basics.Extra exposing (swap, uncurry)
import BoundingBox2d exposing (minX, minY)
import Browser.Events exposing (onAnimationFrameDelta)
import Conditional.List exposing (addWhen)
import Direction2d exposing (Direction2d, rotateBy, toAngle)
import Duration exposing (Duration, milliseconds)
import Ecs
import Ecs.Components16
import Ecs.EntityComponents exposing (foldFromLeft2)
import Ecs.Singletons6
import Html exposing (Html, div, p, section, text)
import Html.Attributes as Attributes
import Html.Extra exposing (viewMaybe)
import Keyboard exposing (Key(..), KeyChange(..))
import Keyboard.Arrows as Keyboard exposing (Direction(..))
import Lib.Frame exposing (Frames, addFrame, createFrames, fps)
import Lib.Page
import List exposing (foldl, length, singleton)
import List.Extra exposing (uniquePairs)
import Markdown
import Maybe exposing (withDefault)
import Particle exposing (directionDegrees, leftPixels, topPixels)
import Pixels exposing (Pixels, PixelsPerSecond, PixelsPerSecondSquared, inPixels, pixels, pixelsPerSecond, pixelsPerSecondSquared)
import Point2d exposing (Point2d, translateBy, xCoordinate, yCoordinate)
import Polygon2d exposing (Polygon2d, singleLoop)
import Quantity exposing (Quantity, lessThanOrEqualTo, plus, zero)
import Random exposing (Generator, Seed)
import Random.Float exposing (normal)
import Rectangle2d
import String exposing (fromFloat, fromInt, join, padLeft)
import Svg exposing (Svg, g, line, polygon, rect, svg)
import Svg.Attributes exposing (class, cx, cy, d, fill, fillRule, height, id, opacity, points, rx, ry, stroke, strokeLinecap, strokeWidth, style, transform, version, viewBox, width, x, x1, x2, y, y1, y2)
import Task
import Time
import Tuple exposing (first)
import Vector2d exposing (Vector2d, scaleTo)



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "asteroids"
    , hash = "asteroids"
    , date = "2021-01-12"
    , description = Markdown.toHtml [ Attributes.class "content" ] """

A simple Asteroids clone in [Elm](https://elm-lang.org/) using the [ECS](https://en.wikipedia.org/wiki/Entity_component_system) pattern and [SVG](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics) for rendering.
       """
    , srcRel = "Page/Asteroids.elm"
    }



-- ENTITY


type alias EntityId =
    Int



-- UNITS


type alias CanvasCoordinates =
    ()



-- COMPONENTS


type alias Position =
    Point2d Pixels CanvasCoordinates


type alias PositionVelocity =
    Vector2d PixelsPerSecond CanvasCoordinates


type alias RotationVelocity =
    AngularSpeed


type alias Orientation =
    Direction2d CanvasCoordinates


type Render
    = SpriteView (List (Svg Msg))
    | EntityView (World -> List (Svg Msg))


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


type alias Age =
    { duration : Duration
    }


type alias Ttl =
    { remaining : Duration
    }


type alias Shape =
    Polygon2d Pixels CanvasCoordinates


type Class
    = Ship
    | Asteroid
    | Bullet


type alias Health =
    Int


type alias Particle =
    Particle.Particle ()


type alias Components =
    Ecs.Components16.Components16
        EntityId
        Position
        PositionVelocity
        Orientation
        RotationVelocity
        Render
        ThrustCommand
        SideThrustCommand
        FireCommand
        VelocityFriction
        AngularFriction
        Age
        Ttl
        Shape
        Class
        Health
        Particle



-- SINGLETONS


type alias Singletons =
    Ecs.Singletons6.Singletons6 Frame EntityId Keys Seed Collisions Parameters


type alias Frame =
    { deltaTime : Duration
    , totalTime : Duration
    }


type alias Keys =
    ( List Key, Maybe KeyChange )


type alias Seed =
    Random.Seed


type alias CollidingEntity =
    { entityId : EntityId
    , position : Position
    , orientation : Orientation
    , shape : Shape
    , class : Class
    , health : Maybe Health
    }


type alias Collisions =
    List ( CollidingEntity, CollidingEntity )


type alias Parameters =
    { showBoundingBox : Bool
    }


type alias Specs =
    { all : AllComponentsSpec
    , position : ComponentSpec Position
    , positionVelocity : ComponentSpec PositionVelocity
    , orientation : ComponentSpec Orientation
    , rotationVelocity : ComponentSpec RotationVelocity
    , render : ComponentSpec Render
    , thrustCommand : ComponentSpec ThrustCommand
    , sideThrustCommand : ComponentSpec SideThrustCommand
    , fireCommand : ComponentSpec FireCommand
    , velocityFriction : ComponentSpec VelocityFriction
    , angularFriction : ComponentSpec AngularFriction
    , age : ComponentSpec Age
    , ttl : ComponentSpec Ttl
    , shape : ComponentSpec Shape
    , class : ComponentSpec Class
    , health : ComponentSpec Health
    , particle : ComponentSpec Particle
    , frame : SingletonSpec Frame
    , nextEntityId : SingletonSpec EntityId
    , keys : SingletonSpec Keys
    , randomSeed : SingletonSpec Seed
    , collisions : SingletonSpec Collisions
    , parameters : SingletonSpec Parameters
    }


type alias AllComponentsSpec =
    Ecs.AllComponentsSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


type alias SingletonSpec a =
    Ecs.SingletonSpec a Singletons


specs : Specs
specs =
    Specs |> Ecs.Components16.specs |> Ecs.Singletons6.specs



-- SYSTEMS


systems : Duration -> ( List Key, Maybe KeyChange ) -> List (World -> World)
systems delta keys =
    [ frameSystem delta
    , ageSystem
    , ttlSystem
    , keyboardInputSystem keys
    , controlCommandSystem
    , firingCommandSystem
    , optionsCommandSystem
    , forwardThrustSystem
    , sideThrustSystem
    , firingSystem
    , positionVelocitySystem
    , rotationVelocitySystem
    , velocityFrictionSystem
    , angularFrictionSystem
    , worldBoundsSystem
    , collisionDetectionSystem
    , healthSystem
    , bulletAsteroidCollisionSystem
    , particleSystem
    ]


theSystem : Duration -> ( List Key, Maybe KeyChange ) -> World -> World
theSystem delta keys =
    foldl (>>) identity (systems delta keys)


frameSystem : Duration -> World -> World
frameSystem delta world =
    Ecs.updateSingleton specs.frame
        (\frame ->
            { totalTime = frame.totalTime |> plus delta
            , deltaTime = delta
            }
        )
        world


ageSystem : World -> World
ageSystem world =
    let
        dt =
            deltaTime world
    in
    Ecs.EntityComponents.processFromLeft
        specs.age
        (\_ age ->
            Ecs.insertComponent specs.age
                { age
                    | duration = age.duration |> Quantity.plus dt
                }
        )
        world


ttlSystem : World -> World
ttlSystem world =
    let
        dt =
            deltaTime world
    in
    Ecs.EntityComponents.processFromLeft
        specs.ttl
        (\_ ttl ->
            if ttl.remaining |> lessThanOrEqualTo dt then
                Ecs.removeEntity specs.all

            else
                Ecs.insertComponent specs.ttl
                    { ttl
                        | remaining = ttl.remaining |> Quantity.minus dt
                    }
        )
        world


healthSystem : World -> World
healthSystem world =
    Ecs.EntityComponents.processFromLeft
        specs.health
        (\_ health ->
            if health == 0 then
                Ecs.removeEntity specs.all

            else
                identity
        )
        world


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


optionsCommandSystem : World -> World
optionsCommandSystem world =
    let
        ( keys, maybeKeyChange ) =
            Ecs.getSingleton specs.keys world
    in
    world
        |> (case maybeKeyChange of
                Just (KeyDown (Character "S")) ->
                    let
                        parameters =
                            Ecs.getSingleton specs.parameters world
                    in
                    Ecs.setSingleton specs.parameters { parameters | showBoundingBox = not <| .showBoundingBox parameters } >> Ecs.setSingleton specs.keys ( keys, Nothing )

                _ ->
                    identity
           )


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
        (\_ thrust pv o ->
            Ecs.insertComponent specs.positionVelocity
                (pv
                    |> Vector2d.plus (Vector2d.withLength thrust o |> Vector2d.for dt)
                    |> vectorLimit constants.speedLimit
                )
                >> Ecs.insertComponent specs.health 10
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
        (\_ thrust rv ->
            Ecs.insertComponent specs.rotationVelocity
                (rv
                    |> Quantity.plus (thrust |> Quantity.for dt)
                    |> quantityRange ( Quantity.negate constants.angularSpeedLimit, constants.angularSpeedLimit )
                )
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
        (\_ rv ->
            Ecs.updateComponent
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
        (\_ velocity ->
            Ecs.updateComponent
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
        (\_ vf ->
            Ecs.updateComponent
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
        (\_ vf ->
            Ecs.updateComponent
                specs.rotationVelocity
                (Maybe.map (app vf))
        )
        world


worldBoundsSystem : World -> World
worldBoundsSystem =
    Ecs.EntityComponents.processFromLeft
        specs.positionVelocity
        (\_ _ ->
            Ecs.updateComponent
                specs.position
                (Maybe.map <|
                    \p ->
                        Point2d.xy
                            (xCoordinate p |> quantityRangeMod ( zero, constants.width ))
                            (yCoordinate p |> quantityRangeMod ( zero, constants.height ))
                )
        )


collisionDetectionSystem : World -> World
collisionDetectionSystem world =
    let
        targets w =
            Ecs.EntityComponents.foldFromLeft4
                specs.position
                specs.orientation
                specs.shape
                specs.class
                (\entityId position orientation shape class ->
                    (::)
                        (CollidingEntity
                            entityId
                            position
                            orientation
                            (shape
                                |> Polygon2d.rotateAround Point2d.origin (orientation |> toAngle)
                                |> Polygon2d.translateBy (Vector2d.from Point2d.origin position)
                            )
                            class
                            (w |> Ecs.onEntity entityId |> Ecs.getComponent specs.health)
                        )
                )
                []
                w

        isColliding ( a, b ) =
            (a.entityId /= b.entityId)
                && (( a.shape, b.shape )
                        |> vApply Polygon2d.boundingBox
                        |> (\shapes ->
                                case shapes of
                                    ( Just shapeA, Just shapeB ) ->
                                        shapeA |> BoundingBox2d.intersects shapeB

                                    _ ->
                                        False
                           )
                   )
    in
    Ecs.setSingleton
        specs.collisions
        (targets world
            |> uniquePairs
            |> List.filter isColliding
        )
        world


isCollidingClasses : ( Class, Class ) -> { a | class : Class } -> { a | class : Class } -> Bool
isCollidingClasses c a b =
    ( a.class, b.class ) == c || ( a.class, b.class ) == swap c


orderCollidingClassesWith : ({ a | class : Class } -> { a | class : Class } -> Order) -> ( { a | class : Class }, { a | class : Class } ) -> ( { a | class : Class }, { a | class : Class } )
orderCollidingClassesWith comparator (( a, b ) as e) =
    case comparator a b of
        GT ->
            swap e

        _ ->
            e


firstClassComparator : Class -> ({ a | class : Class } -> { a | class : Class } -> Order)
firstClassComparator c c1 c2 =
    if c == c1.class then
        LT

    else if c == c2.class then
        GT

    else
        EQ


bulletAsteroidCollisionSystem : World -> World
bulletAsteroidCollisionSystem world =
    let
        targets =
            ( Bullet, Asteroid )
    in
    Ecs.getSingleton specs.collisions world
        |> List.filter (uncurry <| isCollidingClasses targets)
        |> List.map (orderCollidingClassesWith <| firstClassComparator Bullet)
        |> List.foldl
            (\( bullet, asteroid ) ->
                let
                    maybeSize : Maybe.Maybe AsteroidType
                    maybeSize =
                        (case asteroid.health of
                            Just 0 ->
                                Nothing

                            Just 1 ->
                                Just TINY

                            Just 2 ->
                                Just SMALL

                            Just 3 ->
                                Just MEDIUM

                            _ ->
                                Just BIG
                        )
                            |> Maybe.andThen downSizeAsteroidType
                in
                Ecs.onEntity bullet.entityId
                    >> Ecs.removeEntity specs.all
                    >> Ecs.onEntity asteroid.entityId
                    >> Ecs.removeEntity specs.all
                    >> spawnExplosion asteroid.position
                    >> (case maybeSize of
                            Just size ->
                                spawnAsteroidEntity size asteroid.position
                                    >> spawnAsteroidEntity size asteroid.position

                            _ ->
                                identity
                       )
            )
            world


particleSystem : World -> World
particleSystem world =
    let
        dtms =
            deltaTime world |> Duration.inMilliseconds
    in
    Ecs.EntityComponents.processFromLeft
        specs.particle
        (\_ particle ->
            case Particle.update dtms particle of
                Just particle2 ->
                    Ecs.insertComponent specs.particle particle2
                        >> Ecs.insertComponent specs.position
                            (Point2d.xy (particle2 |> leftPixels |> pixels) (particle2 |> topPixels |> pixels))
                        >> Ecs.insertComponent specs.orientation
                            (particle2 |> directionDegrees |> Direction2d.degrees)

                Nothing ->
                    -- should be managed by the ttl system, but if not, remove the entity particle ourselves
                    Ecs.removeEntity specs.all
        )
        world



-- MODEL


type alias World =
    Ecs.World EntityId Components Singletons


type alias ModelRecord =
    { world : Maybe World
    , keys : ( List Key, Maybe KeyChange )

    -- a list containing n last frames, used to compute the fps (frame per seconds)
    , frames : Frames
    }


type Model
    = Model ModelRecord



-- INIT


constants : { width : Quantity Float Pixels, height : Quantity Float Pixels, speedLimit : Quantity Float PixelsPerSecond, angularSpeedLimit : AngularSpeed }
constants =
    { -- width of the canvas
      width = 320.0 |> pixels

    -- height of the canvas
    , height = 240.0 |> pixels

    -- maximum speed
    , speedLimit = 90.0 |> pixelsPerSecond

    -- maximum angular speed
    , angularSpeedLimit = 100.0 |> degreesPerSecond
    }


center : Point2d Pixels coordinates
center =
    Point2d.xy (constants.width |> Quantity.half) (constants.height |> Quantity.half)


init : ( Model, Cmd Msg )
init =
    ( Model
        { world = Nothing
        , keys = ( [], Nothing )
        , frames = createFrames 10 -- initial capacity
        }
    , Task.perform GotTime Time.now
    )


initWorld : Time.Posix -> World
initWorld time =
    Ecs.emptyWorld specs.all (initSingletons <| Time.posixToMillis time)


initSingletons : Int -> Singletons
initSingletons seed =
    Ecs.Singletons6.init
        { deltaTime = Quantity.zero
        , totalTime = Quantity.zero
        }
        1
        ( [], Nothing )
        (Random.initialSeed seed)
        []
        { showBoundingBox = False
        }


initEntities : World -> World
initEntities world =
    let
        maxStars =
            100

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
        |> spawnAsteroidEntity BIG (Point2d.xy x y)
        |> spawnAsteroidEntity BIG (Point2d.xy x h)
        |> spawnAsteroidEntity BIG (Point2d.xy w y)
        |> spawnAsteroidEntity BIG (Point2d.xy w h)
        |> spawnStars maxStars


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
        |> Ecs.insertComponent specs.class Ship
        |> Ecs.insertComponent specs.position center
        |> Ecs.insertComponent specs.orientation Direction2d.positiveY
        |> Ecs.insertComponent specs.rotationVelocity Quantity.zero
        |> Ecs.insertComponent specs.positionVelocity Vector2d.zero
        |> Ecs.insertComponent specs.velocityFriction (pixelsPerSecondSquared 10.0)
        |> Ecs.insertComponent specs.angularFriction (AngularAcceleration.degreesPerSecondSquared 20.0)
        |> Ecs.insertComponent specs.shape (makeShape ( -10, -6 ) ( 10, 6 ))
        |> Ecs.insertComponent specs.render (SpriteView [ shipSprite ])


shipSprite : Svg Msg
shipSprite =
    g [ transform "scale(0.05) translate(-265, -310)" ]
        [ g [ transform "rotate(89.4391 252.538 305.805) matrix(0.635074 0 0 0.635074 116.501 73.0549)", id "imagebot_23" ] [ Svg.path [ fill "#ececec", fillRule "evenodd", stroke "#000000", strokeWidth "10", d "M212.77,5C181.98,29.506 -54.69,234.9 124.582,628.22L303.832,628.22C483.102,234.9 246.436,29.54 215.644,5.03L212.769,4.9988L212.77,5z", id "imagebot_62" ] [], Svg.path [ fill "#cccccc", strokeWidth "8", strokeLinecap "round", d "M220.19,259.65C182.897,259.65 152.565,290.013 152.565,327.306C152.565,364.599 182.897,394.931 220.19,394.931C257.483,394.931 287.846,364.599 287.846,327.306C287.846,290.013 257.483,259.65 220.19,259.65zM220.19,267.65C253.155,267.65 279.846,294.342 279.846,327.306C279.846,360.271 253.155,386.931 220.19,386.931C187.225,386.931 160.565,360.271 160.565,327.306C160.56503,294.341 187.225,267.65 220.19,267.65z", id "imagebot_61" ] [], g [ fillRule "evenodd", id "imagebot_43" ] [ g [ stroke "#000000", id "imagebot_54" ] [ g [ fill "#ff0000", id "imagebot_56" ] [ Svg.path [ d "M93.419,166.48L136.856,86.678L197.465,17.988L214.638,4.856L279.288,72.536L329.796,154.358L333.8366,171.531L92.4066,170.5208", id "imagebot_60" ] [], g [ strokeWidth "10", id "imagebot_57" ] [ Svg.path [ d "M69.175,470.54C69.175,470.54 -37.905,469.2064 26.749,741.26C26.749,741.26 32.8099,514.1 89.379,542.11", id "imagebot_59" ] [], Svg.path [ d "M359.55,470.54C359.55,470.54 466.63,469.2064 401.976,741.26C401.976,741.26 395.9151,514.1 339.346,542.11", id "imagebot_58" ] [] ] ], Svg.path [ fill "#b3b3b3", d "M98.47,572.56L124.734,628.118L304.544,627.1078L325.757,572.5598L98.477,572.5598L98.47,572.56z", id "imagebot_55" ] [] ], g [ fill "#d20000", id "imagebot_51" ] [ Svg.path [ d "M384.34,497.81L364.137,548.318L352.015,538.216L337.873,544.2769L357.066,468.5159L391.411,485.6889C391.411,485.6889 451.01,527.1049 404.543,733.1789C431.817,520.0389 383.33,497.8089 384.34,497.8089L384.34,497.81z", id "imagebot_53" ] [], Svg.path [ d "M23.718,738.23C23.718,738.23 13.657,517.86 82.307,517.01C89.8826,516.9157 89.378,541.254 89.378,541.254L62.104,547.3149L40.891,613.9849L23.718,738.2349L23.718,738.23z", id "imagebot_52" ] [] ], Svg.path [ fill "#999999", d "M259.87,572.57C263.9229,584.78 266.318,601.818 265.1512,626.101C266.01341,626.40477 266.9266,626.83104 267.87,627.3198L304.526,627.101L321.62,583.163C320.93046,579.4088 320.1337,576.0583 319.37,572.569L259.87,572.569L259.87,572.57z", id "imagebot_50" ] [], g [ fill "#cccccc", id "imagebot_47" ] [ Svg.path [ d "M233.85,465.92C227.0315,465.4149 222.725,466.48247 222.725,466.48247L217.6625,544.26347C217.6625,544.26347 241.9975,539.45797 253.4745,572.57547L313.0995,572.57547C293.7335,482.26647 253.4325,467.36547 233.8495,465.91547L233.85,465.92z", id "imagebot_49" ] [], Svg.path [ d "M101.31,577.09L121.31,627.09L149.31,629.09L141.31,572.09L101.31,577.09z", id "imagebot_48" ] [] ], g [ fill "none", stroke "#000000", strokeWidth "10", id "imagebot_44" ] [ Svg.path [ d "M212.77,5C181.98,29.506 -54.69,234.9 124.582,628.22L303.832,628.22C483.102,234.9 246.436,29.54 215.644,5.03L212.769,4.9988L212.77,5z", id "imagebot_46" ] [], Svg.path [ d "M93.419,168.5L330.809,168.5", id "imagebot_45" ] [] ] ], g [ stroke "#000000", id "imagebot_36" ] [ g [ strokeLinecap "round", id "imagebot_40" ] [ Svg.path [ fill "#b3b3b3", strokeWidth "8", d "M277.85,321.3A63.64,63.64 0 1 1 150.57,321.3A63.64,63.64 0 1 1 277.85,321.3z", id "imagebot_42" ] [], Svg.path [ fill "#80e5ff", strokeWidth "12.293", d "M255.63,321.3A41.416,41.416 0 1 1 172.798,321.3A41.416,41.416 0 1 1 255.63,321.3z", id "imagebot_41" ] [] ], g [ strokeWidth "10", id "imagebot_37" ] [ Svg.path [ fill "none", d "M101.5,573.57L325.75,573.57", id "imagebot_39" ] [], Svg.path [ fill "#ff0000", strokeLinecap "round", d "M205.12,468.52L223.303,468.52L223.303,741.26L205.12,741.26L205.12,468.52z", id "imagebot_38" ] [] ] ], Svg.path [ fill "#cccccc", fillRule "evenodd", d "M315.65,560.44C315.65,560.44 396.462,374.57 331.812,195.78C334.8425,512.97 247.969,560.44 247.969,560.44L315.649,560.44L315.65,560.44z", id "imagebot_35" ] [], g [ strokeLinecap "round", id "imagebot_32" ] [ rect [ fill "#ffffff", strokeWidth "10", x "360.76999", y "31.575", width "34.47", height "83.714", transform "matrix(0.70389,0.7103,-0.70389,0.7103,0,0)", id "imagebot_34" ] [], Svg.path [ fill "none", stroke "#000000", strokeWidth "12.293", d "M255.63,321.3A41.416,41.416 0 1 1 172.798,321.3A41.416,41.416 0 1 1 255.63,321.3z", id "imagebot_33" ] [] ], g [ fillRule "evenodd", id "imagebot_24" ] [ Svg.path [ fill "#d20000", d "M306.56,153.35C306.56,153.35 275.245,71.528 215.646,28.09C270.194,133.15 241.91,153.35 241.91,153.35L306.56,153.35z", id "imagebot_31" ] [], g [ fill "none", stroke "#000000", strokeWidth "10", id "imagebot_28" ] [ Svg.path [ d "M359.55,470.54C359.55,470.54 466.63,469.2064 401.976,741.26C401.976,741.26 395.9151,514.1 339.346,542.11", id "imagebot_30" ] [], Svg.path [ d "M69.175,470.54C69.175,470.54 -37.905,469.2064 26.749,741.26C26.749,741.26 32.8099,514.1 89.379,542.11", id "imagebot_29" ] [] ], g [ fill "#ffffff", id "imagebot_25" ] [ Svg.path [ d "M107.56,150.32C107.56,150.32 161.098,46.27 205.545,19C249.992,-8.274 108.57,152.34 107.56,150.32z", id "imagebot_27" ] [], Svg.path [ d "M76.027,426.8C72.8632,425.0433 53.303,280.84 101.741,191.09C131.608,167.051 172.243,179.693 170.312,189.6614C153.585,276.0124 94.842,437.2514 76.026,426.8014L76.027,426.8z", id "imagebot_26" ] [] ] ] ] ]


spawnBulletEntity : Orientation -> Position -> World -> World
spawnBulletEntity orientation position world =
    world
        |> newEntity
        |> Ecs.insertComponent specs.class Bullet
        |> Ecs.insertComponent specs.position position
        |> Ecs.insertComponent specs.orientation orientation
        |> Ecs.insertComponent specs.positionVelocity
            (orientation |> Direction2d.toVector |> Vector2d.scaleTo (pixelsPerSecond 150.0))
        |> Ecs.insertComponent specs.age (Age zero)
        |> Ecs.insertComponent specs.ttl (5 |> Duration.seconds |> Ttl)
        |> Ecs.insertComponent specs.shape (makeShape ( 0, -1 ) ( 5, 1 ))
        |> Ecs.insertComponent specs.render (SpriteView [ bulletSprite ])


bulletSprite : Svg Msg
bulletSprite =
    line
        [ x1 <| fromFloat 0.0
        , y1 <| fromFloat 0.0
        , x2 <| fromFloat 5
        , y2 <| fromFloat 0.0
        , stroke "#D80707"
        , fill "none"
        , strokeWidth "1"
        ]
        []


type AsteroidType
    = BIG
    | MEDIUM
    | SMALL
    | TINY


downSizeAsteroidType : AsteroidType -> Maybe AsteroidType
downSizeAsteroidType aType =
    case aType of
        BIG ->
            Just MEDIUM

        MEDIUM ->
            Just SMALL

        SMALL ->
            Just TINY

        TINY ->
            Nothing


spawnAsteroidEntity : AsteroidType -> Position -> World -> World
spawnAsteroidEntity aType position world =
    let
        size =
            case aType of
                BIG ->
                    4

                MEDIUM ->
                    3

                SMALL ->
                    2

                TINY ->
                    1

        factor =
            (size |> toFloat) / 4

        health =
            size

        mapper positionVelocity orientation rotationVelocity shape =
            { positionVelocity = positionVelocity
            , orientation = orientation
            , rotationVelocity = rotationVelocity
            , shape = shape
            }

        ( w, randoms ) =
            randomStep
                (Random.map4 mapper
                    asteroidsPositionVelocityGenerator
                    asteroidsOrientationGenerator
                    asteroidsRotationVelocityGenerator
                    (asteroidsSizeGenerator
                        |> Random.map (Tuple.mapBoth ((*) factor) ((*) factor))
                        |> Random.andThen (\( minSize, width ) -> polygon2dGenerator minSize (minSize + width) width)
                    )
                )
                world
    in
    w
        |> newEntity
        |> Ecs.insertComponent specs.class Asteroid
        |> Ecs.insertComponent specs.position position
        |> Ecs.insertComponent specs.health health
        |> Ecs.insertComponent specs.positionVelocity randoms.positionVelocity
        |> Ecs.insertComponent specs.orientation randoms.orientation
        |> Ecs.insertComponent specs.rotationVelocity randoms.rotationVelocity
        |> Ecs.insertComponent specs.shape randoms.shape
        |> Ecs.insertComponent specs.render (SpriteView [ asteroidSprite randoms.shape ])


spawnStars : Int -> World -> World
spawnStars maxStars world =
    let
        ( newWorld, particles ) =
            world
                |> randomStep (Random.list maxStars starsGenerator)

        entityViewFn shift w =
            Ecs.getComponent specs.particle w
                |> Maybe.map (starParticleSprite shift >> singleton)
                |> Maybe.withDefault []

        createStarEntity particle w =
            let
                ( updatedWorld, randomValue ) =
                    randomStep (Random.int 0 100) w
            in
            updatedWorld
                |> newEntity
                |> Ecs.insertComponent specs.particle particle
                |> Ecs.insertComponent specs.render (EntityView (entityViewFn randomValue))
    in
    List.foldl createStarEntity newWorld particles


spawnExplosion : Position -> World -> World
spawnExplosion position world =
    let
        ( newWorld, particles ) =
            world
                |> randomStep (Random.list 100 <| fizzler position)

        entityView w =
            Ecs.getComponent specs.particle w
                |> Maybe.map (fizzleParticleSprite >> singleton)
                |> Maybe.withDefault []

        createExplosionEntity particle w =
            w
                |> newEntity
                |> Ecs.insertComponent specs.particle particle
                |> Ecs.insertComponent specs.render (EntityView entityView)
    in
    List.foldl createExplosionEntity newWorld particles


asteroidSprite : Polygon2d Pixels CanvasCoordinates -> Svg Msg
asteroidSprite shape =
    let
        coords =
            shape
                |> Polygon2d.vertices
                |> List.map (Point2d.toTuple inPixels)
                |> foldl (\( x, y ) acc -> acc ++ " " ++ fromFloat x ++ "," ++ fromFloat y) ""
    in
    polygon
        [ points coords
        , stroke "#8B979C"
        , fill "#9AAAB0"
        , strokeWidth "2"
        ]
        []


starParticleSprite : Int -> Particle -> Svg msg
starParticleSprite shift particle =
    let
        luminance =
            let
                ( minLuminance, maxLuminance ) =
                    ( 50, 100 )

                amplitude =
                    (maxLuminance - minLuminance) / 2

                midpoint =
                    (maxLuminance + minLuminance) / 2

                phaseShift =
                    (toFloat shift / 100) * (2 * pi)

                angularFrequency =
                    0.02 * 2 * pi
            in
            midpoint + amplitude * sin (phaseShift + angularFrequency * Particle.lifetime particle)

        color =
            hslSvg 0 0 luminance
    in
    Svg.ellipse
        [ cx "0"
        , cy "0"
        , rx "0.5"
        , ry "0.5"
        , fill color
        ]
        []


fizzleParticleSprite : Particle -> Svg Msg
fizzleParticleSprite particle =
    let
        ( hue, saturation, luminance ) =
            ( 0, 86, 75 )

        maxLuminance =
            100

        luminanceDelta =
            maxLuminance - luminance

        lifetime =
            Particle.lifetimePercent particle

        o =
            if lifetime < 0.1 then
                lifetime * 10

            else
                1

        color =
            hslSvg
                hue
                saturation
                (maxLuminance - luminanceDelta * (1 - lifetime))
    in
    Svg.ellipse
        [ cx "0"
        , cy "0"
        , rx "0.5"
        , ry "0.5"
        , opacity (String.fromFloat o)
        , fill color
        ]
        []



-- GENERATORS


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
    Direction2d.random


asteroidsSizeGenerator : Random.Generator ( Float, Float )
asteroidsSizeGenerator =
    Random.map2 Tuple.pair
        (Random.float 12 20)
        (Random.float 10 15)


fizzler : Position -> Generator Particle
fizzler position =
    let
        ( x, y ) =
            position |> Point2d.toTuple inPixels
    in
    Particle.init (Random.constant ())
        |> Particle.withDirection (Random.map degrees (Random.float 0 360))
        |> Particle.withSpeed (Random.map (clamp 0 200) (normal 100 100))
        |> Particle.withLifetime (normal 1.25 0.1)
        |> Particle.withLocation (Random.constant { x = x, y = y })
        |> Particle.withGravity 50
        |> Particle.withDrag
            (\_ ->
                { coefficient = 2
                , density = 0.015
                , area = 8
                }
            )


starsGenerator : Generator Particle
starsGenerator =
    Particle.init (Random.constant ())
        |> Particle.withLocation
            (Random.map2 (\x y -> { x = x, y = y })
                (Random.float 0.0 (constants.width |> inPixels))
                (Random.float 0.0 (constants.height |> inPixels))
            )



-- UPDATE


type Msg
    = GotAnimationFrameDeltaMilliseconds Float
    | GotTime Time.Posix
    | KeyboardMsg Keyboard.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model ({ world } as model)) =
    Tuple.mapFirst Model <|
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
        , Sub.map KeyboardMsg Keyboard.subscriptions
        ]



-- VIEW


view : Model -> Html Msg
view (Model { world, frames }) =
    section [ class "section pt-1 has-background-black-bis" ]
        [ div [ class "columns" ]
            [ div [ class "column is-8 is-offset-2" ]
                [ Markdown.toHtml [ class "content is-medium" ] """
**Controls:** `↑` to move, `←` to rotate left, `→` to rotate right, `space` to shoot, `s` to show bounding boxes.
                """
                , viewMaybe (renderInfos frames) world
                ]
            ]
        , div [ class "columns is-centered mt-1" ]
            [ div [ class "column is-four-fifths" ]
                [ div [ class "box has-text-centered" ]
                    [ viewMaybe renderWorld world
                    ]
                ]
            ]
        , div [ class "columns" ]
            [ div [ class "column is-8 is-offset-2" ]
                [ Markdown.toHtml [ class "content is-medium" ] """
💡 Demonstrates how [elm](http://elm-lang.org/) can deal with game development using [SVG](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics) rendering and the [ECS](https://en.wikipedia.org/wiki/Entity_component_system) (Entity Component System) pattern provided by the
awesome [harmboschloo/elm-ecs](https://package.elm-lang.org/packages/harmboschloo/elm-ecs/latest/) package. Moreover, the explosion effects are generated by the
fantastic [BrianHicks/elm-particle](https://package.elm-lang.org/packages/BrianHicks/elm-particle/latest/) package.

🚧 Under construction. Missing: the management of the collision of the spaceship with the asteroids, the management of the lives, the counting of the points, etc.
""" ]
            ]
        ]


renderInfos : Frames -> World -> Html.Html Msg
renderInfos frames world =
    let
        entityCount =
            Ecs.worldEntityCount world

        componentCount =
            Ecs.worldComponentCount specs.all world

        collisionCount =
            Ecs.getSingleton specs.collisions world |> length
    in
    div
        [ class "level is-mobile"
        ]
        [ div
            [ class "level-item has-text-centered"
            ]
            [ div []
                [ p
                    [ class "heading"
                    ]
                    [ text "Entities" ]
                , p
                    [ class "title"
                    ]
                    [ entityCount |> String.fromInt |> padLeft 3 '0' |> text ]
                ]
            ]
        , div
            [ class "level-item has-text-centered"
            ]
            [ div []
                [ p
                    [ class "heading"
                    ]
                    [ text "Components" ]
                , p
                    [ class "title"
                    ]
                    [ componentCount |> String.fromInt |> padLeft 4 '0' |> text ]
                ]
            ]
        , div
            [ class "level-item has-text-centered"
            ]
            [ div []
                [ p
                    [ class "heading"
                    ]
                    [ text "Collisions" ]
                , p
                    [ class "title"
                    ]
                    [ collisionCount |> String.fromInt |> padLeft 4 '0' |> text ]
                ]
            ]
        , div
            [ class "level-item has-text-centered"
            ]
            [ div []
                [ p
                    [ class "heading"
                    ]
                    [ text "Fps" ]
                , p
                    [ class "title"
                    ]
                    [ fps frames |> Maybe.map (round >> String.fromInt) |> withDefault "-" |> text
                    ]
                ]
            ]
        ]


renderWorld : World -> Html.Html Msg
renderWorld world =
    let
        { showBoundingBox } =
            Ecs.getSingleton specs.parameters world

        ( wPixels, hPixels ) =
            ( constants.width, constants.height ) |> vApply inPixels
    in
    svg
        [ version "1.1"
        , class "world mx-auto"
        , width "100%"
        , style "max-width: 1024px"
        , height "100%"
        , viewBox (join " " [ "0", "0", fromFloat wPixels, fromFloat hPixels ])
        ]
        [ g
            [ id "sprites"
            , transform (join " " [ translateSvg 0 hPixels, scaleSvg 1 -1 ])
            ]
          <|
            foldFromLeft2
                specs.render
                specs.position
                (\entityId render position acc ->
                    let
                        w2 =
                            Ecs.onEntity entityId world
                    in
                    acc
                        |> addWhen
                            (if showBoundingBox then
                                Ecs.getComponent specs.shape w2
                                    |> Maybe.map (\shape -> renderShape entityId shape position w2)

                             else
                                Nothing
                            )
                        |> (::)
                            (w2 |> renderEntity entityId render position)
                )
                []
                world
        ]


renderEntity : EntityId -> Render -> Position -> World -> Svg Msg
renderEntity entityId render position world =
    let
        maybeDirection =
            world
                |> Ecs.getComponent specs.orientation

        rotate =
            case maybeDirection of
                Just direction ->
                    " rotate(" ++ (direction |> toAngle |> inDegrees |> fromFloat) ++ ")"

                _ ->
                    ""

        ( x, y ) =
            position |> Point2d.toTuple inPixels |> vApply fromFloat
    in
    g
        [ id (fromInt entityId)
        , transform ("translate(" ++ x ++ "," ++ y ++ ")" ++ rotate)
        ]
        (case render of
            SpriteView sprite ->
                sprite

            EntityView entityView ->
                entityView world
        )


renderShape : EntityId -> Shape -> Position -> World -> Svg Msg
renderShape entityId shape position world =
    let
        maybeDirection =
            world
                |> Ecs.getComponent specs.orientation

        maybeBoundingBox =
            shape
                |> (case maybeDirection of
                        Just orientation ->
                            Polygon2d.rotateAround Point2d.origin (orientation |> toAngle)

                        Nothing ->
                            identity
                   )
                |> Polygon2d.translateBy (Vector2d.from Point2d.origin position)
                |> Polygon2d.boundingBox
    in
    case maybeBoundingBox of
        Just boundingBox ->
            let
                ( w, h ) =
                    BoundingBox2d.dimensions boundingBox
            in
            rect
                [ id ("bb-" ++ fromInt entityId)
                , x (boundingBox |> minX |> inPixels |> fromFloat)
                , y (boundingBox |> minY |> inPixels |> fromFloat)
                , width (w |> inPixels |> fromFloat)
                , height (h |> inPixels |> fromFloat)
                , fill "none"
                , stroke "white"
                , strokeWidth "0.2"
                ]
                []

        _ ->
            g [] []



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


polygon2dGenerator : Float -> Float -> Float -> Random.Generator (Polygon2d Pixels CanvasCoordinates)
polygon2dGenerator minRadius maxRadius granularity =
    let
        increment =
            tau / granularity

        randomPoint ang =
            Random.float minRadius maxRadius
                |> Random.map
                    (\radius ->
                        ( cos ang, sin ang )
                            |> vMult radius
                            |> Point2d.fromTuple Pixels.pixels
                    )

        randomPolylineRec : Float -> Random.Generator (List Position)
        randomPolylineRec ang =
            if ang < tau then
                Random.map2 (::)
                    (randomPoint ang)
                    (randomPolylineRec <| ang + increment)

            else
                Random.constant []
    in
    Random.map singleLoop <| randomPolylineRec 0



-- HELPERS


makeShape : ( Float, Float ) -> ( Float, Float ) -> Shape
makeShape ( x1, y1 ) ( x2, y2 ) =
    Rectangle2d.from (Point2d.pixels x1 y1) (Point2d.pixels x2 y2) |> Rectangle2d.toPolygon


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


vApply : (a -> b) -> ( a, a ) -> ( b, b )
vApply f ( a, b ) =
    ( f a, f b )


vMult : Float -> ( Float, Float ) -> ( Float, Float )
vMult by =
    vApply <| (*) by


hslSvg : Float -> Float -> Float -> String
hslSvg hue saturation luminance =
    "hsl("
        ++ fromFloat hue
        ++ ","
        ++ fromFloat saturation
        ++ "%,"
        ++ fromFloat luminance
        ++ "%)"


translateSvg : Float -> Float -> String
translateSvg dx dy =
    "translate("
        ++ fromFloat dx
        ++ ","
        ++ fromFloat dy
        ++ ")"


scaleSvg : Float -> Float -> String
scaleSvg dx dy =
    "scale("
        ++ fromFloat dx
        ++ ","
        ++ fromFloat dy
        ++ ")"
