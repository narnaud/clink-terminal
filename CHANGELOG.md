# Changelog

## [2.2.3](https://github.com/narnaud/clink-terminal/compare/v2.2.2...v2.2.3) (2026-03-01)


### Documentation

* Document new fzf filters ([9906673](https://github.com/narnaud/clink-terminal/commit/9906673dadc8ae09a111e8482d595ba7e3005973))


### Other

* Deprecate some fzf filter for the new ones in clinj-gizmos ([ceb7b17](https://github.com/narnaud/clink-terminal/commit/ceb7b17c3a0b2031928213e15a510c95a7b22582))
* **deps:** bump 3rdparty/clink-gizmos from `6625eb7` to `4b4512c` ([52d2858](https://github.com/narnaud/clink-terminal/commit/52d28588c98edc6d3c6d62f5714ec187cad3d3f5))
* Fix spelling ([cf5b9ee](https://github.com/narnaud/clink-terminal/commit/cf5b9eef1e6da8155e7dfcf6501f4d2c6618fb24))

## [2.2.2](https://github.com/narnaud/clink-terminal/compare/v2.2.1...v2.2.2) (2026-03-01)


### Other

* Add CODEOWNERS ([1acb47f](https://github.com/narnaud/clink-terminal/commit/1acb47f18f52dd0b15ee73a9ee2fc989fae2ab82))
* Fix codespell issues" ([bb6c1ce](https://github.com/narnaud/clink-terminal/commit/bb6c1ced1a1f4da072d5e4506aae53b21eff4ffc))
* update clink-gizmos ([1643c43](https://github.com/narnaud/clink-terminal/commit/1643c430f2b6960fc3a410ff463b73f8b82ff843))
* update pre-commit (remove json formatter) ([12ff2e5](https://github.com/narnaud/clink-terminal/commit/12ff2e589c64bce569ce0dc866c7aa44e9b227d0))

## [2.2.1](https://github.com/narnaud/clink-terminal/compare/v2.2.0...v2.2.1) (2025-11-24)


### Bug Fixes 🐞

* Fix alias file path (oups!) ([1b6a3ee](https://github.com/narnaud/clink-terminal/commit/1b6a3eeb281841c58f07cdd6d0be7d5213b3eb47))

## [2.2.0](https://github.com/narnaud/clink-terminal/compare/v2.1.4...v2.2.0) (2025-11-21)


### Features ✨

* Add a `cd` alias to `cd /D` (change drive if needed) ([de2b61e](https://github.com/narnaud/clink-terminal/commit/de2b61ece666ad6d267f3e8e6962ed34b768e4c5))
* Change location of aliases files (old one is also kept for compatibility) ([a74ef5b](https://github.com/narnaud/clink-terminal/commit/a74ef5b771049781ba36fbbe332e8faf94338e8e))


### Bug Fixes 🐞

* **title:** Prevents error message with detached HEAD ([18c85c3](https://github.com/narnaud/clink-terminal/commit/18c85c391f2f273c40741d7abc4f51129254b68b))

## [2.1.4](https://github.com/narnaud/clink-terminal/compare/v2.1.3...v2.1.4) (2025-10-12)


### Bug Fixes 🐞

* Fix update-title script to avoid error on new git repo ([d31594d](https://github.com/narnaud/clink-terminal/commit/d31594d8085a91c24d3c8641d015ff35e9e4dbe5))

## [2.1.3](https://github.com/narnaud/clink-terminal/compare/v2.1.2...v2.1.3) (2025-09-26)


### Other 🧰

* Update clink-gizmos ([d540b39](https://github.com/narnaud/clink-terminal/commit/d540b394c4e206d5e11c74f31427621898b1dba3))
* update clink-gizmos and clink-zoxide ([c65de21](https://github.com/narnaud/clink-terminal/commit/c65de21715316c7c4ccf4ad9d54f03fe1b032429))
* update pre-commit hooks ([a9ebc20](https://github.com/narnaud/clink-terminal/commit/a9ebc20a424c6a9c1409eea39fccf54efc377b90))

## [2.1.2](https://github.com/narnaud/clink-terminal/compare/v2.1.1...v2.1.2) (2025-03-28)


### Bug Fixes

* Terminal title should display HEAD if not on branch ([be5c24a](https://github.com/narnaud/clink-terminal/commit/be5c24ac818fdc14364e7fd01dc907583d7e5698))

## [2.1.1](https://github.com/narnaud/clink-terminal/compare/v2.1.0...v2.1.1) (2025-03-23)


### Bug Fixes

* **alias:** We expect a yaml file now, not a json file ([7bf7adb](https://github.com/narnaud/clink-terminal/commit/7bf7adb69c0ec48edaeb9aa2288820260acb794b))

## [2.1.0](https://github.com/narnaud/clink-terminal/compare/v2.0.0...v2.1.0) (2025-03-23)


### Features

* Add preview command ([30e12ad](https://github.com/narnaud/clink-terminal/commit/30e12adc89dde778203dbb46a87eec1d666ba796))

## [2.0.0](https://github.com/narnaud/clink-terminal/compare/v1.1.0...v2.0.0) (2025-03-23)


### ⚠ BREAKING CHANGES

* Use a yaml file for aliases

### Features

* Add image support to fzf-explorer via chafa ([75fcfa2](https://github.com/narnaud/clink-terminal/commit/75fcfa21586ca289a9706bca4e077f286ef77025))
* Add update title script ([0e29cdf](https://github.com/narnaud/clink-terminal/commit/0e29cdf196bc3053998d1e9dda6d37fa469bcc25))
* Suppress drive/header/summary from ls/ll ([598ad4f](https://github.com/narnaud/clink-terminal/commit/598ad4f309890985611bc0e0a3172478f17f5c64))
* Update fzf-git shortcuts ([f8c9b25](https://github.com/narnaud/clink-terminal/commit/f8c9b25df8eeefad1a62798cef29067b36bbb775))


### Code Refactoring

* Use a yaml file for aliases ([17b8ab8](https://github.com/narnaud/clink-terminal/commit/17b8ab8911361d6e8b032ec858a7c46850bc6d57))

## [1.1.0](https://github.com/narnaud/clink-terminal/compare/v1.0.0...v1.1.0) (2025-03-22)


### Features

* Remove clink-completions submodule ([55594c4](https://github.com/narnaud/clink-terminal/commit/55594c4cc221344e5bf9ac54e8ace7adb0976474))
* Remove clink-flex-prompt submodule ([f42a478](https://github.com/narnaud/clink-terminal/commit/f42a478c95634ada5c101f84164c6fb50112de54))
* Remove default prompt ([ba7dc43](https://github.com/narnaud/clink-terminal/commit/ba7dc4370c31a70614439cac3b5547b0aa645c50))
* Update FZF integration to exclude .git directories ([96b85bc](https://github.com/narnaud/clink-terminal/commit/96b85bcec31f0fae3e214901561e439b528e07a9))


### Bug Fixes

* FIx the y starting yazi ([ee32195](https://github.com/narnaud/clink-terminal/commit/ee321958ebf64ec2c12993b5684d014d47e819e8))

## 1.0.0 (2025-03-22)

Initial release
