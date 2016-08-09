import String
import Navigation
import UrlParser exposing (Parser, format, int, oneOf, s, (</>))

import Html exposing (Html, a, button, div, text)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)


-- Parsers

type Page
    = Home
    | Count Int


toUrl: Page -> String
toUrl page =
    "#/" ++ case page of
        Home ->
            ""
        Count count ->
            "count/" ++ toString count


pageParser: Parser (Page -> a) a
pageParser =
    oneOf
        [ format Home (s "")
        , format Count (s "count" </> int)
        ]


resolvePage: Navigation.Location -> Result String Page
resolvePage location =
    location.hash
        |> String.dropLeft 2
        |> UrlParser.parse identity pageParser


urlParser: Navigation.Parser (Result String Page)
urlParser =
    Navigation.makeParser resolvePage


-- Model

type alias Model =
    { page: Page
    , count: Int
    }


initialModel: Model
initialModel =
    { page = Home
    , count = 0
    }


-- Update

type Msg
    = IncrementCount


init: Result String Page -> (Model, Cmd Msg)
init result =
    urlUpdate result initialModel


urlUpdate: Result String Page -> Model -> (Model, Cmd Msg)
urlUpdate result model =
    case result of
        Ok (Count count as page) ->
            ( { model | page = page, count = count }, Cmd.none )

        Ok page ->
            ( { model | page = page }, Cmd.none )

        Err _ ->
            ( model, Navigation.modifyUrl (toUrl model.page) )


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        IncrementCount ->
            let
                count = model.count + 1
            in
                ( { model | count = count }, Navigation.newUrl (toUrl (Count count)) )


-- View

view: Model -> Html Msg
view model =
    div []
        [ viewNav model
        , viewPage model
        ]


viewNav: Model -> Html Msg
viewNav model =
    div []
        [ a [ href (toUrl Home) ] [ text "Home" ]
        , text " "
        , a [ href (toUrl (Count model.count)) ] [ text "Count" ]
        ]


viewPage: Model -> Html Msg
viewPage model =
    case model.page of
        Count count ->
            div [] [ text (toString model.count) , button [ onClick IncrementCount ] [ text "+" ] ]

        Home ->
            div [] [ text "Welcome Home!" ]


-- Main

main: Program Never
main =
    Navigation.program
        urlParser
        { init = init
        , update = update
        , urlUpdate = urlUpdate
        , view = view
        , subscriptions = always Sub.none
        }
