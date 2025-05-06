module Test.Spec.Discovery
  ( discover
  , discoverAndRunSpecs
  ) where

import Prelude

import Data.Traversable (sequence_)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Aff.Class (class MonadAff, liftAff)
import Effect.Aff.Compat (EffectFn1, EffectFnAff, fromEffectFnAff, runEffectFn1)
import Effect.Class (liftEffect)
import Test.Spec (Spec, describe)
import Test.Spec.Runner (Reporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)

foreign import getSpecs :: EffectFn1 String (EffectFnAff (Array { name :: String, spec :: Spec Unit }))

discover :: ∀ m. MonadAff m => String -> m (Spec Unit)
discover pattern = do
  runDiscover <- liftEffect $ runEffectFn1 getSpecs pattern
  specs <- liftAff $ fromEffectFnAff runDiscover
  let specsWrappedInDescribe = map (\{ name, spec } -> describe name spec) specs
  pure $ sequence_ specsWrappedInDescribe

discoverAndRunSpecs :: Array Reporter -> String -> Effect Unit
discoverAndRunSpecs reporters pattern = launchAff_ do
  specs <- discover pattern
  liftEffect $ runSpecAndExitProcess reporters specs
