## [Unreleased]

- Exclude `db/migrate/**/*` from `rake reek` runs (for Rails apps).

## [0.5.1] - 2024-3-27

- Disable rubocop-performance's Performance/ArraySemiInfiniteRangeSlice cop due to false positives with Strings.
- Fix example rake tasks list in README for Rails projects.

## [0.5.0] - 2024-3-22

- Add examples for use in Rails projects. See the updated README.
- Spruce up the rubocop config.
  - Now includes all "Disabled"-by-default cops. Most stay disabled, but some are now enabled.
  - No longer includes "Pending"-by-default cops. These are already automatically enabled by the `NewCops: enable` directive.
  - Separate gem-specific from rails-specific cops configuration.
  - Miscellaneous cleanup.

## [0.4.2] - 2024-2-4

- Add finer-grained control of Rake tasks loading/running. See the updated README.

## [0.4.0] - 2024-1-6

- House cleaning for Ruby 3.3.

## [0.3.0] - 2023-11-25

- Use [IRB](https://github.com/ruby/irb) + [debug](https://github.com/ruby/debug) instead of Pry.

## [0.2.0] - 2023-11-25

- Add gem dependencies to Gemwork, to be installed by child gems.
- Add testing support files for more easily setting up and maintaining dependencies in the test/test_helper.rb file of child gems.

## [0.1.1] - 2023-11-24

- Recommend adding a `REBUILD_GEMWORK` flag to README, for use when running `bin/setup` from a child gem.

## [0.1.0] - 2023-11-24

- Initial release
