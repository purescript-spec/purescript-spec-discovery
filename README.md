# purescript-spec-discovery

purescript-spec-discovery is an extension to
[purescript-spec](https://github.com/owickstrom/purescript-spec) that finds
specs automatically, given a regular expression pattern.

It only works for NodeJS environments, currently.

## Usage

```bash
bower install --save-dev purescript-spec-discovery
```

```purescript
module Test.Main where

import Prelude
import Effect (Effect)
import Test.Spec.Discovery (discover)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (run)

main :: Effect Unit
main = do
  specs <- discover "My\\.Package\\..*Spec" 
  run [consoleReporter] specs
```

All modules that match the regular expression, **and has a definition
`spec :: Spec Unit`**, will be included and run.

## Documentation

Documentation is publised on [Pursuit](https://pursuit.purescript.org/packages/purescript-spec-discovery).

## Contribute

If you have any issues or possible improvements please file them as
[GitHub Issues](https://github.com/owickstrom/purescript-spec-mocha/issues).
Pull requests requests are encouraged.

## License

[Mozilla Public License Version 2.0](LICENSE).
