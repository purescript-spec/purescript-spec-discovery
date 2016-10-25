module Test.Spec.DiscoverySpec where

import Prelude
import Test.Spec (Spec, describe, it)

spec :: forall r. Spec r Unit
spec =
  describe "discovery" do
    it "discovers the specs in this project" $ pure unit
