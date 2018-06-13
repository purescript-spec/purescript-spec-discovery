module Test.Spec.Discovery (discover) where

import Prelude

import Data.Traversable (sequence_)
import Effect (Effect)
import Test.Spec (Spec)

foreign import getSpecs :: String
                        -> Effect (Array (Spec Unit))

discover :: String
         -> Effect (Spec Unit)
discover pattern = getSpecs pattern >>= (pure <<< sequence_)
