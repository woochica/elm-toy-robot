module Main exposing (main)

import Browser
import Html exposing (Html, button, div, table, td, text, tr)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Msg exposing (Direction(..), Msg(..))


worldSize : ( Int, Int )
worldSize =
    ( 5, 5 )


type alias South =
    Int


type alias West =
    Int


type alias Model =
    { x : West
    , y : South
    , direction : Direction
    }


init : Model
init =
    { x = 0, y = 0, direction = South }


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Place x y direction ->
            place x y direction model

        Move ->
            move model

        Left ->
            turnLeft model

        Right ->
            turnRight model


place : South -> West -> Direction -> Model -> Model
place x y direction model =
    { model | x = x, y = y, direction = direction }


move : Model -> Model
move model =
    let
        maxColumn =
            Tuple.first worldSize

        maxRow =
            Tuple.second worldSize
    in
    case model.direction of
        South ->
            if model.y + 1 >= maxRow then
                model

            else
                { model | y = model.y + 1 }

        North ->
            if model.y == 0 then
                model

            else
                { model | y = model.y - 1 }

        East ->
            if model.x == 0 then
                model

            else
                { model | x = model.x - 1 }

        West ->
            if model.x + 1 >= maxColumn then
                model

            else
                { model | x = model.x + 1 }


turnLeft : Model -> Model
turnLeft model =
    case model.direction of
        South ->
            { model | direction = West }

        North ->
            { model | direction = East }

        East ->
            { model | direction = South }

        West ->
            { model | direction = North }


turnRight : Model -> Model
turnRight model =
    case model.direction of
        South ->
            { model | direction = East }

        North ->
            { model | direction = West }

        East ->
            { model | direction = North }

        West ->
            { model | direction = South }



-- VIEW


match row column model =
    model.y == row - 1 && model.x == column - 1


viewRobot : Direction -> Html Msg
viewRobot direction =
    let
        attrs =
            case direction of
                North ->
                    []

                South ->
                    [ style "transform" "rotate(180deg)" ]

                East ->
                    [ style "transform" "rotate(-90deg)" ]

                West ->
                    [ style "transform" "rotate(90deg)" ]
    in
    div attrs [ text "🤖" ]


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
            Tuple.first worldSize

        maxRow =
            Tuple.second worldSize

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
        [ button [ onClick <| Place 0 0 South ] [ text "init" ]
        , button [ onClick <| Move ] [ text "move" ]
        , button [ onClick <| Left ] [ text "left" ]
        , button [ onClick <| Right ] [ text "right" ]
        ]
