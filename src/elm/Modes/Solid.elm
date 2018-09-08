module Modes.Solid exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import ColorPicker


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, ColorPicker.mountColorPicker () )


view : Model -> Bool -> Html Msg
view model display =
    div
        [ id "color-picker-container"
        , classList [ ( "display", display ) ]
        , class "picker"
        ]
        []


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )
