module Main exposing (..)

import Array exposing (Array)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random exposing (..)


type alias Photo =
    { url : String }


type Msg
    = SelectByUrl String
    | SelectByIndex Int
    | SurpriseMe
    | ChangeSize ThumbnailSize


type ThumbnailSize
    = Small
    | Medium
    | Large


type alias Model =
    { photos :
        List Photo
    , selected : Maybe String
    , loadingError : Maybe String
    , chosenSize : ThumbnailSize
    }


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


initialModel : Model
initialModel =
    { photos =
        []
    , selected = Nothing
    , loadingError = Nothing
    , chosenSize = Medium
    }


sizeToString : ThumbnailSize -> String
sizeToString size =
    case size of
        Small ->
            "small"

        Medium ->
            "med"

        Large ->
            "large"


viewThumbnail : Maybe String -> Photo -> Html.Html Msg
viewThumbnail selectedThumbnail thumbnail =
    img [ src (urlPrefix ++ thumbnail.url), classList [ ( "selected", selectedThumbnail == Just thumbnail.url ) ], onClick (SelectByUrl thumbnail.url) ] []


viewSizeChooser : ThumbnailSize -> ThumbnailSize -> Html.Html Msg
viewSizeChooser chosenSize size =
    label []
        [ input [ type_ "radio", name "size", onClick (ChangeSize size), checked (chosenSize == size) ] []
        , text (sizeToString size)
        ]


viewSizesChooser : ThumbnailSize -> List (Html.Html Msg)
viewSizesChooser chosenSize =
    List.map (viewSizeChooser chosenSize) [ Small, Medium, Large ]


newSelected : Int -> List Photo -> Maybe String
newSelected index photos =
    Array.fromList photos
        |> Array.get index
        |> Maybe.map .url


viewLarge : Maybe String -> Html.Html Msg
viewLarge selectedUrl =
    case selectedUrl of
        Just url ->
            img [ class "large", src (urlPrefix ++ "large/" ++ url) ] []

        Nothing ->
            text ""


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectByUrl url ->
            ( { model | selected = Just url }, Cmd.none )

        SurpriseMe ->
            let
                randomPhotoPicker =
                    Random.int 0 (List.length model.photos - 1)
            in
                ( model, Random.generate SelectByIndex randomPhotoPicker )

        SelectByIndex index ->
            ( { model | selected = newSelected index model.photos }, Cmd.none )

        ChangeSize size ->
            ( { model | chosenSize = size }, Cmd.none )


view : Model -> Html.Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ Html.text "Photo Groove" ]
        , button [ onClick SurpriseMe ] [ text "Surprise me!!!" ]
        , h3 [] [ text "Thumbnail Size:" ]
        , div [ id "choose-size" ] (viewSizesChooser model.chosenSize)
        , div [ id "thumbnails", class (sizeToString model.chosenSize) ] (List.map (viewThumbnail model.selected) model.photos)
        , viewLarge model.selected
        ]


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = ( initialModel, Cmd.none )
        , update = update
        , subscriptions = (\model -> Sub.none)
        }
