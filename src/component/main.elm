import Component.Component as Component exposing (..)

import Html exposing (..)
import Html.App


-- MODEL

type alias Model =
    { component : Component.State
    , data : List String
    }


initialModel : Model
initialModel =
    { component = Component.empty
    , data = [ "one", "two", "three" ]
    }


-- UPDATE

type Msg
    = Component Component.Msg
    | Selected String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Component componentMsg ->
            let
                config =
                    Component.updateConfig { onSelect = Selected }

                (component, msg) =
                    Component.update config componentMsg model.component

                model =
                    { model | component = component }
            in
                case msg of
                    Nothing ->
                        model

                    Just msg ->
                        update msg model

        Selected id ->
            let
                _ = Debug.log "selected" id
            in
                model


-- VIEW

view : Model -> Html Msg
view model =
    let
        config =
            Component.viewConfig { toId = identity }
    in
        Html.App.map Component (Component.view config model.component model.data)


-- MAIN

main : Program Never
main =
    Html.App.beginnerProgram
        { model = initialModel
        , update = update
        , view = view
        }
