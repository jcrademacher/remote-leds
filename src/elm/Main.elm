module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Color exposing (Color)
import Svg
import Svg.Attributes as Svg
import Svg.Events as Svg


-- PROJECT MODULES

import ColorPicker
import Modes.Audio as Audio
import Modes.Chase as Chase
import Modes.RainbowChase as RainbowChase
import Modes.MultiFade as MultiFade
import Modes.RainbowFade as RainbowFade
import Modes.Solid as Solid


type alias Pages =
    { solid : Solid.Model
    , chase : Chase.Model
    , rainbowChase : RainbowChase.Model
    , multiFade : MultiFade.Model
    , rainbowFade : RainbowFade.Model
    , audio : Audio.Model
    }


type alias Model =
    { mode : Mode
    , pages : Pages
    }


init : ( Model, Cmd Msg )
init =
    let
        ( solidModel, solidCmd ) =
            Solid.init

        ( chaseModel, chaseCmd ) =
            Chase.init

        ( rainbowChaseModel, rainbowChaseCmd ) =
            RainbowChase.init

        ( multiFadeModel, multiFadeCmd ) =
            MultiFade.init

        ( rainbowFadeModel, rainbowFadeCmd ) =
            RainbowFade.init

        ( audioModel, audioCmd ) =
            Audio.init

        nextModel =
            { mode = Solid
            , pages =
                { solid = solidModel
                , chase = chaseModel
                , rainbowChase = rainbowChaseModel
                , multiFade = multiFadeModel
                , rainbowFade = rainbowFadeModel
                , audio = audioModel
                }
            }

        nextCmds =
            [ Cmd.map (ModeMsg << SolidMsg) solidCmd
            , Cmd.map (ModeMsg << ChaseMsg) chaseCmd
            , Cmd.map (ModeMsg << RainbowChaseMsg) rainbowChaseCmd
            , Cmd.map (ModeMsg << MultiFadeMsg) multiFadeCmd
            , Cmd.map (ModeMsg << RainbowFadeMsg) rainbowFadeCmd
            , Cmd.map (ModeMsg << AudioMsg) audioCmd
            ]
    in
        ( nextModel, Cmd.batch nextCmds )


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ h2 []
            [ label [] [ text "Status: Connected" ]
            , br [] []
            , text "LOT 1 LED Controller"
            ]
        , br [] []
        , h3 []
            [ text "MODE"
            ]
        , hr [] []
        , viewModes model.mode
        , h3 []
            [ text "SETTINGS"
            ]
        , hr [] []
        , viewModeSettings model
        , hr [] []
        , br [] []
        , viewGlobalSettings model
        ]


viewModes : Mode -> Html Msg
viewModes mode =
    div [ class "modes" ]
        [ button
            [ class "blue"
            , classList [ ( "selected", mode == Solid ) ]
            , onClick <| SwitchMode Solid
            ]
            [ text "Solid"
            ]
        , button
            [ class "blue"
            , classList [ ( "selected", mode == Chase ) ]
            , onClick <| SwitchMode Chase
            ]
            [ text "Chase"
            ]
        , button
            [ class "blue"
            , classList [ ( "selected", mode == RainbowChase ) ]
            , onClick <| SwitchMode RainbowChase
            ]
            [ text "Rainbow Chase"
            ]
        , button
            [ class "blue"
            , classList [ ( "selected", mode == MultiFade ) ]
            , onClick <| SwitchMode MultiFade
            ]
            [ text "Multi Fade"
            ]
        , button
            [ class "blue"
            , classList [ ( "selected", mode == RainbowFade ) ]
            , onClick <| SwitchMode RainbowFade
            ]
            [ text "Rainbow Fade"
            ]
        , button
            [ class "blue"
            , classList [ ( "selected", mode == Audio ) ]
            , onClick <| SwitchMode Audio
            ]
            [ text "Audio"
            ]
        ]


viewModeSettings : Model -> Html Msg
viewModeSettings model =
    div [ class "settings" ]
        [ Solid.view model.pages.solid (model.mode == Solid)
            |> Html.map (ModeMsg << SolidMsg)
        , Chase.view model.pages.chase (model.mode == Chase)
            |> Html.map (ModeMsg << ChaseMsg)
        , RainbowChase.view model.pages.rainbowChase (model.mode == RainbowChase)
            |> Html.map (ModeMsg << RainbowChaseMsg)
        , MultiFade.view model.pages.multiFade (model.mode == MultiFade)
            |> Html.map (ModeMsg << MultiFadeMsg)
        , RainbowFade.view model.pages.rainbowFade (model.mode == RainbowFade)
            |> Html.map (ModeMsg << RainbowFadeMsg)
        , Audio.view model.pages.audio (model.mode == Audio)
            |> Html.map (ModeMsg << AudioMsg)
        ]


viewGlobalSettings : Model -> Html Msg
viewGlobalSettings model =
    div [ class "global-settings" ]
        [ text "Test"
        ]


type Tab
    = Strands
    | BlockM


type Mode
    = Solid
    | Chase
    | RainbowChase
    | MultiFade
    | RainbowFade
    | Audio


type ModeSubMsg
    = SolidMsg Solid.Msg
    | ChaseMsg Chase.Msg
    | RainbowChaseMsg RainbowChase.Msg
    | MultiFadeMsg MultiFade.Msg
    | RainbowFadeMsg RainbowFade.Msg
    | AudioMsg Audio.Msg


type Msg
    = SwitchMode Mode
    | ModeMsg ModeSubMsg



-- | ColorPickerMsg ColorPicker.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ pages } as model) =
    case msg of
        SwitchMode mode ->
            let
                ( nextPages, nextCmd ) =
                    case mode of
                        Solid ->
                            let
                                ( page, cmd ) =
                                    Solid.init
                            in
                                ( { pages | solid = page }, Cmd.map SolidMsg cmd )

                        Chase ->
                            let
                                ( page, cmd ) =
                                    Chase.init
                            in
                                ( { pages | chase = page }, Cmd.map ChaseMsg cmd )

                        RainbowChase ->
                            let
                                ( page, cmd ) =
                                    RainbowChase.init
                            in
                                ( { pages | rainbowChase = page }, Cmd.map RainbowChaseMsg cmd )

                        MultiFade ->
                            let
                                ( page, cmd ) =
                                    MultiFade.init
                            in
                                ( { pages | multiFade = page }, Cmd.map MultiFadeMsg cmd )

                        RainbowFade ->
                            let
                                ( page, cmd ) =
                                    RainbowFade.init
                            in
                                ( { pages | rainbowFade = page }, Cmd.map RainbowFadeMsg cmd )

                        Audio ->
                            let
                                ( page, cmd ) =
                                    Audio.init
                            in
                                ( { pages | audio = page }, Cmd.map AudioMsg cmd )
            in
                ( { model | mode = mode, pages = nextPages }, Cmd.map ModeMsg nextCmd )

        ModeMsg subMsg ->
            case subMsg of
                SolidMsg sub ->
                    let
                        ( nextModel, nextCmd ) =
                            Solid.update sub model.pages.solid

                        nextPages =
                            { pages | solid = nextModel }
                    in
                        ( { model | pages = nextPages }, Cmd.map (ModeMsg << SolidMsg) nextCmd )

                ChaseMsg sub ->
                    let
                        ( nextModel, nextCmd ) =
                            Chase.update sub model.pages.chase

                        nextPages =
                            { pages | chase = nextModel }
                    in
                        ( { model | pages = nextPages }, Cmd.map (ModeMsg << ChaseMsg) nextCmd )

                RainbowChaseMsg sub ->
                    let
                        ( nextModel, nextCmd ) =
                            RainbowChase.update sub model.pages.rainbowChase

                        nextPages =
                            { pages | rainbowChase = nextModel }
                    in
                        ( { model | pages = nextPages }, Cmd.map (ModeMsg << RainbowChaseMsg) nextCmd )

                MultiFadeMsg sub ->
                    let
                        ( nextModel, nextCmd ) =
                            MultiFade.update sub model.pages.multiFade

                        nextPages =
                            { pages | multiFade = nextModel }
                    in
                        ( { model | pages = nextPages }, Cmd.map (ModeMsg << MultiFadeMsg) nextCmd )

                RainbowFadeMsg sub ->
                    let
                        ( nextModel, nextCmd ) =
                            RainbowFade.update sub model.pages.rainbowFade

                        nextPages =
                            { pages | rainbowFade = nextModel }
                    in
                        ( { model | pages = nextPages }, Cmd.map (ModeMsg << RainbowFadeMsg) nextCmd )

                AudioMsg sub ->
                    let
                        ( nextModel, nextCmd ) =
                            Audio.update sub model.pages.audio

                        nextPages =
                            { pages | audio = nextModel }
                    in
                        ( { model | pages = nextPages }, Cmd.map (ModeMsg << AudioMsg) nextCmd )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
