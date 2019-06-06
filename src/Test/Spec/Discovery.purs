module Test.Spec.Discovery (discover) where

import Prelude

import Data.Traversable (sequence_)
import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)
import Test.Spec (Spec)

foreign import getSpecs :: String
                        -> Effect (Array (Spec Unit))

discover :: forall m. MonadEffect m => String
         -> m (Spec Unit)
discover pattern = getSpecs pattern >>= (pure <<< sequence_) # liftEffect
