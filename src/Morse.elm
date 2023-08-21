module Morse exposing (..)

import Alphabet exposing (..)


type alias MorseInfo =
    { wordSeparator : String
    , letterSeparator : String

    -- , morseToAlpha : String -> Char
    }


toText : ( MorseInfo, String -> Char ) -> (String -> String)
toText ( morseInfo, morseToAlpha ) =
    String.split morseInfo.wordSeparator
        >> List.map (String.split morseInfo.letterSeparator >> List.map morseToAlpha >> String.fromList)
        >> String.join " "


codeToText : String -> String
codeToText =
    toText
        ( { wordSeparator = "\t"
          , letterSeparator = " "
          }
        , Alphabet.morseToAlpha >> Maybe.withDefault '_'
        )


whitespaceToText : String -> String
whitespaceToText =
    toText
        ( { wordSeparator = "\t\t\t\t\t\t\t"
          , letterSeparator = "\t\t\t"
          }
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
        ( { wordSeparator = "\t", letterSeparator = " " }
        , Alphabet.alphaToMorse >> Maybe.withDefault "_"
        )


whitespaceFromText : String -> String
whitespaceFromText =
    fromText
        ( { wordSeparator = "\t\t\t\t\t\t\t", letterSeparator = "\t\t\t" }
        , Alphabet.alphaToWhitespace >> Maybe.withDefault "_"
        )
