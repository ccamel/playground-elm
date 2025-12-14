module Page.DoubleHelix exposing (HelixData, Model, Msg, Strand, info, init, subscriptions, update, view)

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
A simplified visualization of a DNA double helix using the elm-particle system.
The particles flow in a double helix pattern, creating a smooth and mesmerizing visual effect.
       """
    , srcRel = "Page/DoubleHelix.elm"
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
    }


type Msg
    = ParticleMsg (ParticleSystem.Msg HelixData)
    | Tick Float


init : ( Model, Cmd Msg )
init =
    ( { system = initialSystem
      , time = 0
      , cannonRate = 5
      }
    , Cmd.none
    )


initialSystem : ParticleSystem.System HelixData
initialSystem =
    ParticleSystem.init (Random.initialSeed 42)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ParticleMsg systemMsg ->
            ( { model | system = ParticleSystem.update systemMsg model.system }
            , Cmd.none
            )

        Tick delta ->
            ( { model | time = model.time + (delta / 1000) }, Cmd.none )


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
    ParticleSystem.viewCustom
        renderParticle
        (\particles ->
            div
                [ id "double-helix-scope"
                , class "mx-auto"
                , style "width" (px fieldWidth)
                , style "height" (px fieldHeight)
                , style "background" "radial-gradient(circle at 50% 20%, #151522, #040405 60%)"
                , style "position" "relative"
                , style "overflow" "hidden"
                ]
                particles
        )
        model.system


renderParticle : HelixParticle -> Html Msg
renderParticle particle =
    let
        data =
            Particle.data particle

        age =
            Particle.lifetime particle

        angle =
            data.startPhase + spinRate * age

        depth =
            (sin angle + 1) / 2

        radialScale =
            0.55 + depth * 0.45

        x =
            (fieldWidth / 2) + (data.radius * radialScale * cos angle)

        y =
            Particle.topPixels particle

        size =
            6 + depth * 6

        hue =
            case data.strand of
                StrandOne ->
                    200

                StrandTwo ->
                    330

        fade =
            Particle.lifetimePercent particle

        lightness =
            (30 + depth * 40) * (0.45 + 0.55 * fade)
    in
    div
        [ style "position" "absolute"
        , style "left" (px x)
        , style "top" (px y)
        , style "width" (px size)
        , style "height" (px size)
        , style "background" ("hsl(" ++ String.fromFloat hue ++ ", 80%, " ++ String.fromFloat lightness ++ "%)")
        , style "border-radius" "50%"
        , style "filter" "blur(0.5px)"
        , style "transform" "translate(-50%, -50%)"
        ]
        []


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
                (Random.float -0.4 0.4)
                (Random.float (radiusBase - 16) (radiusBase + 16))
    in
    Particle.init dataGenerator
        |> Particle.withLifetime (Random.float 4.7 6.2)
        |> Particle.withDelay (Random.float 0 0.25)
        |> Particle.withLocation (Random.constant { x = fieldWidth / 2, y = -80 })
        |> Particle.withDirection (Random.constant (degrees 270))
        |> Particle.withSpeed (Random.float 110 150)
        |> Particle.withGravity fallGravity


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


fieldWidth : Float
fieldWidth =
    640


fieldHeight : Float
fieldHeight =
    640


radiusBase : Float
radiusBase =
    130


spinRate : Float
spinRate =
    1.3


fallGravity : Float
fallGravity =
    35
