module MainCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, h1, img)
import Css.Namespace exposing (namespace)


type CssClasses
    = Large
    | Selected
    | Content


type CssIds
    = Page


css =
    (stylesheet << namespace "photogroove")
        [ body
            [ backgroundColor (rgb 44 44 44)
            , color (hex "FAFAFA")
            ]
        , img
            [ property "border" "1px solid white"
            , margin (px 5)
            ]
        , class Large [ width (px 500), float right ]
        , class Selected [ margin (px 0), property "border" "6px solid #60b5cc" ]
        , class Content [ property "margin" "40px auto", width (px 960) ]
        , id "thumbnails" [ width (px 440), float left ]
        , h1 [ fontFamilies [ "Verdana" ], color (hex "60b5cc") ]
        ]


primaryAccentColor =
    hex "ccffaa"
