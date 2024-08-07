port module Page.Dapp exposing (Model, Msg, info, init, subscriptions, update, view)

import App.Flags exposing (Flags)
import Dict exposing (Dict)
import Duration exposing (Duration, seconds)
import Html exposing (Html, button, div, figure, hr, i, img, p, section, span, text)
import Html.Attributes exposing (class, classList, src, style)
import Html.Attributes.Extra exposing (attributeIf)
import Html.Events exposing (onClick)
import Html.Extra exposing (nothing, viewIf)
import Json.Decode
import Json.Decode.Extra
import Lib.Page
import Markdown
import Process
import Task
import Toast



-- PAGE INFO


info : Lib.Page.PageInfo Msg
info =
    { name = "dapp"
    , hash = "dapp"
    , date = "2024-07-09"
    , description = Markdown.toHtml [ class "content" ] """
A dApp utilizing [EIP-6963](https://eips.ethereum.org/EIPS/eip-6963) to discover multiple injected providers and connect to various wallets
using [ELM ports](https://guide.elm-lang.org/interop/ports.html) to communicate with the browser extensions.
      """
    , srcRel = "Page/Dapp.elm"
    }



-- MODEL


type alias Uuid =
    String


type alias Connection =
    { chainID : String
    , chainName : String
    , address : List String
    }


type WalletState
    = NotConnected
    | Connecting
    | Connected Connection


type alias Wallet =
    { state : WalletState
    , provider : EIP6963AnnounceProvider
    }


type alias ModelRecord =
    { wallets : Dict Uuid Wallet
    , tray : Toast.Tray Notification
    , copy : CopyState
    }


type NotificationType
    = Info
    | Warning
    | Error


type alias Notification =
    { type_ : NotificationType
    , message : String
    }


newWallet : EIP6963AnnounceProvider -> Wallet
newWallet provider =
    { state = NotConnected
    , provider = provider
    }


type Model
    = Model ModelRecord


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( Model
        { wallets = Dict.empty
        , tray = Toast.tray
        , copy = Idle
        }
    , listProviders ()
    )



-- UPDATE


type CopyState
    = Idle
    | Copying


type alias WalletConnection =
    { uuid : Uuid
    , chainID : String
    , chainName : String
    , address : List String
    }


type
    Msg
    -- provider
    = ProviderAnnounced EIP6963AnnounceProvider
    | ConnectWalletWithProvider Uuid
    | WalletConnected WalletConnection
    | WalletNotConnected Uuid
    | WalletDisconnected Uuid
      -- notification
    | ToastMsg Toast.Msg
    | AddToast Notification
      -- copy
    | CopyToClipboard String
    | SetCopyStateIdle


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    Tuple.mapFirst Model <|
        case msg of
            ProviderAnnounced provider ->
                ( { model | wallets = Dict.insert provider.info.uuid (newWallet provider) model.wallets }, Cmd.none )

            ConnectWalletWithProvider uuid ->
                ( { model
                    | wallets =
                        Dict.update uuid
                            (Maybe.map (\w -> { w | state = Connecting }))
                            model.wallets
                  }
                , connectWalletWithProvider uuid
                )

            WalletConnected wallet ->
                ( { model
                    | wallets =
                        Dict.update wallet.uuid
                            (Maybe.map
                                (\w ->
                                    { w
                                        | state =
                                            Connected
                                                { address = wallet.address
                                                , chainID = wallet.chainID
                                                , chainName = wallet.chainName
                                                }
                                    }
                                )
                            )
                            model.wallets
                  }
                , Cmd.none
                )

            WalletNotConnected uuid ->
                ( { model
                    | wallets =
                        Dict.update uuid
                            (Maybe.map
                                (\w ->
                                    { w
                                        | state =
                                            NotConnected
                                    }
                                )
                            )
                            model.wallets
                  }
                , Cmd.none
                )

            WalletDisconnected uuid ->
                ( { model
                    | wallets =
                        Dict.update uuid
                            (Maybe.map
                                (\w ->
                                    { w
                                        | state =
                                            NotConnected
                                    }
                                )
                            )
                            model.wallets
                  }
                , Cmd.none
                )

            AddToast notification ->
                let
                    ( tray, tmsg ) =
                        Toast.add model.tray (Toast.expireIn 3000 notification |> Toast.withExitTransition 1000)
                in
                ( { model | tray = tray }, Cmd.map ToastMsg tmsg )

            ToastMsg tmsg ->
                let
                    ( tray, newTmesg ) =
                        Toast.update tmsg model.tray
                in
                ( { model | tray = tray }, Cmd.map ToastMsg newTmesg )

            CopyToClipboard text ->
                ( { model | copy = Copying }
                , Cmd.batch
                    [ copyToClipboard text
                    , resetCopyState (2.0 |> seconds)
                    ]
                )

            SetCopyStateIdle ->
                ( { model | copy = Idle }, Cmd.none )


delayMsg : Duration -> msg -> Cmd msg
delayMsg delay msg =
    Task.perform (always msg) (Process.sleep <| Duration.inMilliseconds delay)


resetCopyState : Duration -> Cmd Msg
resetCopyState delay =
    delayMsg delay SetCopyStateIdle



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ receiveProviderAnnouncement mapProviderAnnounced
        , receiveWalletConnected mapWalletConnected
        , receiveWalletNotConnected mapWalletNotConnected
        , receiveWalletDisconnected mapWalletDisconnected
        , receiveNotification mapNotification
        ]



-- PORTS


port listProviders : () -> Cmd msg


port connectWalletWithProvider : Uuid -> Cmd msg


port copyToClipboard : String -> Cmd msg


port receiveProviderAnnouncement : (Json.Decode.Value -> msg) -> Sub msg


port receiveWalletConnected : (Json.Decode.Value -> msg) -> Sub msg


port receiveWalletNotConnected : (Uuid -> msg) -> Sub msg


port receiveWalletDisconnected : (Uuid -> msg) -> Sub msg


port receiveNotification : (Json.Decode.Value -> msg) -> Sub msg


mapProviderAnnounced : Json.Decode.Value -> Msg
mapProviderAnnounced json =
    let
        result =
            Json.Decode.decodeValue eIP6963AnnounceProviderDecoder json
    in
    case result of
        Ok announce ->
            ProviderAnnounced announce

        Err err ->
            AddToast { type_ = Error, message = "Decoding error: " ++ Json.Decode.errorToString err }


type alias EIP6963AnnounceProvider =
    { info : EIP6963AnnounceProviderInfo
    }


type alias EIP6963AnnounceProviderInfo =
    { icon : String
    , name : String
    , rdns : String
    , uuid : String
    }


eIP6963AnnounceProviderDecoder : Json.Decode.Decoder EIP6963AnnounceProvider
eIP6963AnnounceProviderDecoder =
    Json.Decode.succeed EIP6963AnnounceProvider
        |> Json.Decode.Extra.andMap (Json.Decode.field "info" eIP6963AnnounceProviderInfoDecoder)


eIP6963AnnounceProviderInfoDecoder : Json.Decode.Decoder EIP6963AnnounceProviderInfo
eIP6963AnnounceProviderInfoDecoder =
    Json.Decode.succeed EIP6963AnnounceProviderInfo
        |> Json.Decode.Extra.andMap (Json.Decode.field "icon" Json.Decode.string)
        |> Json.Decode.Extra.andMap (Json.Decode.field "name" Json.Decode.string)
        |> Json.Decode.Extra.andMap (Json.Decode.field "rdns" Json.Decode.string)
        |> Json.Decode.Extra.andMap (Json.Decode.field "uuid" Json.Decode.string)


type alias ConnectedWallet =
    { uuid : Uuid
    , chainID : String
    , chainName : String
    , address : List String
    }


mapWalletConnected : Json.Decode.Value -> Msg
mapWalletConnected json =
    let
        result =
            Json.Decode.decodeValue connectedWalletDecoder json
    in
    case result of
        Ok wallet ->
            WalletConnected wallet

        Err err ->
            AddToast { type_ = Error, message = "Decoding error: " ++ Json.Decode.errorToString err }


connectedWalletDecoder : Json.Decode.Decoder ConnectedWallet
connectedWalletDecoder =
    Json.Decode.succeed ConnectedWallet
        |> Json.Decode.Extra.andMap (Json.Decode.field "uuid" Json.Decode.string)
        |> Json.Decode.Extra.andMap (Json.Decode.field "chainID" Json.Decode.string)
        |> Json.Decode.Extra.andMap (Json.Decode.field "chainName" Json.Decode.string)
        |> Json.Decode.Extra.andMap (Json.Decode.field "address" <| Json.Decode.list Json.Decode.string)


mapWalletNotConnected : Uuid -> Msg
mapWalletNotConnected uuid =
    WalletNotConnected uuid


mapWalletDisconnected : Uuid -> Msg
mapWalletDisconnected uuid =
    WalletDisconnected uuid


mapNotification : Json.Decode.Value -> Msg
mapNotification json =
    let
        result =
            Json.Decode.decodeValue notificationDecoder json
    in
    case result of
        Ok notification ->
            AddToast notification

        Err err ->
            AddToast { type_ = Error, message = "Decoding error: " ++ Json.Decode.errorToString err }


notificationTypeDecoder : Json.Decode.Decoder NotificationType
notificationTypeDecoder =
    Json.Decode.string
        |> Json.Decode.andThen
            (\str ->
                case str of
                    "info" ->
                        Json.Decode.succeed Info

                    "warning" ->
                        Json.Decode.succeed Warning

                    "error" ->
                        Json.Decode.succeed Error

                    _ ->
                        Json.Decode.fail <| "Unknown notification type: " ++ str
            )


notificationDecoder : Json.Decode.Decoder Notification
notificationDecoder =
    Json.Decode.succeed Notification
        |> Json.Decode.Extra.andMap (Json.Decode.field "type" notificationTypeDecoder)
        |> Json.Decode.Extra.andMap (Json.Decode.field "message" Json.Decode.string)



-- VIEW


view : Model -> Html Msg
view (Model model) =
    section [ class "section pt-1 has-background-black-bis" ]
        [ div []
            [ trayView model.tray
            , div [ class "columns" ]
                [ div [ class "column is-8 is-offset-2" ]
                    [ div [ class "content is-medium" ]
                        [ Markdown.toHtml [ class "content" ] """
The discovered wallets are listed below. Click the `Connect` button to link a wallet and retrieve its addresses.
"""
                        ]
                    ]
                ]
            , div [ class "block" ]
                [ walletsView model ]
            ]
        ]


walletsView : ModelRecord -> Html Msg
walletsView { wallets, copy } =
    div [ class "columns" ]
        [ div [ class "column is-4 is-offset-4" ]
            [ if Dict.isEmpty wallets then
                div [ class "container has-text-centered" ]
                    [ p [ class "subtitle" ] [ text "No EIP-6963 providers found. Make sure you have a wallet installed." ]
                    ]

              else
                div []
                    (wallets
                        |> Dict.values
                        |> List.sortBy (.provider >> .info >> .name)
                        |> List.map (walletView copy)
                    )
            ]
        ]


walletView : CopyState -> Wallet -> Html Msg
walletView copy wallet =
    let
        isConnected =
            case wallet.state of
                Connected _ ->
                    True

                _ ->
                    False
    in
    div [ class "box" ]
        (div [ class "level is-mobile" ]
            [ div [ class "level-left" ]
                [ div [ class "level-item" ]
                    [ figure [ class "image is-32x32" ]
                        [ img [ src wallet.provider.info.icon ] []
                        ]
                    ]
                , div [ class "level-item" ]
                    [ text wallet.provider.info.name
                    ]
                , case wallet.state of
                    Connected connection ->
                        div [ class "level-item" ]
                            [ div [ class "tag is-success" ] [ text connection.chainName ]
                            ]

                    _ ->
                        nothing
                ]
            , div [ class "level-right" ]
                [ div [ class "level-item" ]
                    [ button
                        [ class "button is-small is-rounded is-info is-outlined"
                        , style "width" "100px"
                        , classList [ ( "is-loading", wallet.state == Connecting ), ( "animate__animated animate__pulse", isConnected ) ]
                        , attributeIf (wallet.state == NotConnected) <| onClick <| ConnectWalletWithProvider wallet.provider.info.uuid
                        ]
                        (if isConnected then
                            [ span [] [ text "connected" ]
                            , span [ class "icon is-small has-text-success" ]
                                [ i [ class "fa fa-circle is-size-7" ] []
                                ]
                            ]

                         else
                            [ span [] [ text "connect" ]
                            , span [ class "icon is-small has-text-link" ]
                                [ i [ class "fa fa-link" ] []
                                ]
                            ]
                        )
                    ]
                ]
            ]
            :: walletAddressesView copy wallet.state
        )


walletAddressesView : CopyState -> WalletState -> List (Html Msg)
walletAddressesView copy state =
    case state of
        Connected connection ->
            [ viewIf (not <| List.isEmpty connection.address) <| hr [] []
            , div [ class "level is-mobile" ] <| List.concatMap (walletAddressView copy) connection.address
            ]

        _ ->
            [ nothing ]


walletAddressView : CopyState -> String -> List (Html Msg)
walletAddressView copy address =
    [ div [ class "level-left" ]
        [ div [ class "level-item" ]
            [ div [ class "is-family-monospace" ] [ text <| truncateAddress 6 address ]
            ]
        ]
    , div [ class "level-right" ]
        [ div [ class "level-item" ]
            [ let
                icon =
                    case copy of
                        Copying ->
                            "fa-check"

                        Idle ->
                            "fa-clipboard"
              in
              button
                [ class "button is-small is-ghost"
                , onClick (CopyToClipboard address)
                ]
                [ span [ class "icon is-small" ]
                    [ i [ class <| "fa " ++ icon ] []
                    ]
                ]
            ]
        ]
    ]


trayView : Toast.Tray Notification -> Html Msg
trayView tray =
    div [ class "toast-tray" ]
        [ Toast.config ToastMsg
            |> Toast.withEnterAttributes [ class "animate__animated animate__fadeInUp" ]
            |> Toast.withExitAttributes [ class "animate__animated animate__fadeOut" ]
            |> Toast.render toastView tray
        ]


toastView : List (Html.Attribute Msg) -> Toast.Info Notification -> Html Msg
toastView attributes toast =
    let
        color =
            case toast.content.type_ of
                Info ->
                    "is-info"

                Warning ->
                    "is-warning"

                Error ->
                    "is-danger"
    in
    div (class ("notification is-light " ++ color) :: attributes)
        [ button
            [ class "delete"
            , onClick (ToastMsg <| Toast.exit toast.id)
            ]
            []
        , text toast.content.message
        ]


truncateAddress : Int -> String -> String
truncateAddress chars address =
    let
        ( start, end ) =
            ( String.left chars address, String.right chars address )
    in
    start ++ "..." ++ end
