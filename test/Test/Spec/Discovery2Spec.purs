module Test.Spec.Discovery2Spec where

import Prelude
import Test.Spec (Spec, describe, it)

spec :: Spec Unit
spec =
  describe "discovery" do
    it "discovers the specs again in this project" $ pure unit
