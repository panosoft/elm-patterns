module ChildParent.Child exposing (..)

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
    = Add

type alias Context a =
    { a | amount: Int }

update: Context a -> Msg -> Model -> Model
update context msg model =
    case msg of
        Add ->
            { model | count = model.count + context.amount }

-- View
view: Model -> Html Msg
view model =
    button [ onClick Add ] [ text "Add" ]
