import Random
import Html exposing (Html, div, text, button)
import Html.App
import Html.Events exposing (onClick)


-- Model

type alias Model =
    { value: Int }


initialModel: Model
initialModel =
    { value = 1 }


-- Update

type Msg
    = Roll
    | ChangeValue Int


init: (Model, Cmd Msg)
init =
    initialModel
        ! []


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Roll ->
            model
                ! [ Random.generate ChangeValue (Random.int 1 6) ]

        ChangeValue value ->
            { model | value = value }
                ! []


-- View

view: Model -> Html Msg
view model =
    div []
        [ text (toString model.value)
        , button [ onClick Roll ] [ text "Roll" ]
        ]


-- Main

main: Program Never
main =
    Html.App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
