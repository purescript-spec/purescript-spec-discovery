module Test.Spec.Discovery (discover) where

import Prelude

import Control.Promise (Promise)
import Control.Promise as Promise
import Data.Traversable (sequence_)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (class MonadEffect, liftEffect)
import Test.Spec (Spec)

foreign import getSpecs :: String
                        -> Effect (Promise (Array (Spec Unit)))

discover :: String
         -> Aff (Spec Unit)
discover pattern = getSpecs pattern # Promise.toAffE >>= (pure <<< sequence_)
