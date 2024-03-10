module Main exposing (init, main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Msg exposing (Msg(..))
import Robot exposing (Direction(..), Model, move, place, turnLeft, turnRight, x, y)


type alias Model =
    Robot.Model


init : Model
init =
    { x = x 0, y = y 0, direction = North }


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Place x y direction ->
            place x y direction

        Move ->
            move model

        Left ->
            turnLeft model

        Right ->
            turnRight model


view : Model -> Html Msg
view model =
    div []
        [ viewNav
        , Robot.view model
        ]


viewNav : Html Msg
viewNav =
    div []
        [ button [ onClick <| Place 0 0 North ] [ text "init" ]
        , button [ onClick <| Move ] [ text "move" ]
        , button [ onClick <| Left ] [ text "left" ]
        , button [ onClick <| Right ] [ text "right" ]
        ]
