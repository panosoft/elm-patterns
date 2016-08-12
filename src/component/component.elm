module Component.Component exposing
    ( State, empty
    , Msg, UpdateConfig, updateConfig, update
    , ViewConfig, viewConfig, view
    )

import Html exposing (..)
import Html.Events exposing (..)


-- MODEL

type State =
    State
        { selected: Maybe String
        }


empty : State
empty =
    State
        { selected = Nothing
        }


-- UPDATE

type Msg
    = Select String


type UpdateConfig msg
    = UpdateConfig
        { onSelect : String -> msg
        }


updateConfig :
    { onSelect : String -> msg
    }
    -> UpdateConfig msg
updateConfig { onSelect } =
    UpdateConfig
        { onSelect = onSelect
        }


update : UpdateConfig msg -> Msg -> State -> (State, Maybe msg)
update (UpdateConfig config) msg (State state) =
    case msg of
        Select id ->
            ( State { state | selected = Just id }
            , Just (config.onSelect id)
            )


-- VIEW

type ViewConfig a
    = ViewConfig
        { toId : a -> String
        }


viewConfig :
    { toId : a -> String
    }
    -> ViewConfig a
viewConfig { toId } =
    ViewConfig
        { toId = toId
        }


view : ViewConfig a -> State -> List a -> Html Msg
view (ViewConfig config) state data =
    let
        toLi item =
            let
                id = config.toId item
            in
                li [ onClick (Select id) ] [ text id ]
    in
        ul []
            (List.map toLi data)
            -- TODO switch to keyed ul and li
