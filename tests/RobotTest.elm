module RobotTest exposing (suite)

import Expect
import Main exposing (init, move, place, turnLeft, turnRight)
import Msg exposing (Direction(..))
import Test exposing (Test)


suite : Test
suite =
    Test.describe "robot basics"
        [ Test.test "places robot at position" <|
            \_ ->
                let
                    model =
                        init
                in
                place 1 2 East model
                    |> Expect.equal
                        { direction = East, x = 1, y = 2 }
        , Test.test "moves robot forward by one" <|
            \_ ->
                let
                    model =
                        init
                in
                move model
                    |> Expect.equal
                        { direction = South, x = 0, y = 1 }
        , Test.test "turns robot to left" <|
            \_ ->
                let
                    model =
                        init
                in
                turnLeft model
                    |> Expect.equal
                        { direction = West, x = 0, y = 0 }
        , Test.test "turns robot to right" <|
            \_ ->
                let
                    model =
                        init
                in
                turnRight model
                    |> Expect.equal
                        { direction = East, x = 0, y = 0 }
        ]
