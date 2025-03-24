module Test.Spec.Discovery
  ( discover
  , discoverAndRunSpecs
  ) where

import Prelude

import Data.Identity (Identity(..))
import Data.Traversable (sequence_)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Aff.Class (class MonadAff, liftAff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Effect.Class (liftEffect)
import Effect.Uncurried (EffectFn2, runEffectFn2)
import Test.Spec (Spec, SpecT, mapSpec)
import Test.Spec.Runner (Reporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess')
import Test.Spec.Runner.Node.Config (defaultConfig)

idToAff :: forall a. Identity a -> Aff a
idToAff (Identity a) = pure a

foreign import getSpecs
  :: EffectFn2 String
       ((Spec Unit) -> SpecT Aff Unit Aff Unit)
       (EffectFnAff (Array (SpecT Aff Unit Aff Unit)))

discover :: ∀ m. MonadAff m => String -> m (SpecT Aff Unit Aff Unit)
discover pattern = do
  runDiscover <- liftEffect $ runEffectFn2 getSpecs pattern (mapSpec idToAff)
  specs <- liftAff $ fromEffectFnAff runDiscover
  pure $ sequence_ specs

discoverAndRunSpecs :: Array Reporter -> String -> Effect Unit
discoverAndRunSpecs reporters pattern = launchAff_ do
  specs <- discover pattern
  liftEffect $ runSpecAndExitProcess' @Aff
    { defaultConfig: defaultConfig
    , parseCLIOptions: true
    }
    reporters
    specs
