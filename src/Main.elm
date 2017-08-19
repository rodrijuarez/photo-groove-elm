module Main exposing (..)

import Html exposing (div, h1, img, text)
import Html.Attributes exposing (..)
import Html.CssHelpers
import MainCss


{ id, class, classList } =
    Html.CssHelpers.withNamespace "photogroove"


view model =
    div [ class [ MainCss.Content ] ]
        [ h1 [] [ Html.text "Photo Groove" ]
        , div [ id "thumbnails" ]
            [ img [ src "http://elm-in-action.com/1.jpeg" ] []
            , img [ src "http://elm-in-action.com/2.jpeg" ] []
            , img [ src "http://elm-in-action.com/3.jpeg" ] []
            ]
        ]


main =
    view "no model yet"
