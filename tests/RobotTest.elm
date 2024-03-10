module RobotTest exposing (suite)

import Expect
import Msg exposing (Direction(..))
import Robot exposing (move, place, turnLeft, turnRight)
import Test exposing (Test)


suite : Test
suite =
    Test.describe "robot basics"
        [ Test.test "places robot at position" <|
            \_ ->
                place 1 2 East
                    |> Expect.equal
                        { direction = East, x = 1, y = 2 }
        , Test.test "moves robot forward by one" <|
            \_ ->
                place 0 0 South
                    |> move
                    |> Expect.equal
                        { direction = South, x = 0, y = 1 }
        , Test.test "turns robot to left" <|
            \_ ->
                place 0 0 South
                    |> turnLeft
                    |> Expect.equal
                        { direction = West, x = 0, y = 0 }
        , Test.test "turns robot to right" <|
            \_ ->
                place 0 0 South
                    |> turnRight
                    |> Expect.equal
                        { direction = East, x = 0, y = 0 }
        ]
