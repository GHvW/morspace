module Main exposing (..)

import Browser
import Html exposing (Html, button, div, p, text, textarea)
import Html.Attributes exposing (class, classList, disabled)
import Html.Events exposing (onClick, onInput)
import Morse


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type MorseOperation
    = Decode
    | Encode


type alias Model =
    { operation : MorseOperation
    , text : String
    }


init : Model
init =
    { operation = Encode, text = "" }


type Msg
    = ToggleOperation MorseOperation
    | UpdateText String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleOperation op ->
            { model | operation = op }

        UpdateText it ->
            { model | text = it }


isEncode : MorseOperation -> Bool
isEncode op =
    case op of
        Encode ->
            True

        _ ->
            False


view : Model -> Html Msg
view model =
    div []
        [ div [ class "buttons has-addons" ]
            [ button
                [ onClick (ToggleOperation Encode)
                , classList
                    [ ( "is-success is-selected", isEncode model.operation )
                    , ( "button", True )
                    ]
                ]
                [ text "Encode" ]
            , button
                [ onClick (ToggleOperation Decode)
                , classList
                    [ ( "is-success is-selected", not (isEncode model.operation) )
                    , ( "button", True )
                    ]
                ]
                [ text "Decode" ]
            ]
        , div []
            [ textarea [ onInput UpdateText, class "textarea" ] []
            ]
        , div [] [ p [] [ text (Morse.codeFromText model.text |> String.replace "\t" " | ") ] ]
        ]
