port module Main exposing (..)

import Browser
import Html exposing (Html, button, div, p, text, textarea)
import Html.Attributes exposing (class, classList, disabled)
import Html.Events exposing (onClick, onInput)
import Morse


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type MorseOperation
    = Decode
    | Encode


type alias Model =
    { operation : MorseOperation
    , text : String
    , copied : Bool
    }


init : () -> ( Model, Cmd Msg )
init () =
    ( { operation = Encode, text = "", copied = False }, Cmd.none )


type Msg
    = ToggleOperation MorseOperation
    | UpdateText String
    | PortReceive String
    | PortSendText


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleOperation op ->
            ( { model | operation = op }, Cmd.none )

        UpdateText it ->
            ( { model | text = it, copied = False }, Cmd.none )

        PortReceive message ->
            ( { model | copied = message == "success" }, Cmd.none )

        PortSendText ->
            ( model, sendText (Morse.codeFromText model.text) )


port sendText : String -> Cmd msg


port acknowledge : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions _ =
    acknowledge PortReceive


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
        , div [] [ button [ onClick PortSendText ] [ text "Copy it" ] ]
        ]
