import Json.Decode exposing ((:=))
import Json.Encode


type alias Model =
    { visible: Visible }


type Visible = All


encode: Model -> String
encode model =
    let
        value = Json.Encode.object
            [ ("visible", encodeVisible model.visible) ]
    in
        Json.Encode.encode 0 value


encodeVisible: Visible -> Json.Encode.Value
encodeVisible visible =
    case visible of
        All -> Json.Encode.string "All"


decode: String -> Result String Model
decode json =
    let
        decoder = Json.Decode.object1 Model
            ("visible" := decodeVisible)
    in
        Json.Decode.decodeString decoder json

decodeVisible: Json.Decode.Decoder Visible
decodeVisible =
    let
        toVisible string =
            case string of
                "All" -> Ok All
                _ -> Err ("visible: unexpected value: " ++ string)
    in
        Json.Decode.customDecoder Json.Decode.string toVisible


-- Test


input = """{"visible":"All"}"""

model =
    case decode input of
        Ok value -> value
        Err _ -> Debug.crash "problem decoding"

output = encode model

result = Debug.log "passing: " (Debug.log "input" input == Debug.log "output" output)
