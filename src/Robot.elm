module Robot exposing (Model, move, place, turnLeft, turnRight, view, x, y)

import Html exposing (Html, button, div, table, td, text, tr)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Msg exposing (Direction(..), Msg(..))


worldSize : ( East, North )
worldSize =
    ( x 5, y 5 )


type North
    = Y Int


type East
    = X Int


type alias Model =
    { x : East
    , y : North
    , direction : Direction
    }


unwrapNorth : North -> Int
unwrapNorth (Y int) =
    int


unwrapEast : East -> Int
unwrapEast (X int) =
    int


x : Int -> East
x x_ =
    X x_


y : Int -> North
y y_ =
    Y y_


place : Int -> Int -> Direction -> Model
place x_ y_ direction =
    { x = x x_, y = y y_, direction = direction }


move : Model -> Model
move model =
    let
        maxColumn =
            Tuple.first worldSize |> unwrapEast

        maxRow =
            Tuple.second worldSize |> unwrapNorth
    in
    case model.direction of
        North ->
            if unwrapNorth model.y + 1 >= maxRow then
                model

            else
                { model | y = unwrapNorth model.y + 1 |> y }

        South ->
            if unwrapNorth model.y == 0 then
                model

            else
                { model | y = (unwrapNorth model.y - 1) |> y }

        West ->
            if unwrapEast model.x == 0 then
                model

            else
                { model | x = (unwrapEast model.x - 1) |> x }

        East ->
            if unwrapEast model.x + 1 >= maxColumn then
                model

            else
                { model | x = (unwrapEast model.x + 1) |> x }


turnLeft : Model -> Model
turnLeft model =
    let
        newDirection =
            case model.direction of
                South ->
                    East

                North ->
                    West

                East ->
                    North

                West ->
                    South
    in
    { model | direction = newDirection }


turnRight : Model -> Model
turnRight model =
    let
        newDirection =
            case model.direction of
                South ->
                    West

                North ->
                    East

                East ->
                    North

                West ->
                    South
    in
    { model | direction = newDirection }



-- VIEW


match : Int -> Int -> Model -> Bool
match row column model =
    unwrapNorth model.y == abs (row - 5) && unwrapEast model.x == column - 1


viewRobot : Direction -> Html Msg
viewRobot direction =
    let
        degrees =
            case direction of
                North ->
                    0

                South ->
                    180

                East ->
                    90

                West ->
                    -90
    in
    div [ style "transform" ("rotate(" ++ String.fromInt degrees ++ "deg)") ] [ text "🤖" ]


viewEmptyCell : Html Msg
viewEmptyCell =
    text "\u{2001}"


view : Model -> Html Msg
view model =
    div []
        [ viewNav
        , viewGame model
        ]


viewGame : Model -> Html Msg
viewGame model =
    let
        maxColumn =
            Tuple.first worldSize |> unwrapEast

        maxRow =
            Tuple.second worldSize |> unwrapNorth

        viewCellContent row column =
            if match row column model then
                viewRobot model.direction

            else
                viewEmptyCell

        viewRow row =
            tr []
                (List.range 1 maxColumn
                    |> List.map (viewCell row)
                )

        viewCell row column =
            td [ style "border" ".1em solid black", style "padding" ".5em" ]
                [ viewCellContent row column ]
    in
    div []
        [ table [ style "font-size" "2em", style "border-collapse" "collapse" ]
            (List.range 1 maxRow |> List.map viewRow)
        ]


viewNav : Html Msg
viewNav =
    div []
        [ button [ onClick <| Place 0 0 North ] [ text "init" ]
        , button [ onClick <| Move ] [ text "move" ]
        , button [ onClick <| Left ] [ text "left" ]
        , button [ onClick <| Right ] [ text "right" ]
        ]
