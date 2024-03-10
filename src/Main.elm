module Main exposing (init, main)

import Browser
import Browser.Events
import Json.Decode as Decode
import Robot exposing (Direction(..), Model, move, place, turnLeft, turnRight, x, y)


type alias Model =
    Robot.Model


type KeyEventMsg
    = KeyEventLetter Char
    | KeyEventMeta String


type Msg
    = KeyPressedMsg KeyEventMsg


init : flags -> ( Model, Cmd Msg )
init _ =
    ( { x = x 0, y = y 0, direction = North }, Cmd.none )


main : Program () Model Msg
main =
    Browser.document { init = init, update = update, view = view, subscriptions = subscriptions }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyPressedMsg keyEventMsg ->
            case keyEventMsg of
                KeyEventMeta "ArrowLeft" ->
                    ( turnLeft model, Cmd.none )

                KeyEventMeta "ArrowRight" ->
                    ( turnRight model, Cmd.none )

                KeyEventMeta "ArrowUp" ->
                    ( move model, Cmd.none )

                KeyEventMeta "Escape" ->
                    init ()

                _ ->
                    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onKeyDown keyPressedDecoder
        ]


view : Model -> Browser.Document Msg
view model =
    { title = "ELm Robot Toy"
    , body =
        [ Robot.view model
        ]
    }


keyPressedDecoder : Decode.Decoder Msg
keyPressedDecoder =
    Decode.map (toKeyEventMsg >> KeyPressedMsg) (Decode.field "key" Decode.string)


toKeyEventMsg : String -> KeyEventMsg
toKeyEventMsg eventKeyString =
    case String.uncons eventKeyString of
        Just ( char, "" ) ->
            KeyEventLetter char

        _ ->
            KeyEventMeta eventKeyString
