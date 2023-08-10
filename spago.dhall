{ name = "spec-discovery"
, repository = "https://github.com/purescript-spec/purescript-spec-discovery.git"
, license = "MPL-2.0"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "effect"
  , "foldable-traversable"
  , "prelude"
  , "spec"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
