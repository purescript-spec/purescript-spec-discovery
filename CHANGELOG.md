# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v8.4.2

### Changed
- Fixed issue #41 (discovery failing on Windows) via #42 by @adrian-guevara

## v8.4.1

### Changed
- Every spec is now wrapped in a `describe` call with filename as description. By @srghma #40

## v8.4.0

### Added
- Use `spec-node` in tests by @srghma
- New trivial entrypoint function `discoverAndRunSpecs` for ergonomics by @fsoikin

### Removed
- Reliance on the `aff-promise` library

## v8.0.1

### Changed
- Fix discovery on Windows by prepending `file://` by @CarstenKoenig

## v8.0.0

### Changed
- Update to v0.15.0 and support es modules
- **breaking** `discover` now needs `MonadAff` constraint instead of `MonadEffect` due to dynamic imports returning promises
