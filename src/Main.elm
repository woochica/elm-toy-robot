module Main exposing (init, main)

import Browser
import Html exposing (Html)
import Msg exposing (Direction(..), Msg(..))
import Robot exposing (Model, move, place, turnLeft, turnRight, x, y)


type alias Model =
    Robot.Model


init : Model
init =
    { x = x 0, y = y 0, direction = South }


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
    Robot.view model
