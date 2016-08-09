port module Main exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Time exposing (Time, second)


-- Ports

port output: Time -> Cmd msg


port input: (Int -> msg) -> Sub msg


-- Model

type alias Model =
    { input: Int
    , output: Time
    }


initialModel: Model
initialModel =
    { input = 0
    , output = 0
    }


-- Update

type Msg
    = Input Int
    | Output Time


init: (Model, Cmd Msg)
init =
    (initialModel, Cmd.none)


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Input int ->
            ( { model | input = int }, Cmd.none )

        Output time ->
            ( { model | output = time }, output time )


-- View

view: Model -> Html Msg
view model =
    div [] [ text (toString model) ]


-- Subscriptions

subscriptions: Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every second Output
        , input Input
        ]



-- Main

main: Program Never
main =
    Html.App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
