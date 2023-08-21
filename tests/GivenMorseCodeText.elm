module GivenMorseCodeText exposing (..)

-- import Fuzz exposing (Fuzzer, int, list, string)

import Expect exposing (Expectation)
import Morse
import Test exposing (..)


morseToAlpha : Test
morseToAlpha =
    describe "Given Morse Code"
        [ test "when converting the Morse Code to alpha text" <|
            \_ ->
                let
                    -- hello world
                    text =
                        ".... . .-.. .-.. ---\t.-- --- .-. .-.. -.."

                    result =
                        Morse.codeToText text
                in
                result |> Expect.equal "hello world"
        ]
