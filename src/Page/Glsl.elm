module Page.Glsl exposing (Attributes, Model, Msg, info, init, subscriptions, update, view)

import Basics.Extra exposing (flip, uncurry)
import Browser.Dom exposing (getElement)
import Browser.Events exposing (onAnimationFrameDelta, onResize)
import Html exposing (Html, div, section)
import Html.Attributes as Attr exposing (class, id, style)
import Html.Events.Extra.Pointer as Pointer
import Lib.Page
import Markdown
import Math.Matrix4 as Mat4 exposing (Mat4)
import Math.Vector2 as Vector2 exposing (Vec2, vec2)
import Math.Vector3 as Vector3 exposing (Vec3, vec3)
import Maybe
import Platform.Sub exposing (batch)
import Quaternion exposing (Quaternion)
import Task
import Vector exposing (fromVec3)
import WebGL exposing (Mesh, Shader, indexedTriangles)



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "glsl"
    , hash = "glsl"
    , date = "2024-08-07"
    , description = Markdown.toHtml [ class "content" ] """
A dynamic [WebGL](https://www.khronos.org/webgl/) electricity effect created with [GLSL](https://en.wikipedia.org/wiki/OpenGL_Shading_Language) shaders,
featuring interactive 3D rotation with smooth inertia.
       """
    , srcRel = "Page/Glsl.elm"
    }



-- MODEL


type alias ModelRecord =
    { time : Float
    , width : Int
    , height : Int
    , interaction : Maybe Interaction
    , lastRotation : Quaternion
    , currentRotation : Quaternion
    , angularVelocity : Maybe Quaternion
    }


rotation : ModelRecord -> Quaternion
rotation { lastRotation, currentRotation } =
    Quaternion.mul currentRotation lastRotation


type alias Interaction =
    { pos : Vec2
    , angularVelocity : Quaternion
    }


type Model
    = Model ModelRecord


init : ( Model, Cmd Msg )
init =
    ( Model
        { time = 0
        , width = 800
        , height = 600
        , interaction = Nothing
        , lastRotation = Quaternion.identity
        , currentRotation = Quaternion.identity
        , angularVelocity = Nothing
        }
    , getElementWidth "glsl"
    )



-- MESSAGES


type Msg
    = Tick Float
    | Resized
    | GotNewWidth (Result Browser.Dom.Error Int)
    | PointerDown Vec2
    | PointerMove Vec2
    | PointerEnd



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    Tuple.mapFirst Model <|
        case msg of
            Tick elapsed ->
                let
                    newVelocity =
                        model.angularVelocity |> Maybe.map (decayQuaternion constants.decayFactor)

                    newRotation =
                        newVelocity
                            |> Maybe.map (flip Quaternion.mul model.lastRotation)
                            |> Maybe.andThen Quaternion.normalize
                            |> Maybe.withDefault model.lastRotation

                    inertiaActive =
                        case newVelocity of
                            Just q ->
                                angleOfRotation q > 1.0e-3

                            Nothing ->
                                False
                in
                ( { model
                    | time = model.time + elapsed
                    , lastRotation = newRotation
                    , angularVelocity =
                        if inertiaActive then
                            newVelocity

                        else
                            Nothing
                  }
                , Cmd.none
                )

            Resized ->
                ( model
                , getElementWidth "glsl"
                )

            GotNewWidth (Ok newWidth) ->
                ( { model | width = newWidth, height = round (toFloat newWidth / constants.aspectRatio) }, Cmd.none )

            GotNewWidth (Err _) ->
                ( model, Cmd.none )

            PointerDown pos ->
                ( { model
                    | interaction = Just <| Interaction pos Quaternion.identity
                    , angularVelocity = Nothing
                  }
                , Cmd.none
                )

            PointerMove pos ->
                case model.interaction of
                    Just state ->
                        let
                            width =
                                toFloat model.width

                            height =
                                toFloat model.width / constants.aspectRatio

                            v2 =
                                mapToSphere width height pos

                            v1 =
                                mapToSphere width height state.pos

                            currRotation =
                                computeRotation v1 v2

                            angularVelocity =
                                Quaternion.mul currRotation (Quaternion.conjugate model.currentRotation)
                        in
                        ( { model | currentRotation = currRotation, interaction = Just { pos = state.pos, angularVelocity = angularVelocity } }, Cmd.none )

                    Nothing ->
                        ( model, Cmd.none )

            PointerEnd ->
                ( case model.interaction of
                    Just state ->
                        { model
                            | interaction = Nothing
                            , lastRotation = rotation model
                            , currentRotation = Quaternion.identity
                            , angularVelocity = Just state.angularVelocity
                        }

                    Nothing ->
                        model
                , Cmd.none
                )


getElementWidth : String -> Cmd Msg
getElementWidth id =
    getElement id
        |> Task.map (round << .width << .element)
        |> Task.attempt GotNewWidth



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    batch
        [ onAnimationFrameDelta Tick
        , onResize (\_ _ -> Resized)
        ]



-- VIEW


constants : { aspectRatio : Float, decayFactor : Float }
constants =
    { -- aspect ratio of the canvas
      aspectRatio = 4.0 / 3.0

    -- angular velocity decay factor
    , decayFactor = 0.98
    }


view : Model -> Html Msg
view (Model model) =
    section [ class "section pt-1 has-background-black-bis" ]
        [ div [ class "container is-max-tablet" ]
            [ div
                [ id "glsl"
                ]
                [ glsl model
                ]
            ]
        ]


glsl : ModelRecord -> Html Msg
glsl model =
    let
        { time, width, height } =
            model

        perspectiveMatrix =
            Mat4.makePerspective 45 (toFloat width / toFloat height) 0.01 100

        viewMatrix =
            Mat4.makeLookAt (vec3 0 0 1.5) (vec3 0 0 0) (vec3 0 1 0)

        projectionMatrix =
            Mat4.mul perspectiveMatrix viewMatrix

        modelMatrix =
            Quaternion.toMat4 <| rotation model

        modelViewMatrix =
            Mat4.mul viewMatrix modelMatrix
    in
    WebGL.toHtml
        ([ Attr.width width
         , Attr.height height
         , style "touch-action" "none"
         , class "is-clickable"
         ]
            |> withInteractionEvents
        )
        [ WebGL.entity
            vertexShader
            fragmentShader
            (mesh 1 32 64)
            { projectionMatrix = projectionMatrix
            , modelViewMatrix = modelViewMatrix
            , time = time / 1000
            }
        ]


withInteractionEvents : List (Html.Attribute Msg) -> List (Html.Attribute Msg)
withInteractionEvents attributes =
    let
        posLens =
            uncurry vec2 << .offsetPos << .pointer
    in
    Pointer.onWithOptions "pointerdown" { stopPropagation = True, preventDefault = True } (PointerDown << posLens)
        :: Pointer.onMove (PointerMove << posLens)
        :: Pointer.onUp (always PointerEnd)
        :: Pointer.onCancel (always PointerEnd)
        :: Pointer.onOut (always PointerEnd)
        :: attributes



-- Mesh


type alias Attributes =
    { position : Vec3
    }


mesh : Float -> Int -> Int -> Mesh Attributes
mesh radius latSegments longSegments =
    let
        vertices =
            List.concatMap
                (\i ->
                    List.map
                        (\j ->
                            let
                                theta =
                                    pi * toFloat i / toFloat latSegments

                                phi =
                                    2 * pi * toFloat j / toFloat longSegments

                                x =
                                    radius * sin theta * cos phi

                                y =
                                    radius * cos theta

                                z =
                                    radius * sin theta * sin phi
                            in
                            { position = vec3 x y z }
                        )
                        (List.range 0 longSegments)
                )
                (List.range 0 latSegments)

        indices =
            List.concatMap
                (\i ->
                    List.concatMap
                        (\j ->
                            let
                                a =
                                    i * (longSegments + 1) + j

                                b =
                                    a + longSegments + 1

                                c =
                                    a + 1

                                d =
                                    b + 1
                            in
                            [ ( a, b, c ), ( b, d, c ) ]
                        )
                        (List.range 0 (longSegments - 1))
                )
                (List.range 0 (latSegments - 1))
    in
    indexedTriangles vertices indices



-- Shaders


type alias Uniforms =
    { projectionMatrix : Mat4
    , modelViewMatrix : Mat4
    , time : Float
    }


type alias Varying =
    { vPosition : Vec3
    }


vertexShader : Shader Attributes Uniforms Varying
vertexShader =
    [glsl|
        precision mediump float;
        precision highp int;

        attribute vec3 position;
        uniform mat4 projectionMatrix;
        uniform mat4 modelViewMatrix;
        varying vec3 vPosition;

        void main() {
            vPosition = position;

            gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
        }
    |]


fragmentShader : Shader {} Uniforms Varying
fragmentShader =
    [glsl|
        precision mediump float;
        precision highp int;

        uniform float time;
        varying vec3 vPosition;

        vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }

        vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }

        vec3 permute(vec3 x) { return mod289(((x * 34.0) + 1.0) * x); }

        float snoise(vec2 v) {
            // https://github.com/OpenGLInsights/OpenGLInsightsCode/blob/master/Chapter%2007%20Procedural%20Textures%20in%20GLSL/library/snoise2.glsl
            const vec4 C = vec4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
                    0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
                    -0.577350269189626,  // -1.0 + 2.0 * C.x
                    0.024390243902439); // 1.0 / 41.0

            vec2 i = floor(v + dot(v, C.yy));
            vec2 x0 = v - i + dot(i, C.xx);

            vec2 i1 = step(x0.yx, x0.xy);
            vec4 x12 = x0.xyxy + C.xxzz;
            x12.xy -= i1;

            i = mod289(i);
            vec3 p = permute(permute(i.y + vec3(0.0, i1.y, 1.0)) + i.x + vec3(0.0, i1.x, 1.0));

            vec3 m = max(0.5 - vec3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);
            m = m * m * m * m;

            vec3 x = 2.0 * fract(p * C.www) - 1.0;
            vec3 h = abs(x) - 0.5;
            vec3 ox = floor(x + 0.5);
            vec3 a0 = x - ox;

            m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);

            vec3 g;
            g.x = a0.x * x0.x + h.x * x0.y;
            g.yz = a0.yz * x12.xz + h.yz * x12.yw;

            return 130.0 * dot(m, g);
        }

        float calculatePoint(float posX, float time, float multiplier, float noiseFactor, float power) {
            float noise = snoise(vec2(posX * multiplier, time * 0.8));
            return (1.0 - pow(2.0 * abs(posX), 2.0)) * (sin(time * 0.8) * 0.1 + noiseFactor * noise + pow(snoise(vec2(posX * 7.0, time * 2.0)), power) * 0.1);
        }

        vec3 calculateColor(float p2, float p1) {
            float color = pow(1.0 - pow(abs(p2 - p1), 0.2), 2.0);
            return vec3(color, color, color);
        }

        void main(void) {
            vec3 pos = vPosition;
            pos.x *= 0.5;

            vec3 weights[3];
            weights[0] = vec3(0.2, 0.7, 1.0);
            weights[1] = vec3(0.4, 0.5, 1.0);
            weights[2] = vec3(0.7, 0.8, 1.0);

            float multipliers[3];
            multipliers[0] = 4.0;
            multipliers[1] = 7.0;
            multipliers[2] = 5.0;

            float noiseFactors[3];
            noiseFactors[0] = 0.12;
            noiseFactors[1] = 0.15;
            noiseFactors[2] = 0.10;

            float powers[3];
            powers[0] = 4.0;
            powers[1] = 3.0;
            powers[2] = 2.0;

            vec3 color = vec3(0.0);

            {
                float p = calculatePoint(pos.x, time, multipliers[0], noiseFactors[0], powers[0]);
                color += calculateColor(p, pos.y) * weights[0];
            }
            {
                float p = calculatePoint(pos.x, time, multipliers[1], noiseFactors[1], powers[1]);
                color += calculateColor(p, pos.y) * weights[1];
            }
            {
                float p = calculatePoint(pos.x, time, multipliers[2], noiseFactors[2], powers[2]);
                color += calculateColor(p, pos.y) * weights[2];
            }

            gl_FragColor = vec4(
                color,
                1.0
            );
        }
    |]



-- Arcball


mapToSphere : Float -> Float -> Vec2 -> Vec3
mapToSphere width height v =
    let
        { x, y } =
            Vector2.toRecord v

        n =
            Vector2.fromRecord { x = (2 * x - width) / width, y = (height - 2 * y) / height }

        lengthSquared =
            Vector2.lengthSquared n

        n2 =
            if lengthSquared > 1 then
                Vector2.normalize n

            else
                n

        nz =
            sqrt (1 - min 1 lengthSquared)
    in
    Vector3.vec3 (Vector2.getX n2) (Vector2.getY n2) nz


computeRotation : Vec3 -> Vec3 -> Quaternion
computeRotation v1 v2 =
    let
        axis =
            Vector3.cross v1 v2

        angle =
            acos (min 1.0 (Vector3.dot v1 v2))
    in
    Quaternion.fromAxisAngle (fromVec3 axis) angle |> Maybe.withDefault Quaternion.identity


angleOfRotation : Quaternion -> Float
angleOfRotation q =
    if q.scalar == 0 then
        pi

    else
        let
            halfTurn =
                Vector.length q.vector / q.scalar

            s =
                asin (2 * halfTurn / (1 + halfTurn ^ 2))
        in
        if abs halfTurn < 1 then
            s

        else
            pi - s


decayQuaternion : Float -> Quaternion -> Quaternion
decayQuaternion factor q =
    let
        angle =
            angleOfRotation q

        scaledAngle =
            angle * factor

        axis =
            Vector.normalize q.vector |> Maybe.withDefault Vector.identity

        halfScaledAngle =
            scaledAngle / 2

        newScalar =
            cos halfScaledAngle

        newVector =
            Vector.scale (sin halfScaledAngle) axis
    in
    { scalar = newScalar, vector = newVector }
