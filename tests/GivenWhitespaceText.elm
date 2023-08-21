module GivenWhitespaceText exposing (..)

-- import Fuzz exposing (Fuzzer, int, list, string)

import Expect exposing (Expectation)
import Morse
import Test exposing (..)


whitespaceToAlpha : Test
whitespaceToAlpha =
    describe "Given Whitespace Morse Code Text"
        [ test "when converting the Whitespace Morse Code to alpha text" <|
            \_ ->
                let
                    hello =
                        " \t \t \t "
                            ++ "\t\t\t"
                            ++ " "
                            ++ "\t\t\t"
                            ++ " \t   \t \t "
                            ++ "\t\t\t"
                            ++ " \t   \t \t "
                            ++ "\t\t\t"
                            ++ "   \t   \t   "

                    world =
                        " \t   \t   "
                            ++ "\t\t\t"
                            ++ "   \t   \t   "
                            ++ "\t\t\t"
                            ++ " \t   \t "
                            ++ "\t\t\t"
                            ++ " \t   \t \t "
                            ++ "\t\t\t"
                            ++ "   \t \t "

                    text =
                        hello ++ "\t\t\t\t\t\t\t" ++ world

                    -- hello world
                    result =
                        Morse.whitespaceToText text
                in
                result |> Expect.equal "hello world"
        ]
