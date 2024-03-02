module Msg exposing (Direction(..), Msg(..))


type Direction
    = North
    | South
    | East
    | West


type Msg
    = Place Int Int Direction
    | Move
    | Left
    | Right
