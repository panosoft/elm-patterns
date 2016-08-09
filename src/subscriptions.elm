import Time exposing (Time, second)
import Html exposing (Html, div, text)
import Html.App


-- Model

type alias Model =
    { time: Time }


initialModel: Model
initialModel =
    { time = 0 }


-- Update

type Msg
    = ChangeTime Time


init: (Model, Cmd Msg)
init =
    initialModel
        ! []


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ChangeTime time ->
            { model | time = time }
                ! []


-- View

view: Model -> Html Msg
view model =
    div [] [ text (toString model.time) ]


-- Subscriptions

subscriptions: Model -> Sub Msg
subscriptions model =
    Time.every second ChangeTime

-- Main

main: Program Never
main =
    Html.App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
