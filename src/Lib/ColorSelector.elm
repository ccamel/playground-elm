module Lib.ColorSelector exposing (view)

import Color exposing (toCssString)
import ColorPicker
import Html exposing (Html, button, div, i, span)
import Html.Attributes exposing (attribute, class, id, style)
import Html.Attributes.Aria exposing (ariaControls, ariaHasPopup, role)
import Lib.Html exposing (classList, onClickNotPropagate)


{-| A color selector that opens a color picker when clicked.
-}
view : { visible : Bool, color : Color.Color, onVisibilityChange : Bool -> msg, state : ColorPicker.State, toMsg : ColorPicker.Msg -> msg } -> Html msg
view { visible, color, onVisibilityChange, state, toMsg } =
    div
        [ classList [ ( "is-active", visible ) ]
        , class "dropdown"
        ]
        [ div [ class "dropdown-trigger" ]
            [ button [ class "button py-1", ariaHasPopup "true", ariaControls "dropdown-menu", onClickNotPropagate (onVisibilityChange (not visible)) ]
                [ span [ class "p-2 m-0", style "background-color" (toCssString color) ] []
                , span [ class "icon is-small" ]
                    [ i
                        [ classList [ ( "fa", True ), ( "fa-angle-down", not visible ), ( "fa-angle-up", visible ) ]
                        , attribute "aria-hidden" "true"
                        ]
                        []
                    ]
                ]
            ]
        , div [ class "dropdown-menu", id "dropdown-menu", role "menu" ]
            [ div [ class "dropdown-content" ]
                [ div [ class "dropdown-item" ]
                    [ ColorPicker.view color state |> Html.map toMsg
                    ]
                ]
            ]
        ]
