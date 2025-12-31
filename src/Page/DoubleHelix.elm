module Page.DoubleHelix exposing (HelixData, Model, Msg, Rung, Strand, info, init, subscriptions, update, view)

import Browser.Events
import Html exposing (Html, div, section)
import Html.Attributes exposing (class, id, style)
import Lib.Page
import Markdown
import Particle exposing (Particle)
import Particle.System as ParticleSystem
import Random


info : Lib.Page.PageInfo Msg
info =
    { name = "Double Helix"
    , hash = "double-helix"
    , date = "2025-12-14"
    , description = Markdown.toHtml [ class "content" ] """
An *artistic interpretation* of a DNA double helix using [a particle system](https://github.com/BrianHicks/elm-particle).
       """
    , srcRel = "Page/DoubleHelix.elm"
    }


{-| Configuration constants for the double helix visualization
-}
config :
    { field : { width : number, height : number }
    , helix : { radiusBase : number, radiusVariation : number, spinRate : Float, fallGravity : number }
    , particles : { emissionRate : number, lifetimeMin : Float, lifetimeMax : Float, delayMin : number, delayMax : Float, speedMin : number, speedMax : number, sizeBase : number, sizeVariation : number, phaseJitter : Float, spawnY : number, spawnAngle : number }
    , appearance : { radialScaleBase : Float, radialScaleDepth : Float, strandOneHue : number, strandTwoHue : number, lightnessBase : number, lightnessDepth : number, lightnessFadeMin : Float, lightnessFadeMax : Float }
    , rungs : { spacing : number, thickness : number, color : String, glowColor : String }
    , randomSeed : number
    }
config =
    { field =
        { width = 640
        , height = 640
        }
    , helix =
        { radiusBase = 130
        , radiusVariation = 16
        , spinRate = 1.3
        , fallGravity = 35
        }
    , particles =
        { emissionRate = 9
        , lifetimeMin = 4.7
        , lifetimeMax = 6.2
        , delayMin = 0
        , delayMax = 0.05
        , speedMin = 110
        , speedMax = 150
        , sizeBase = 6
        , sizeVariation = 6
        , phaseJitter = 0.4
        , spawnY = -80
        , spawnAngle = 270
        }
    , appearance =
        { radialScaleBase = 0.55
        , radialScaleDepth = 0.45
        , strandOneHue = 200
        , strandTwoHue = 330
        , lightnessBase = 30
        , lightnessDepth = 40
        , lightnessFadeMin = 0.45
        , lightnessFadeMax = 0.55
        }
    , rungs =
        { spacing = 20
        , thickness = 1
        , color = "rgba(97, 125, 117, 0.48)"
        , glowColor = "rgba(148, 200, 235, 0.44)"
        }
    , randomSeed = 42
    }


type Strand
    = StrandOne
    | StrandTwo


type alias HelixParticle =
    Particle HelixData


type alias HelixData =
    { strand : Strand
    , startPhase : Float
    , radius : Float
    }


type alias Model =
    { system : ParticleSystem.System HelixData
    , time : Float
    , cannonRate : Float
    , rungs : List Rung
    }


type alias Rung =
    { birthTime : Float
    , phase : Float
    , radius : Float
    }


type Msg
    = ParticleMsg (ParticleSystem.Msg HelixData)
    | Tick Float


init : ( Model, Cmd Msg )
init =
    ( { system = initialSystem
      , time = 0
      , cannonRate = config.particles.emissionRate
      , rungs = []
      }
    , Cmd.none
    )


initialSystem : ParticleSystem.System HelixData
initialSystem =
    ParticleSystem.init (Random.initialSeed config.randomSeed)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ParticleMsg systemMsg ->
            ( { model | system = ParticleSystem.update systemMsg model.system }
            , Cmd.none
            )

        Tick delta ->
            let
                newTime =
                    model.time + (delta / 1000)

                avgSpeed =
                    (config.particles.speedMin + config.particles.speedMax) / 2

                rungInterval =
                    config.rungs.spacing / avgSpeed

                shouldGenerateRung =
                    floor (model.time / rungInterval) < floor (newTime / rungInterval)

                newRung =
                    if shouldGenerateRung then
                        [ { birthTime = newTime
                          , phase = 0
                          , radius = config.helix.radiusBase
                          }
                        ]

                    else
                        []

                activeRungs =
                    (model.rungs ++ newRung)
                        |> List.filter (\r -> newTime - r.birthTime < config.particles.lifetimeMax)
            in
            ( { model | time = newTime, rungs = activeRungs }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ ParticleSystem.sub
            [ helixParticleCannon model.cannonRate StrandOne
            , helixParticleCannon model.cannonRate StrandTwo
            ]
            ParticleMsg
            model.system
        , Browser.Events.onAnimationFrameDelta Tick
        ]


view : Model -> Html Msg
view model =
    section [ class "section pt-1 has-background-black-bis" ]
        [ div [ class "columns" ]
            [ div [ class "column is-8 is-offset-2" ]
                [ div [ class "content is-medium has-text-centered" ]
                    [ helixView model ]
                ]
            ]
        ]


helixView : Model -> Html Msg
helixView model =
    let
        rungElements =
            model.rungs
                |> List.map (renderRung model.time)
    in
    ParticleSystem.viewCustom
        renderStrandParticle
        (\particles ->
            div
                [ id "double-helix-scope"
                , class "mx-auto"
                , style "width" (px config.field.width)
                , style "height" (px config.field.height)
                , style "background" "radial-gradient(circle at 50% 20%, #151522, #040405 60%)"
                , style "position" "relative"
                , style "overflow" "hidden"
                ]
                (rungElements ++ particles)
        )
        model.system


renderRung : Float -> Rung -> Html Msg
renderRung currentTime rung =
    let
        age =
            currentTime - rung.birthTime

        y =
            calculateRungY age

        angle =
            rung.phase + config.helix.spinRate * age

        depth =
            (sin angle + 1) / 2

        radialScale =
            config.appearance.radialScaleBase + depth * config.appearance.radialScaleDepth

        centerX =
            config.field.width / 2

        rungRadius =
            rung.radius * radialScale

        strand1X =
            centerX + (rungRadius * cos angle)

        strand2X =
            centerX + (rungRadius * cos (angle + pi))

        leftX =
            min strand1X strand2X

        rightX =
            max strand1X strand2X

        width =
            rightX - leftX

        opacity =
            calculateRungOpacity age depth
    in
    div
        [ style "position" "absolute"
        , style "left" (px leftX)
        , style "top" (px y)
        , style "width" (px width)
        , style "height" (px config.rungs.thickness)
        , style "background" config.rungs.color
        , style "box-shadow" ("0 0 8px " ++ config.rungs.glowColor)
        , style "opacity" (String.fromFloat opacity)
        , style "transform" "translateY(-50%)"
        ]
        []


calculateRungY : Float -> Float
calculateRungY age =
    let
        avgSpeed =
            (config.particles.speedMin + config.particles.speedMax) / 2
    in
    config.particles.spawnY + (avgSpeed * age) + (config.helix.fallGravity * age * age / 2)


calculateRungOpacity : Float -> Float -> Float
calculateRungOpacity age depth =
    let
        lifetimePercent =
            age / config.particles.lifetimeMax |> min 1.0

        fade =
            if lifetimePercent < 0.1 then
                lifetimePercent / 0.1

            else if lifetimePercent > 0.9 then
                1 - ((lifetimePercent - 0.9) / 0.1)

            else
                1.0
    in
    fade * (0.4 + depth * 0.3)


renderStrandParticle : HelixParticle -> Html Msg
renderStrandParticle particle =
    let
        data =
            Particle.data particle

        age =
            Particle.lifetime particle

        angle =
            data.startPhase + config.helix.spinRate * age

        depth =
            (sin angle + 1) / 2

        radialScale =
            config.appearance.radialScaleBase + depth * config.appearance.radialScaleDepth

        x =
            (config.field.width / 2) + (data.radius * radialScale * cos angle)

        y =
            Particle.topPixels particle

        size =
            config.particles.sizeBase + depth * config.particles.sizeVariation

        hue =
            case data.strand of
                StrandOne ->
                    config.appearance.strandOneHue

                StrandTwo ->
                    config.appearance.strandTwoHue

        fade =
            Particle.lifetimePercent particle

        lightness =
            (config.appearance.lightnessBase + depth * config.appearance.lightnessDepth) * (config.appearance.lightnessFadeMin + config.appearance.lightnessFadeMax * fade)

        color =
            "hsl(" ++ String.fromFloat hue ++ ", 80%, " ++ String.fromFloat lightness ++ "%)"

        glowIntensity =
            1 - depth
    in
    div
        [ style "position" "absolute"
        , style "left" (px x)
        , style "top" (px y)
        , style "transform" "translate(-50%, -50%)"
        , style "z-index" (String.fromInt (round (depth * 1000)))
        ]
        [ -- Core particle
          div
            [ style "position" "absolute"
            , style "width" (px size)
            , style "height" (px size)
            , style "background" color
            , style "border-radius" "50%"
            , style "filter" "blur(0.5px)"
            ]
            []
        , -- Medium glow layer
          div
            [ style "position" "absolute"
            , style "width" (px (size * 1.5))
            , style "height" (px (size * 1.5))
            , style "background" color
            , style "border-radius" "50%"
            , style "filter" "blur(2px)"
            , style "opacity" (String.fromFloat (0.6 * glowIntensity))
            , style "transform" "translate(-16.5%, -16.5%)"
            ]
            []
        , -- Outer glow layer
          div
            [ style "position" "absolute"
            , style "width" (px (size * 2))
            , style "height" (px (size * 2))
            , style "background" color
            , style "border-radius" "50%"
            , style "filter" "blur(4px)"
            , style "opacity" (String.fromFloat (0.4 * glowIntensity))
            , style "transform" "translate(-25%, -25%)"
            ]
            []
        ]


helixParticleCannon : Float -> Strand -> Float -> Random.Generator (List HelixParticle)
helixParticleCannon emissionRate strand delta =
    let
        base =
            delta * emissionRate / 1000

        whole =
            floor base

        fractional =
            base - toFloat whole

        phaseBase =
            strandPhase strand
    in
    Random.float 0 1
        |> Random.andThen
            (\roll ->
                let
                    total =
                        whole
                            + (if roll < fractional then
                                1

                               else
                                0
                              )
                in
                if total <= 0 then
                    Random.constant []

                else
                    Random.list total (helixParticleGenerator phaseBase strand)
            )


helixParticleGenerator : Float -> Strand -> Random.Generator HelixParticle
helixParticleGenerator phaseBase strand =
    let
        dataGenerator =
            Random.map2
                (\phaseJitter radius ->
                    { strand = strand
                    , startPhase = phaseBase + phaseJitter
                    , radius = radius
                    }
                )
                (Random.float -config.particles.phaseJitter config.particles.phaseJitter)
                (Random.float (config.helix.radiusBase - config.helix.radiusVariation) (config.helix.radiusBase + config.helix.radiusVariation))
    in
    Particle.init dataGenerator
        |> Particle.withLifetime (Random.float config.particles.lifetimeMin config.particles.lifetimeMax)
        |> Particle.withDelay (Random.float config.particles.delayMin config.particles.delayMax)
        |> Particle.withLocation (Random.constant { x = config.field.width / 2, y = config.particles.spawnY })
        |> Particle.withDirection (Random.constant (degrees config.particles.spawnAngle))
        |> Particle.withSpeed (Random.float config.particles.speedMin config.particles.speedMax)
        |> Particle.withGravity config.helix.fallGravity


strandPhase : Strand -> Float
strandPhase strand =
    case strand of
        StrandOne ->
            0

        StrandTwo ->
            pi


px : Float -> String
px value =
    String.fromFloat value ++ "px"
