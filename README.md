# purescript-spec-discovery

purescript-spec-discovery is an extension to
[purescript-spec](https://github.com/owickstrom/purescript-spec) that finds
specs automatically, given a regular expression pattern. It only works for
NodeJS environments, currently.

## Usage

```bash
bower install purescript-spec-discovery
```

```purescript
module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Node.FS (FS)
import Node.Process (PROCESS)
import Test.Spec.Discovery (discover)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (run)

main :: Eff (fs :: FS, process :: PROCESS, console :: CONSOLE) Unit
main = discover "My\\.Package\\..*Spec" >>= run [consoleReporter]
```

All modules that match the regular expression, **and has a definition
`spec :: Spec r Unit`**, will be included and run.

## Documentation

Documentation is publised on [Pursuit](https://pursuit.purescript.org/packages/purescript-spec-discovery).

## Contribute

If you have any issues or possible improvements please file them as
[GitHub Issues](https://github.com/owickstrom/purescript-spec-mocha/issues).
Pull requests requests are encouraged.

## License

[Mozilla Public License Version 2.0](LICENSE).
