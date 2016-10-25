module Test.Spec.Discovery (discover) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Traversable (sequence_)
import Node.FS (FS)
import Test.Spec (Spec)

foreign import getSpecs :: forall r. String
                        -> Eff (fs :: FS | r) (Array (Spec (fs :: FS | r) Unit))

discover :: forall r. String
         -> Eff (fs :: FS | r) (Spec (fs :: FS | r) Unit)
discover pattern =  getSpecs pattern >>= (pure <<< sequence_)
