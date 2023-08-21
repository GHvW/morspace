module Morse exposing (..)

import Alphabet exposing (..)


type alias MorseInfo =
    { wordSeparator : String
    , letterSeparator : String
    , morseToAlpha : String -> Char
    }


toText : MorseInfo -> (String -> String)
toText morseInfo =
    String.split morseInfo.wordSeparator
        >> List.map (String.split morseInfo.letterSeparator >> List.map morseInfo.morseToAlpha >> String.fromList)
        >> String.join " "


codeToText : String -> String
codeToText =
    toText
        { wordSeparator = "\t"
        , letterSeparator = " "
        , morseToAlpha = Alphabet.morseToAlpha >> Maybe.withDefault '_'
        }


whitespaceToText : String -> String
whitespaceToText =
    toText
        { wordSeparator = "\t\t\t\t\t\t\t"
        , letterSeparator = "\t\t\t"
        , morseToAlpha = Alphabet.whitespaceToAlpha >> Maybe.withDefault '_'
        }


fromText : (Char -> String) -> (String -> String)
fromText convert =
    let
        wordToMorse : String -> String
        wordToMorse =
            String.toList >> List.map convert >> String.join " "
    in
    String.words
        >> List.map wordToMorse
        >> String.join "\t"


codeFromText : String -> String
codeFromText =
    fromText (Alphabet.alphaToMorse >> Maybe.withDefault "_")


whitespaceFromText : String -> String
whitespaceFromText =
    fromText (Alphabet.alphaToMorse >> Maybe.withDefault "_")
