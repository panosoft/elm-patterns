module NestingSimple.Child exposing (..)

import Html exposing (Html, button, div, text)
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

update: Msg -> Model -> Model
update msg model =
    case msg of
        Count ->
            { model | count = model.count + 1 }

-- View
view: Model -> Html Msg
view model =
    div []
        [ div [] [ text ("Child Model: " ++ toString model) ]
        , button [ onClick Count] [ text "Click" ]
        ]
