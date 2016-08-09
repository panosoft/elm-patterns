import Html exposing (Html, button, div, text)
import Html.App
import Html.Events exposing (onClick)


-- Model

type alias Model =
    { count: Int }


initialModel: Model
initialModel =
    { count = 0 }


-- Update

type Msg
    = Count


init: (Model, Cmd Msg)
init =
    ( initialModel, Cmd.none )


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Count ->
            ( { model | count = model.count + 1 }, Cmd.none )


-- View

view: Model -> Html Msg
view model =
    div []
        [ text ("Child Model: " ++ toString model)
        , button [ onClick Count ] [ text "Click" ]
        ]


-- Subscriptions

subscriptions: Model -> Sub Msg
subscriptions model =
    Sub.none


-- Main

main: Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
