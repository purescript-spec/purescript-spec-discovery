# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

@srghma Use `spec-node` in tests

## v8.0.1

- @CarstenKoenig Fix discovery on Windows by prepending `file://`

## v8.0.0
Features:
- Update to v0.15.0 and support es modules

Breaking changes:
- `discover` now needs `MonadAff` constraint instead of `MonadEffect` due to dynamic imports returning promises
