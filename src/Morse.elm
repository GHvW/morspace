module Morse exposing (..)

import Alphabet exposing (..)


type alias MorseInfo =
    { wordSeparator : String
    , letterSeparator : String
    }


whitespaceInfo : MorseInfo
whitespaceInfo =
    { wordSeparator = "\t\t\t\t\t\t\t", letterSeparator = "\t\t\t" }


morseCodeInfo : MorseInfo
morseCodeInfo =
    -- wordSeparator is 3 spaces
    { wordSeparator = "\t", letterSeparator = " " }


toText : ( MorseInfo, String -> Char ) -> (String -> String)
toText ( morseInfo, morseToAlpha ) =
    let
        convertWord =
            String.split morseInfo.letterSeparator >> List.map morseToAlpha >> String.fromList
    in
    String.split morseInfo.wordSeparator
        >> List.map convertWord
        >> String.join " "


codeToText : String -> String
codeToText =
    toText
        ( morseCodeInfo
        , Alphabet.morseToAlpha >> Maybe.withDefault '_'
        )


whitespaceToText : String -> String
whitespaceToText =
    toText
        ( whitespaceInfo
        , Alphabet.whitespaceToAlpha >> Maybe.withDefault '_'
        )


fromText : ( MorseInfo, Char -> String ) -> (String -> String)
fromText ( morseInfo, convert ) =
    let
        wordToMorse : String -> String
        wordToMorse =
            String.toList >> List.map convert >> String.join morseInfo.letterSeparator
    in
    String.words
        >> List.map wordToMorse
        >> String.join morseInfo.wordSeparator


codeFromText : String -> String
codeFromText =
    fromText
        ( morseCodeInfo
        , Alphabet.alphaToMorse >> Maybe.withDefault "_"
        )


whitespaceFromText : String -> String
whitespaceFromText =
    fromText
        ( whitespaceInfo
        , Alphabet.alphaToWhitespace >> Maybe.withDefault "_"
        )
