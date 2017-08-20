module Main exposing (..)

import Array exposing (Array)
import Html exposing (div, h1, img, text, button)
import Html.Attributes exposing (..)
import Html.CssHelpers
import Html.Events exposing (..)
import MainCss


{ id, class, classList } =
    Html.CssHelpers.withNamespace "photogroove"


type alias Photo =
    { url : String }


type alias Msg =
    { operation : String, data : String }


type alias Model =
    { photos :
        List Photo
    , selected : String
    }


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


initialModel : Model
initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selected = "1.jpeg"
    }


photoArray : Array Photo
photoArray =
    Array.fromList initialModel.photos


selectPhoto : { operation : String, data : Photo }
selectPhoto =
    { operation = "SELECT_PHOTO", data = { url = "1.jpeg" } }


viewThumbnail : String -> Photo -> Html.Html Msg
viewThumbnail selectedThumbnail thumbnail =
    img [ src (urlPrefix ++ thumbnail.url), classList [ ( MainCss.Selected, selectedThumbnail == thumbnail.url ) ], onClick { operation = "SELECT_PHOTO", data = thumbnail.url } ] []


update msg model =
    case msg.operation of
        "SELECT_PHOTO" ->
            { model | selected = msg.data }

        "SURPRISE_ME" ->
            { model | selected = "2.jpeg" }

        _ ->
            model


view : Model -> Html.Html Msg
view model =
    div [ class [ MainCss.Content ] ]
        [ h1 [] [ Html.text "Photo Groove" ]
        , button [ onClick { operation = "SURPRISE_ME", data = "" } ] [ text "Surprise me!!!" ]
        , div [ id "thumbnails" ] (List.map (viewThumbnail model.selected) model.photos)
        , img [ class [ MainCss.Large ], src (urlPrefix ++ "large/" ++ model.selected) ] []
        ]


main =
    Html.beginnerProgram
        { view = view
        , model = initialModel
        , update = update
        }
