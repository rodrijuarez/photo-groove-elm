module Main exposing (..)

import Array exposing (Array)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Photo =
    { url : String }


type Msg
    = SelectByUrl String
    | SurpriseMe
    | ChangeSize ThumbnailSize


type ThumbnailSize
    = Small
    | Medium
    | Large


type alias Model =
    { photos :
        List Photo
    , selected : String
    , chosenSize : ThumbnailSize
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
    , chosenSize = Medium
    }


photoArray : Array Photo
photoArray =
    Array.fromList initialModel.photos


selectPhoto : { operation : String, data : Photo }
selectPhoto =
    { operation = "SELECT_PHOTO", data = { url = "1.jpeg" } }


sizeToString : ThumbnailSize -> String
sizeToString size =
    case size of
        Small ->
            "small"

        Medium ->
            "med"

        Large ->
            "large"


viewThumbnail : String -> Photo -> Html.Html Msg
viewThumbnail selectedThumbnail thumbnail =
    img [ src (urlPrefix ++ thumbnail.url), classList [ ( "selected", selectedThumbnail == thumbnail.url ) ], onClick (SelectByUrl thumbnail.url) ] []


viewSizeChooser : ThumbnailSize -> ThumbnailSize -> Html.Html Msg
viewSizeChooser chosenSize size =
    label []
        [ input [ type_ "radio", name "size", onClick (ChangeSize size), checked (chosenSize == size) ] []
        , text (sizeToString size)
        ]


viewSizesChooser : ThumbnailSize -> List (Html.Html Msg)
viewSizesChooser chosenSize =
    List.map (viewSizeChooser chosenSize) [ Small, Medium, Large ]


getRandomPhotoURL : String
getRandomPhotoURL =
    getPhotoUrl 2


getPhotoUrl : Int -> String
getPhotoUrl index =
    case Array.get index photoArray of
        Just photo ->
            photo.url

        Nothing ->
            ""


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectByUrl url ->
            { model | selected = url }

        SurpriseMe ->
            { model | selected = getRandomPhotoURL }

        ChangeSize size ->
            { model | chosenSize = size }


view : Model -> Html.Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ Html.text "Photo Groove" ]
        , button [ onClick SurpriseMe ] [ text "Surprise me!!!" ]
        , h3 [] [ text "Thumbnail Size:" ]
        , div [ id "choose-size" ] (viewSizesChooser model.chosenSize)
        , div [ id "thumbnails", class (sizeToString model.chosenSize) ] (List.map (viewThumbnail model.selected) model.photos)
        , img [ class "large", src (urlPrefix ++ "large/" ++ model.selected) ] []
        ]


main =
    Html.beginnerProgram
        { view = view
        , model = initialModel
        , update = update
        }
