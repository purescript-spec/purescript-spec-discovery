module Test.Spec.DiscoverySpec where

import Prelude
import Test.Spec (Spec, describe, it)

spec :: Spec Unit
spec =
  describe "discovery" do
    it "discovers the specs in this project" $ pure unit
