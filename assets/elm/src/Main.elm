module Main exposing (main)

import Html exposing (Html)
import Messages exposing (Msg(..))
import Model exposing (..)
import Ports
import Update exposing (update)
import View exposing (view)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


initialModel : Model
initialModel =
    { subscribeForm =
        Editing
            { fullName = ""
            , email = ""
            , recaptchaToken = Nothing
            }
    }


init : ( Model, Cmd Msg )
init =
    initialModel ! [ Ports.initRecaptcha "recaptcha" ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Ports.setRecaptchaToken SetRecaptchaToken ]
