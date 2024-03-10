module RobotTest exposing (suite)

import Expect
import Robot exposing (Direction(..), move, place, turnLeft, turnRight, x, y)
import Test exposing (Test)


suite : Test
suite =
    Test.describe "robot basics"
        [ Test.test "places robot at position" <|
            \_ ->
                place 1 2 East
                    |> Expect.equal
                        { direction = East, x = x 1, y = y 2 }
        , Test.test "moves robot forward by one" <|
            \_ ->
                place 0 0 North
                    |> move
                    |> Expect.equal
                        { direction = North, x = x 0, y = y 1 }
        , Test.test "robot cannot fall off the table" <|
            \_ ->
                place 0 0 South
                    |> move
                    |> Expect.equal
                        { direction = South, x = x 0, y = y 0 }
        , Test.test "turns robot to left" <|
            \_ ->
                place 0 0 North
                    |> turnLeft
                    |> Expect.equal
                        { direction = West, x = x 0, y = y 0 }
        , Test.test "turns robot to right" <|
            \_ ->
                place 0 0 North
                    |> turnRight
                    |> Expect.equal
                        { direction = East, x = x 0, y = y 0 }
        ]
