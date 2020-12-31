# purescript-spec-discovery

purescript-spec-discovery is an extension to
[purescript-spec](https://github.com/purescript-spec/purescript-spec) that finds
specs automatically, given a regular expression pattern.

It only works for NodeJS environments, currently.

## Usage

```bash
spago install spec-discovery
```

```purescript
module Test.Main where

import Prelude
import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec.Discovery (discover)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (runSpec)

main :: Effect Unit
main = launchAff_ do
  specs <- discover """My\.Package\..*Spec"""
  runSpec [consoleReporter] specs
```

All modules that match the regular expression, **and have a definition
`spec :: Spec Unit`**, will be included and run.

## Documentation

Documentation is publised on [Pursuit](https://pursuit.purescript.org/packages/purescript-spec-discovery).

## Contribute

If you have any issues or possible improvements please file them as
[GitHub Issues](https://github.com/purescript-spec/purescript-spec-discovery/issues).
Pull requests requests are encouraged.

## License

[Mozilla Public License Version 2.0](LICENSE).
