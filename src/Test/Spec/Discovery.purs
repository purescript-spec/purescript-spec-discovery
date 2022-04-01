module Test.Spec.Discovery (discover) where

import Prelude

import Control.Promise (Promise)
import Control.Promise as Promise
import Data.Traversable (sequence_)
import Effect (Effect)
import Effect.Aff.Class (class MonadAff, liftAff)
import Test.Spec (Spec)

foreign import getSpecs
  :: String
  -> Effect (Promise (Array (Spec Unit)))

discover
  :: forall m
   . MonadAff m
  => String
  -> m (Spec Unit)
discover pattern = getSpecs pattern # Promise.toAffE >>= (pure <<< sequence_) # liftAff
