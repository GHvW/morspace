module Alphabet exposing (..)


alphaToMorse : Char -> Maybe String
alphaToMorse c =
    case c of
        'a' ->
            Just ".-"

        'b' ->
            Just "-..."

        'c' ->
            Just "-.-."

        'd' ->
            Just "-.."

        'e' ->
            Just "."

        'f' ->
            Just "..-."

        'g' ->
            Just "--."

        'h' ->
            Just "...."

        'i' ->
            Just ".."

        'j' ->
            Just ".---"

        'k' ->
            Just "-.-"

        'l' ->
            Just ".-.."

        'm' ->
            Just "--"

        'n' ->
            Just "-."

        'o' ->
            Just "---"

        'p' ->
            Just ".--."

        'q' ->
            Just "--.-"

        'r' ->
            Just ".-."

        's' ->
            Just "..."

        't' ->
            Just "-"

        'u' ->
            Just "..-"

        'v' ->
            Just "...-"

        'w' ->
            Just ".--"

        'x' ->
            Just "-..-"

        'y' ->
            Just "-.--"

        'z' ->
            Just "--.."

        '1' ->
            Just ".----"

        '2' ->
            Just "..---"

        '3' ->
            Just "...--"

        '4' ->
            Just "....-"

        '5' ->
            Just "....."

        '6' ->
            Just "-...."

        '7' ->
            Just "--..."

        '8' ->
            Just "---.."

        '9' ->
            Just "----."

        '0' ->
            Just "-----"

        _ ->
            Nothing


alphaToWhitespace : Char -> Maybe String
alphaToWhitespace c =
    case c of
        'a' ->
            Just " \t   "

        'b' ->
            Just "   \t \t \t "

        'c' ->
            Just "   \t \t   \t "

        'd' ->
            Just "   \t \t "

        'e' ->
            Just " "

        'f' ->
            Just " \t \t   \t "

        'g' ->
            Just "   \t   \t "

        'h' ->
            Just " \t \t \t "

        'i' ->
            Just " \t "

        'j' ->
            Just " \t   \t   \t   "

        'k' ->
            Just "   \t \t   "

        'l' ->
            Just " \t   \t \t "

        'm' ->
            Just "   \t   "

        'n' ->
            Just "   \t "

        'o' ->
            Just "   \t   \t   "

        'p' ->
            Just " \t   \t   \t "

        'q' ->
            Just "   \t   \t \t   "

        'r' ->
            Just " \t   \t "

        's' ->
            Just " \t \t "

        't' ->
            Just "   "

        'u' ->
            Just " \t \t   "

        'v' ->
            Just " \t \t \t   "

        'w' ->
            Just " \t   \t   "

        'x' ->
            Just "   \t \t \t   "

        'y' ->
            Just "   \t \t   \t   "

        'z' ->
            Just "   \t   \t \t "

        '1' ->
            Just " \t   \t   \t   \t   "

        '2' ->
            Just " \t \t   \t   \t   "

        '3' ->
            Just " \t \t \t   \t   "

        '4' ->
            Just " \t \t \t \t   "

        '5' ->
            Just " \t \t \t \t "

        '6' ->
            Just "   \t \t \t \t "

        '7' ->
            Just "   \t   \t \t \t "

        '8' ->
            Just "   \t   \t   \t \t "

        '9' ->
            Just "   \t   \t   \t   \t "

        '0' ->
            Just "   \t   \t   \t   \t   "

        _ ->
            Nothing


morseToAlpha : String -> Maybe Char
morseToAlpha morseLetter =
    case morseLetter of
        ".-" ->
            Just 'a'

        "-..." ->
            Just 'b'

        "-.-." ->
            Just 'c'

        "-.." ->
            Just 'd'

        "." ->
            Just 'e'

        "..-." ->
            Just 'f'

        "--." ->
            Just 'g'

        "...." ->
            Just 'h'

        ".." ->
            Just 'i'

        ".---" ->
            Just 'j'

        "-.-" ->
            Just 'k'

        ".-.." ->
            Just 'l'

        "--" ->
            Just 'm'

        "-." ->
            Just 'n'

        "---" ->
            Just 'o'

        ".--." ->
            Just 'p'

        "--.-" ->
            Just 'q'

        ".-." ->
            Just 'r'

        "..." ->
            Just 's'

        "-" ->
            Just 't'

        "..-" ->
            Just 'u'

        "...-" ->
            Just 'v'

        ".--" ->
            Just 'w'

        "-..-" ->
            Just 'x'

        "-.--" ->
            Just 'y'

        "--.." ->
            Just 'z'

        ".----" ->
            Just '1'

        "..---" ->
            Just '2'

        "...--" ->
            Just '3'

        "....-" ->
            Just '4'

        "....." ->
            Just '5'

        "-...." ->
            Just '6'

        "--..." ->
            Just '7'

        "---.." ->
            Just '8'

        "----." ->
            Just '9'

        "-----" ->
            Just '0'

        _ ->
            Nothing


whitespaceToAlpha : String -> Maybe Char
whitespaceToAlpha morseLetter =
    case morseLetter of
        " \t   " ->
            Just 'a'

        "   \t \t \t " ->
            Just 'b'

        "   \t \t   \t " ->
            Just 'c'

        "   \t \t " ->
            Just 'd'

        " " ->
            Just 'e'

        " \t \t   \t " ->
            Just 'f'

        "   \t   \t " ->
            Just 'g'

        " \t \t \t " ->
            Just 'h'

        " \t " ->
            Just 'i'

        " \t   \t   \t   " ->
            Just 'j'

        "   \t \t   " ->
            Just 'k'

        " \t   \t \t " ->
            Just 'l'

        "   \t   " ->
            Just 'm'

        "   \t " ->
            Just 'n'

        "   \t   \t   " ->
            Just 'o'

        " \t   \t   \t " ->
            Just 'p'

        "   \t   \t \t   " ->
            Just 'q'

        " \t   \t " ->
            Just 'r'

        " \t \t " ->
            Just 's'

        "   " ->
            Just 't'

        " \t \t   " ->
            Just 'u'

        " \t \t \t   " ->
            Just 'v'

        " \t   \t   " ->
            Just 'w'

        "   \t \t \t   " ->
            Just 'x'

        "   \t \t   \t   " ->
            Just 'y'

        "   \t   \t \t " ->
            Just 'z'

        " \t   \t   \t   \t   " ->
            Just '1'

        " \t \t   \t   \t   " ->
            Just '2'

        " \t \t \t   \t   " ->
            Just '3'

        " \t \t \t \t   " ->
            Just '4'

        " \t \t \t \t " ->
            Just '5'

        "   \t \t \t \t " ->
            Just '6'

        "   \t   \t \t \t " ->
            Just '7'

        "   \t   \t   \t \t " ->
            Just '8'

        "   \t   \t   \t   \t " ->
            Just '9'

        "   \t   \t   \t   \t   " ->
            Just '0'

        _ ->
            Nothing
