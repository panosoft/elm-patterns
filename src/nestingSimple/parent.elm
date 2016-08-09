import NestingSimple.Child as Child
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

update: Msg -> Model -> Model
update msg model =
    case msg of
        Child msg ->
            { model | child = (Child.update msg model.child) }

-- View
view: Model -> Html Msg
view model =
    Html.App.map Child (Child.view model.child)

-- Main
main: Program Never
main =
    Html.App.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
