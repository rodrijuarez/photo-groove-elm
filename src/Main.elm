module Main exposing (..)

import Html exposing (div, h1, img, text)
import Html.Attributes exposing (..)
import Html.CssHelpers
import Html.Events exposing (..)
import MainCss


{ id, class, classList } =
    Html.CssHelpers.withNamespace "photogroove"


urlPrefix =
    "http://elm-in-action.com/"


initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selected = "1.jpeg"
    }


viewThumbnail selectedThumbnail thumbnail =
    img [ src (urlPrefix ++ thumbnail.url), classList [ ( MainCss.Selected, selectedThumbnail == thumbnail.url ) ], onClick { operation = "SELECT_PHOTO", data = thumbnail.url } ] []


update msg model =
    if msg.operation == "SELECT_PHOTO" then
        { model | selected = msg.data }
    else
        model


view model =
    div [ class [ MainCss.Content ] ]
        [ h1 [] [ Html.text "Photo Groove" ]
        , div [ id "thumbnails" ] (List.map (viewThumbnail model.selected) model.photos)
        , img [ class [ MainCss.Large ], src (urlPrefix ++ "large/" ++ model.selected) ] []
        ]


main =
    Html.beginnerProgram
        { view = view
        , model = initialModel
        , update = update
        }
