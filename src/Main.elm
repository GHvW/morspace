port module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, p, text, textarea)
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


type MorseType
    = Code
    | Whitespace


type MorseOperation
    = Encode
    | Decode MorseType


type alias Model =
    { operation : MorseOperation
    , text : String
    , copied : Bool
    }


init : () -> ( Model, Cmd Msg )
init () =
    ( { operation = Encode
      , text = ""
      , copied = False
      }
    , Cmd.none
    )


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


isOpSelected : MorseOperation -> Model -> Bool
isOpSelected op model =
    op == model.operation


isEncode =
    isOpSelected Encode


isDecodeWhitespace =
    isOpSelected (Decode Whitespace)


isDecodeCode =
    isOpSelected (Decode Code)


textConversionToRender : MorseOperation -> String -> String
textConversionToRender operation input =
    case operation of
        Encode ->
            Morse.codeFromText input |> String.replace "\t" " | "

        Decode t ->
            case t of
                Code ->
                    Morse.codeToText input

                Whitespace ->
                    Morse.whitespaceToText input


view : Model -> Html Msg
view model =
    div []
        [ div [ id "main-container", class "mx-6" ]
            [ div [ id "top-bar-thing" ]
                [ h1 [ id "title", class "is-size-3" ] [ text "Morespace" ]
                , div [ id "encode-decode-select" ]
                    [ button
                        [ onClick (ToggleOperation Encode)
                        , classList
                            [ ( "is-success is-selected", isEncode model )
                            , ( "button", True )
                            ]
                        ]
                        [ text "Encode" ]
                    , button
                        [ onClick (ToggleOperation (Decode Whitespace))
                        , classList
                            [ ( "is-success is-selected", isDecodeWhitespace model )
                            , ( "button", True )
                            ]
                        ]
                        [ text "Decode Whitespace" ]
                    , button
                        [ onClick (ToggleOperation (Decode Code))
                        , classList
                            [ ( "is-success is-selected", isDecodeCode model )
                            , ( "button", True )
                            ]
                        ]
                        [ text "Decode Morse Code" ]
                    ]
                ]
            , textarea
                [ id "input-textarea"
                , value model.text
                , onInput UpdateText
                , class "is-size-4 textarea"

                -- , attribute "cols" "10"
                , attribute "rows" "12"
                ]
                []
            , div [ id "copy-encoded-buttons" ]
                [ if model.copied then
                    div [] [ p [] [ text "Copied!" ] ]

                  else
                    div [] []
                , button [ onClick (PortSendText Code), class "button" ] [ text "Copy Morse Code" ]
                , button [ onClick (PortSendText Whitespace), class "button" ] [ text "Copy Whitespace" ]
                ]
            , div [ id "converted-text" ]
                [ p [ class "is-size-4" ]
                    [ text
                        (textConversionToRender model.operation model.text)
                    ]
                ]
            ]
        ]
