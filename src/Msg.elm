module Msg exposing (Msg(..))

import Robot exposing (Direction)


type Msg
    = Place Int Int Direction
    | Move
    | Left
    | Right
