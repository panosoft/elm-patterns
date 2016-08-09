import ChildParent.Child as Child
import Html exposing (Html, div, text)
import Html.App

-- Model
type alias Model =
    { child: Child.Model
    , amount: Int
    }

initialModel: Model
initialModel =
    { child = Child.initialModel
    , amount = 2
    }

-- Update
type Msg
    = Child Child.Msg

update: Msg -> Model -> Model
update msg model =
    case msg of
        Child msg ->
            { model | child = Child.update model msg model.child }

-- View
view: Model -> Html Msg
view model =
    div []
        [ text ("Parent Model: " ++ toString model)
        , Html.App.map Child (Child.view model.child)
        ]


-- Main
main: Program Never
main =
    Html.App.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
