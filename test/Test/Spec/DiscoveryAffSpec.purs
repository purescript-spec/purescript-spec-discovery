module Test.Spec.DiscoveryAffSpec where

import Prelude

import Effect.Aff (Aff)
import Test.Spec (describe, it, SpecT)

spec :: SpecT Aff Unit Aff Unit
spec =
  describe "discovery aff" do
    it "discovers the specs in this project" $ pure unit
