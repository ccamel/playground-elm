module Page.RetroFu exposing (Control, Enemy, EnemyAction, Game, Mode, Model, Msg, Player, PlayerAction, SpriteState, info, init, subscriptions, update, view)

import App.Flags
import Browser.Events as BrowserEvents
import Canvas
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (imageSmoothing, scale, transform, translate)
import Canvas.Settings.Text exposing (TextAlign(..), align, font)
import Canvas.Texture as Texture
import Color exposing (rgb255)
import Html exposing (a, button, div, p, section, text)
import Html.Attributes exposing (attribute, class, href)
import Html.Events exposing (onBlur, onClick, onFocus, preventDefaultOn)
import Json.Decode as Decode
import Lib.Page
import Markdown


info : Lib.Page.PageInfo Msg
info =
    { name = "retro-fu"
    , hash = "retro-fu"
    , date = "2026-09-12"
    , description = Markdown.toHtml [ class "content" ] """
A compact survival homage to [Kung-Fu Master](https://en.wikipedia.org/wiki/Kung-Fu_Master), rendered with [joakin/elm-canvas](https://package.elm-lang.org/packages/joakin/elm-canvas/latest/).
       """
    , srcRel = "Page/RetroFu.elm"
    }


type SpriteState
    = Loading
    | Ready Texture.Texture
    | LoadFailed


type Control
    = MoveLeft
    | MoveRight
    | Jump
    | Crouch
    | Punch
    | Kick


type PlayerAction
    = Idle
    | Walking
    | Airborne
    | Crouching
    | Punching Int
    | Kicking Int
    | PlayerHurt Int
    | PlayerFalling Int


type EnemyAction
    = Approaching
    | WindingUp Int
    | Striking Int
    | Recovering Int
    | EnemyHurt Int
    | Falling Int


type Mode
    = Playing
    | GameOver


type alias Player =
    { x : Float, y : Float, velocityY : Float, health : Int, action : PlayerAction, animationFrame : Int }


type alias Enemy =
    { x : Float, health : Int, action : EnemyAction, animationFrame : Int }


type alias Game =
    { player : Player, enemy : Enemy, score : Int, wave : Int, frame : Int, mode : Mode }


type alias Model =
    { spriteState : SpriteState
    , spriteUrl : String
    , accumulatorMs : Float
    , focused : Bool
    , visible : Bool
    , pressedControls : List Control
    , pendingControls : List Control
    , game : Game
    }


type Msg
    = Tick Float
    | SpritesLoaded (Maybe Texture.Texture)
    | KeyPressed Control
    | KeyReleased Control
    | FocusChanged Bool
    | VisibilityChanged BrowserEvents.Visibility
    | RetrySprites
    | RestartIfGameOver
    | RestartGame


type alias Box =
    { left : Float, top : Float, right : Float, bottom : Float }


type alias SpriteFrame =
    { x : Float, y : Float, width : Float, height : Float, anchorX : Float }


groundY : Float
groundY =
    220


punchDuration : Int
punchDuration =
    12


punchHitTick : Int
punchHitTick =
    6


kickDuration : Int
kickDuration =
    12


kickHitTick : Int
kickHitTick =
    6


strikeDuration : Int
strikeDuration =
    12


strikeHitFrame : Int
strikeHitFrame =
    7


recoveryDuration : Int
recoveryDuration =
    18


playerHurtDuration : Int
playerHurtDuration =
    18


enemyHurtDuration : Int
enemyHurtDuration =
    12


fallDuration : Int
fallDuration =
    32


walkFrameDuration : Int
walkFrameDuration =
    6


groundSpeed : Float
groundSpeed =
    1.4


airSpeed : Float
airSpeed =
    0.8


enemyBaseSpeed : Float
enemyBaseSpeed =
    0.8


enemyWaveSpeed : Float
enemyWaveSpeed =
    0.05


enemyMaximumSpeed : Float
enemyMaximumSpeed =
    1.4


initialGame : Game
initialGame =
    { player = { x = 56, y = groundY, velocityY = 0, health = 8, action = Idle, animationFrame = 0 }
    , enemy = { x = 218, health = 6, action = Approaching, animationFrame = 0 }
    , score = 0
    , wave = 1
    , frame = 0
    , mode = Playing
    }


init : App.Flags.Flags -> ( Model, Cmd Msg )
init flags =
    ( { spriteState = Loading
      , spriteUrl = flags.basePath ++ "retro-fu-sprites.png"
      , accumulatorMs = 0
      , focused = False
      , visible = True
      , pressedControls = []
      , pendingControls = []
      , game = initialGame
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick deltaMs ->
            ( tick deltaMs model, Cmd.none )

        SpritesLoaded maybeTexture ->
            case maybeTexture of
                Just texture ->
                    ( { model | spriteState = Ready texture }, Cmd.none )

                Nothing ->
                    ( clearInput { model | spriteState = LoadFailed }, Cmd.none )

        KeyPressed control ->
            if List.member control model.pressedControls then
                ( model, Cmd.none )

            else
                ( { model | pressedControls = control :: model.pressedControls, pendingControls = control :: model.pendingControls }, Cmd.none )

        KeyReleased control ->
            ( { model | pressedControls = List.filter ((/=) control) model.pressedControls }, Cmd.none )

        FocusChanged focused ->
            ( if focused then
                { model | focused = True }

              else
                clearInput { model | focused = False }
            , Cmd.none
            )

        VisibilityChanged visibility ->
            case visibility of
                BrowserEvents.Hidden ->
                    ( clearInput { model | visible = False }, Cmd.none )

                BrowserEvents.Visible ->
                    ( { model | visible = True }, Cmd.none )

        RetrySprites ->
            ( clearInput { model | spriteState = Loading }, Cmd.none )

        RestartIfGameOver ->
            ( if model.game.mode == GameOver then
                clearInput { model | game = initialGame }

              else
                model
            , Cmd.none
            )

        RestartGame ->
            ( clearInput { model | game = initialGame }, Cmd.none )


clearInput : Model -> Model
clearInput model =
    { model | accumulatorMs = 0, pressedControls = [], pendingControls = [] }


tick : Float -> Model -> Model
tick deltaMs model =
    if simulationOpen model then
        let
            frameDurationMs =
                1000 / 56.338028

            accumulator =
                model.accumulatorMs + min deltaMs (5 * frameDurationMs)

            stepCount =
                Basics.floor (accumulator / frameDurationMs)
        in
        { model
            | accumulatorMs = accumulator - toFloat stepCount * frameDurationMs
            , pendingControls =
                if stepCount > 0 then
                    []

                else
                    model.pendingControls
            , game = runSteps stepCount model.pressedControls model.pendingControls model.game
        }

    else
        model


simulationOpen : Model -> Bool
simulationOpen model =
    case model.spriteState of
        Ready _ ->
            model.focused && model.visible && model.game.mode == Playing

        _ ->
            False


runSteps : Int -> List Control -> List Control -> Game -> Game
runSteps count held pending game =
    List.range 1 count
        |> List.foldl
            (\index next ->
                stepGame held
                    (if index == 1 then
                        pending

                     else
                        []
                    )
                    next
            )
            game


stepGame : List Control -> List Control -> Game -> Game
stepGame held pending game =
    if game.mode == GameOver then
        game

    else
        let
            nextPlayer =
                derivePlayer held pending game.player game.enemy

            player0 =
                { nextPlayer
                    | animationFrame =
                        if nextPlayer.action == game.player.action then
                            game.player.animationFrame + 1

                        else
                            0
                }

            nextEnemy =
                if player0.health <= 0 && game.enemy.health > 0 then
                    game.enemy

                else
                    deriveEnemy player0 game.enemy game.wave

            enemy0 =
                { nextEnemy
                    | animationFrame =
                        if nextEnemy.action == game.enemy.action then
                            game.enemy.animationFrame + 1

                        else
                            0
                }

            enemyDamage =
                attackDamage player0 enemy0

            playerHit =
                player0.health > 0 && enemy0.action == Striking strikeHitFrame && overlaps (playerBodyBox player0) (staffBox enemy0)

            player1 =
                if playerHit then
                    hurtPlayer player0 enemy0

                else
                    player0

            enemy1 =
                hurtEnemy enemyDamage enemy0

            playerDead =
                player1.action == PlayerFalling 0

            attackPoints =
                if enemyDamage > 0 then
                    case player0.action of
                        Punching remaining ->
                            if remaining == punchHitTick then
                                200

                            else
                                0

                        Kicking remaining ->
                            if remaining == kickHitTick then
                                100

                            else
                                0

                        _ ->
                            0

                else
                    0

            score =
                game.score
                    + attackPoints
                    + (if enemyDamage > 0 && enemy1.health <= 0 then
                        1000

                       else
                        0
                      )

            mode =
                if playerDead then
                    GameOver

                else
                    Playing

            spawning =
                player1.health > 0 && enemy1.action == Falling 0

            enemy2 =
                if spawning then
                    { x = 218, health = 6, action = Approaching, animationFrame = 0 }

                else
                    enemy1
        in
        { player = player1
        , enemy = enemy2
        , score = score
        , wave =
            if spawning then
                game.wave + 1

            else
                game.wave
        , frame = game.frame + 1
        , mode = mode
        }


derivePlayer : List Control -> List Control -> Player -> Enemy -> Player
derivePlayer held pending player enemy =
    case player.action of
        PlayerFalling remaining ->
            { player | action = PlayerFalling (max 0 (remaining - 1)) }

        Punching remaining ->
            { player | action = countdown remaining Punching Idle }

        Kicking remaining ->
            { player | action = countdown remaining Kicking Idle }

        PlayerHurt remaining ->
            let
                falling =
                    advanceVertical player
            in
            { falling
                | action =
                    if remaining == 1 then
                        if falling.y < groundY then
                            Airborne

                        else
                            Idle

                    else
                        PlayerHurt (remaining - 1)
            }

        Airborne ->
            advanceVertical { player | x = playerX (horizontalDirection held) player enemy }

        _ ->
            groundPlayer held pending player enemy


groundPlayer : List Control -> List Control -> Player -> Enemy -> Player
groundPlayer held pending player enemy =
    if List.member Jump pending then
        { player | action = Airborne, velocityY = -5.8 }

    else if List.member Punch pending then
        { player | action = Punching punchDuration }

    else if List.member Kick pending then
        { player | action = Kicking kickDuration }

    else if List.member Crouch held then
        { player | action = Crouching }

    else
        let
            direction =
                horizontalDirection held
        in
        { player
            | x = playerX direction player enemy
            , action =
                if direction == 0 then
                    Idle

                else
                    Walking
        }


advanceVertical : Player -> Player
advanceVertical player =
    let
        velocity =
            player.velocityY + 0.28

        y =
            min groundY (player.y + velocity)
    in
    if y == groundY then
        { player | y = groundY, velocityY = 0, action = Idle }

    else
        { player | y = y, velocityY = velocity }


playerX : Float -> Player -> Enemy -> Float
playerX direction player enemy =
    clamp 20
        (enemy.x - 20)
        (player.x
            + direction
            * (if player.y < groundY then
                airSpeed

               else
                groundSpeed
              )
        )


deriveEnemy : Player -> Enemy -> Int -> Enemy
deriveEnemy player enemy wave =
    case enemy.action of
        Falling remaining ->
            { enemy | action = Falling (max 0 (remaining - 1)) }

        EnemyHurt remaining ->
            { enemy | action = countdown remaining EnemyHurt Approaching }

        WindingUp remaining ->
            { enemy | action = countdown remaining WindingUp (Striking strikeDuration) }

        Striking remaining ->
            { enemy | action = countdown remaining Striking (Recovering recoveryDuration) }

        Recovering remaining ->
            { enemy | action = countdown remaining Recovering Approaching }

        Approaching ->
            if enemy.x - player.x <= 36 then
                { enemy | action = WindingUp (max 8 (18 - (wave - 1))) }

            else
                { enemy | x = clamp (player.x + 20) 236 (enemy.x - min enemyMaximumSpeed (enemyBaseSpeed + enemyWaveSpeed * toFloat (wave - 1))) }


countdown : Int -> (Int -> a) -> a -> a
countdown remaining active successor =
    if remaining == 1 then
        successor

    else
        active (remaining - 1)


hurtPlayer : Player -> Enemy -> Player
hurtPlayer player enemy =
    let
        health =
            max 0 (player.health - 1)
    in
    { player
        | x = clamp 20 (enemy.x - 20) (player.x - 4)
        , health = health
        , action =
            if health == 0 then
                PlayerFalling fallDuration

            else
                PlayerHurt playerHurtDuration
    }


hurtEnemy : Int -> Enemy -> Enemy
hurtEnemy damage enemy =
    if damage == 0 then
        enemy

    else
        let
            health =
                max 0 (enemy.health - damage)
        in
        { enemy
            | health = health
            , action =
                if health == 0 then
                    Falling fallDuration

                else
                    EnemyHurt enemyHurtDuration
        }


attackDamage : Player -> Enemy -> Int
attackDamage player enemy =
    if
        enemy.health
            > 0
            && (case enemy.action of
                    Falling _ ->
                        False

                    _ ->
                        True
               )
            && overlaps (attackBox player) (enemyHurtbox enemy)
    then
        case player.action of
            Punching remaining ->
                if remaining == punchHitTick then
                    2

                else
                    0

            Kicking remaining ->
                if remaining == kickHitTick then
                    1

                else
                    0

            _ ->
                0

    else
        0


attackBox : Player -> Box
attackBox player =
    case player.action of
        Kicking _ ->
            { left = player.x + 7, top = player.y - 40, right = player.x + 40, bottom = player.y - 18 }

        _ ->
            { left = player.x + 7, top = groundY - 54, right = player.x + 30, bottom = groundY - 32 }


enemyHurtbox : Enemy -> Box
enemyHurtbox enemy =
    { left = enemy.x - 8, top = groundY - 64, right = enemy.x + 8, bottom = groundY }


playerBodyBox : Player -> Box
playerBodyBox player =
    if player.action == Crouching then
        { left = player.x - 8, top = groundY - 30, right = player.x + 8, bottom = groundY }

    else
        { left = player.x - 7, top = player.y - 60, right = player.x + 7, bottom = player.y }


staffBox : Enemy -> Box
staffBox enemy =
    { left = enemy.x - 42, top = groundY - 55, right = enemy.x - 8, bottom = groundY - 30 }


overlaps : Box -> Box -> Bool
overlaps first second =
    first.left < second.right && first.right > second.left && first.top < second.bottom && first.bottom > second.top


horizontalDirection : List Control -> Float
horizontalDirection heldControls =
    case ( List.member MoveLeft heldControls, List.member MoveRight heldControls ) of
        ( True, False ) ->
            -1

        ( False, True ) ->
            1

        _ ->
            0


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ BrowserEvents.onVisibilityChange VisibilityChanged
        , if simulationOpen model then
            BrowserEvents.onAnimationFrameDelta Tick

          else
            Sub.none
        ]


view : Model -> Html.Html Msg
view model =
    section [ class "section pt-1 retro-fu-frame" ]
        [ div [ class "container has-text-centered" ]
            [ Canvas.toHtmlWith
                { width = 256
                , height = 256
                , textures =
                    case model.spriteState of
                        Loading ->
                            [ Texture.loadFromImageUrl model.spriteUrl SpritesLoaded ]

                        _ ->
                            []
                }
                [ class "retro-fu"
                , attribute "tabindex" "0"
                , attribute "role" "application"
                , attribute "aria-label" "Retro Fu. Left and right move, up jumps, down crouches, Z punches, X kicks, Enter restarts after game over."
                , onFocus (FocusChanged True)
                , onBlur (FocusChanged False)
                , preventDefaultOn "keydown" (keyDecoder KeyPressed)
                , preventDefaultOn "keyup" (keyDecoder KeyReleased)
                ]
                (scene model)
            , controls model
            ]
        ]


keyDecoder : (Control -> Msg) -> Decode.Decoder ( Msg, Bool )
keyDecoder tagger =
    Decode.field "key" Decode.string
        |> Decode.andThen
            (\key ->
                if key == "Enter" then
                    Decode.succeed ( RestartIfGameOver, True )

                else
                    keyToControl key
                        |> Maybe.map (tagger >> (\msg -> Decode.succeed ( msg, True )))
                        |> Maybe.withDefault (Decode.fail "unsupported key")
            )


keyToControl : String -> Maybe Control
keyToControl key =
    [ ( "ArrowLeft", MoveLeft )
    , ( "ArrowRight", MoveRight )
    , ( "ArrowUp", Jump )
    , ( "ArrowDown", Crouch )
    , ( "z", Punch )
    , ( "Z", Punch )
    , ( "x", Kick )
    , ( "X", Kick )
    ]
        |> List.filter (\pair -> Tuple.first pair == key)
        |> List.head
        |> Maybe.map Tuple.second


controls : Model -> Html.Html Msg
controls model =
    case model.spriteState of
        LoadFailed ->
            div [ class "retro-fu-controls" ] [ p [ class "has-text-danger" ] [ text "Unable to load sprites" ], button [ class "button is-small", onClick RetrySprites ] [ text "Retry" ] ]

        _ ->
            div [ class "retro-fu-controls" ]
                [ p [ class "is-size-7 mt-2" ] [ text "← → move · ↑ jump · ↓ crouch · Z punch · X kick" ]
                , button [ class "button is-small", onClick RestartGame ] [ text "Restart" ]
                , p [ class "is-size-7" ]
                    [ a [ href "https://en.wikipedia.org/wiki/Kung-Fu_Master" ] [ text "Kung-Fu Master © Irem, 1984" ]
                    , text " · sprites via "
                    , a [ href "https://spritedatabase.net/game/2285" ] [ text "Sprite Database (jin315)" ]
                    ]
                ]


scene : Model -> List Canvas.Renderable
scene model =
    let
        background =
            Canvas.shapes [ fill (rgb255 115 141 165) ] [ Canvas.rect ( 0, 0 ) 256 256 ]

        caption point value =
            Canvas.text [ fill (rgb255 255 231 134), font { size = 8, family = "monospace" }, align Center ] point value

        energy x segments health color =
            Canvas.group []
                (List.range 0 (segments - 1)
                    |> List.map
                        (\index ->
                            Canvas.shapes
                                [ fill
                                    (if health > index then
                                        color

                                     else
                                        rgb255 67 40 42
                                    )
                                ]
                                [ Canvas.rect ( x + toFloat index * 7, 22 ) 5 4 ]
                        )
                )
    in
    case model.spriteState of
        Ready texture ->
            let
                game =
                    model.game

                player =
                    playerFrame game.player game.mode

                enemy =
                    enemyFrame game.enemy

                ( playerRecoil, playerDrop ) =
                    case game.player.action of
                        PlayerFalling remaining ->
                            fallOffset remaining

                        _ ->
                            ( 0, 0 )

                ( enemyRecoil, enemyDrop ) =
                    case game.enemy.action of
                        Falling remaining ->
                            fallOffset remaining

                        _ ->
                            ( 0, 0 )

                sprite asset =
                    Texture.sprite { x = asset.x, y = asset.y, width = asset.width, height = asset.height } texture
            in
            [ background
            , Canvas.shapes [ fill (rgb255 67 78 88) ] [ Canvas.rect ( 5, 38 ) 8 182, Canvas.rect ( 243, 38 ) 8 182, Canvas.rect ( 0, 48 ) 30 5, Canvas.rect ( 226, 48 ) 30 5 ]
            , Canvas.shapes [ fill (rgb255 38 43 49) ] [ Canvas.rect ( 0, groundY ) 256 36, Canvas.rect ( 0, groundY ) 256 3 ]
            , Canvas.group []
                [ caption ( 40, 15 ) ("SCORE " ++ String.fromInt game.score)
                , caption ( 128, 15 ) ("WAVE " ++ String.fromInt game.wave)
                , energy 10 8 game.player.health (rgb255 229 190 69)
                , energy 190 6 game.enemy.health (rgb255 206 55 58)
                ]
            , Canvas.group [ transform [ translate (toFloat (round (game.player.x - playerRecoil))) (toFloat (round (game.player.y + playerDrop))) ], imageSmoothing False ] [ Canvas.texture [] ( -player.anchorX, -player.height ) (sprite player) ]
            , Canvas.group [ transform [ translate (toFloat (round (game.enemy.x + enemyRecoil))) (toFloat (round (groundY + enemyDrop))), scale -1 1 ], imageSmoothing False ] [ Canvas.texture [] ( -enemy.anchorX, -enemy.height ) (sprite enemy) ]
            , if game.mode == GameOver then
                Canvas.group []
                    [ Canvas.shapes [ fill (rgb255 44 20 20) ] [ Canvas.rect ( 54, 96 ) 148 42 ]
                    , caption ( 128, 114 ) "GAME OVER"
                    , caption ( 128, 128 ) "PRESS ENTER"
                    ]

              else
                Canvas.group [] []
            ]

        Loading ->
            [ background, caption ( 128, 128 ) "LOADING SPRITES" ]

        LoadFailed ->
            [ background, caption ( 128, 128 ) "SPRITES UNAVAILABLE" ]


playerFrame : Player -> Mode -> SpriteFrame
playerFrame player mode =
    if mode == GameOver then
        frame 152 1029 38 48 21

    else
        case player.action of
            Idle ->
                frame 16 500 24 56 9

            Walking ->
                -- Local phase: entering a walk always starts with its first pose.
                case modBy 4 (player.animationFrame // walkFrameDuration) of
                    0 ->
                        frame 72 496 26 60 12

                    1 ->
                        frame 106 493 17 63 7

                    2 ->
                        frame 131 496 27 60 11

                    _ ->
                        frame 166 494 17 62 7

            Airborne ->
                -- Keep the source row's common baseline, including raised feet.
                if player.animationFrame < 4 then
                    frame 16 782 15 86 7

                else if player.velocityY < -1.8 then
                    frame 39 782 13 86 6

                else if player.velocityY < 1.8 then
                    frame 60 782 17 86 8

                else if player.y < groundY - 10 then
                    frame 85 782 17 86 7

                else
                    frame 110 782 15 86 7

            Crouching ->
                frame 16 691 23 40 11

            Punching remaining ->
                if remaining >= 5 && remaining <= 8 then
                    frame 16 581 28 61 9

                else
                    frame 52 580 21 62 9

            Kicking remaining ->
                if remaining > 8 then
                    frame 259 580 29 62 4

                else if remaining >= 5 then
                    frame 296 581 43 61 7

                else
                    frame 347 580 29 62 4

            PlayerHurt _ ->
                frame 113 1018 31 59 14

            PlayerFalling remaining ->
                if remaining > fallDuration - 8 then
                    frame 113 1018 31 59 14

                else
                    frame 152 1029 38 48 21


enemyFrame : Enemy -> SpriteFrame
enemyFrame enemy =
    case enemy.action of
        Approaching ->
            case modBy 4 (enemy.animationFrame // 8) of
                0 ->
                    frame 16 1201 28 64 13

                1 ->
                    frame 52 1201 27 64 8

                2 ->
                    frame 87 1201 32 64 11

                _ ->
                    frame 127 1201 27 64 8

        WindingUp _ ->
            frame 186 1188 32 77 17

        Striking _ ->
            frame 260 1201 50 64 8

        Recovering _ ->
            frame 127 1201 27 64 8

        EnemyHurt _ ->
            frame 80 1373 40 75 30

        Falling remaining ->
            if remaining > 21 then
                frame 16 1484 32 69 20

            else if remaining > 10 then
                frame 153 1472 38 81 27

            else
                frame 295 1494 43 59 29


{-| Shared KO arc: recoil away from the hit, then fall past the mat and out of view.
The countdown also delays game over / respawn until the body has left the canvas.
-}
fallOffset : Int -> ( Float, Float )
fallOffset remaining =
    let
        elapsed =
            toFloat (fallDuration - remaining)
    in
    ( 0.65 * elapsed, 0.2 * elapsed * elapsed - 1.5 * elapsed )


frame : Float -> Float -> Float -> Float -> Float -> SpriteFrame
frame =
    \x y width height anchorX -> { x = x, y = y, width = width, height = height, anchorX = anchorX }
