port module Main exposing (..)

import Browser
import Html exposing (Html, button, div, p, text, textarea)
import Html.Attributes exposing (attribute, class, classList, disabled, id, value)
import Html.Events exposing (onClick, onInput)
import Morse
import Platform exposing (ProcessId, Task)
import Process
import Task


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


type MorseType
    = Code
    | Whitespace


type Msg
    = ToggleOperation MorseOperation
    | UpdateText String
    | PortReceive String
    | PortSendText MorseType
    | RemoveCopied


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleOperation op ->
            ( { model | operation = op, text = "" }, Cmd.none )

        UpdateText it ->
            ( { model | text = it }, Cmd.none )

        PortReceive message ->
            if message == "success" then
                ( { model | copied = True }, Task.perform (\_ -> RemoveCopied) (Process.sleep 3000) )

            else
                ( model, Cmd.none )

        PortSendText t ->
            ( model
            , case t of
                Code ->
                    sendText (Morse.codeFromText model.text)

                Whitespace ->
                    sendText (Morse.whitespaceFromText model.text)
            )

        RemoveCopied ->
            ( { model | copied = False }, Cmd.none )


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
        , div [ id "input-container" ]
            [ textarea
                [ id "input-textarea"
                , value model.text
                , onInput UpdateText

                -- , class "textarea"
                -- , attribute "cols" "10"
                ]
                []
            ]
        , div []
            [ p []
                [ text
                    (if model.operation == Encode then
                        Morse.codeFromText model.text |> String.replace "\t" " | "

                     else
                        Morse.codeToText model.text
                    )
                ]
            ]
        , div []
            [ button [ onClick (PortSendText Code) ] [ text "Copy Morse Code" ]
            , button [ onClick (PortSendText Whitespace) ] [ text "Copy Whitespace" ]
            , if model.copied then
                div [] [ p [] [ text "Copied!" ] ]

              else
                div [] []
            ]
        ]
