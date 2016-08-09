module ChildParent.Child exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

-- Model
type alias Model =
    ()

initialModel: Model
initialModel =
    ()

-- Update
type Msg
    = NoOp
    | Dispatch DispatchMsg

type DispatchMsg
    = Notification

update: Msg -> Model -> (Model, Maybe DispatchMsg)
update msg model =
    case msg of
        NoOp ->
            (model, Nothing)
        Dispatch msg ->
            (model, Just msg)

-- View
view: Model -> Html Msg
view model =
    button [ onClick (Dispatch Notification) ] [ text "Notify Parent" ]
