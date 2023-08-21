module GivenAlphaText exposing (..)

-- import Fuzz exposing (Fuzzer, int, list, string)

import Expect exposing (Expectation)
import Morse
import Test exposing (..)


alphaToMorse : Test
alphaToMorse =
    describe "Given Alpha Text"
        [ test "when converting the text to Morse Code" <|
            \_ ->
                let
                    text =
                        "hello world"

                    result =
                        Morse.codeFromText text
                in
                result |> Expect.equal ".... . .-.. .-.. ---\t.-- --- .-. .-.. -.."
        ]
