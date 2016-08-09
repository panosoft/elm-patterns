import NestingFull.Child as Child
import Html exposing (Html)
import Html.App


-- Model

type alias Model =
    { child: Child.Model }


initialModel: Model
initialModel =
    { child = Child.initialModel }


-- Update

type Msg
    = Child Child.Msg


init: (Model, Cmd Msg)
init =
    ( initialModel, Cmd.none )


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Child msg ->
            let
                ( child, childCmd ) =
                    Child.update msg model.child
            in
                ( { model | child = child }, Cmd.map Child childCmd )


-- View

view: Model -> Html Msg
view model =
    Html.App.map Child (Child.view model.child)


-- Subscriptions

subscriptions: Model -> Sub Msg
subscriptions model =
    Child.subscriptions model.child
        |> Sub.map Child


-- Main

main: Program Never
main =
    Html.App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
