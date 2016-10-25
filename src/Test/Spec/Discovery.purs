module Test.Spec.Discovery (discover) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Traversable (sequence_)
import Test.Spec (Spec)

foreign import getSpecs :: forall r. String
                        -> Eff r (Array (Spec r Unit))

discover :: forall r. String
         -> Eff r (Spec r Unit)
discover pattern =  getSpecs pattern >>= (pure <<< sequence_)
