import Dict exposing (Dict)
import Html exposing (..)
import Html.App
import Html.Events exposing (..)

-- Model

type alias Item =
    { id : String
    }

type alias Model =
    { items : Dict String Item
    , selected : Maybe String
    }


initialModel : Model
initialModel =
    { items =
        Dict.fromList
            [ ("1", { id = "1"})
            , ("2", { id = "2"})
            , ("3", { id = "3"})
            ]
    , selected = Nothing
    }


-- Update

type Msg
    = Select String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Select id ->
            { model | selected = Just id }


-- View

view : Model -> Html Msg
view model =
    div []
        [ ul []
            (Dict.values model.items
                |> List.map (\item -> li [ onClick (Select item.id) ] [ text item.id ]))
        , div []
            [ case model.selected of
                Nothing ->
                    text "Nothing selected"

                Just id ->
                    text (id ++ " selected")
            ]
        ]


-- Main

main : Program Never
main =
    Html.App.beginnerProgram
        { model = initialModel
        , update = update
        , view = view
        }
