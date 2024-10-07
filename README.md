# purescript-spec-discovery

purescript-spec-discovery is an extension to
[purescript-spec](https://github.com/purescript-spec/purescript-spec) that finds
specs automatically, given a regular expression pattern.

It only works for NodeJS environments, currently, since it's using NodeJS
facilities to list and load modules.

## Usage

Install via Spago:

```bash
spago install spec-discovery
```

Use as main entry point:

```purescript
module Test.Main where

import Prelude
import Effect (Effect)
import Test.Spec.Discovery (discoverAndRunSpec)
import Test.Spec.Reporter.Console (consoleReporter)

main :: Effect Unit
main = discoverAndRunSpecs [consoleReporter] """My\.Package\..*Spec"""
```

Or, if you need more sophistication, like an alternative config or whatnot, use
the `discover` function to just return a list of specs and then run them in
whatever way you need:

```purescript
module Test.Main where

import Prelude
import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec.Discovery (discover)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)
import Test.Spec.Runner.Node.Config (defaultConfig)

main :: Effect Unit
main = launchAff_ do
  specs <- discover """My\.Package\..*Spec"""
  liftEffect $ runSpecAndExitProcess'
    { defaultConfig: defaultConfig { timeout = Nothing }
    , parseCLIOptions: true
    }
    [consoleReporter]
    specs
```

All modules that match the regular expression, **and have a definition
`spec :: Spec Unit`**, will be included and run.

## Contribute

If you have any issues or possible improvements please file them as
[GitHub Issues](https://github.com/purescript-spec/purescript-spec-discovery/issues).
Pull requests requests are encouraged.

## License

[Mozilla Public License Version 2.0](LICENSE).
