module Main exposing (..)

import Html exposing (div, h1, img, text)
import Html.Attributes exposing (..)
import Html.CssHelpers
import MainCss


{ id, class, classList } =
    Html.CssHelpers.withNamespace "photogroove"


urlPrefix =
    "http://elm-in-action.com/"


initialModel =
    [ { url = "1.jpeg" }
    , { url = "2.jpeg" }
    , { url = "3.jpeg" }
    ]


viewThumbnail thumbnail =
    img [ src (urlPrefix ++ thumbnail.url) ] []


view model =
    div [ class [ MainCss.Content ] ]
        [ h1 [] [ Html.text "Photo Groove" ]
        , div [ id "thumbnails" ] (List.map viewThumbnail model)
        ]


main =
    view initialModel
