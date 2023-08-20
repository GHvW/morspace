module ConvertText exposing (..)

import Alphabet exposing (..)

splitToLetters : String -> String -> String -> List String
splitToLetters wordSeparator letterSeparator =
    String.split wordSeparator >> String.split letterSeparator

