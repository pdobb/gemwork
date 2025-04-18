## [Unreleased]

## [0.7.18] - 2025-4-18

- Disable Metrics/BlockLength cop for `given` blocks in Tests

## [0.7.17] - 2025-4-2

- Revert Rubocop config to ignore all files in the .gitignore spec

## [0.7.16] - 2025-4-1

- Add `given` to test/support/spec_dsl.rb. Similar to `context` but includes "GIVEN " in the test description
- Update Rubocop config to ignore all files in the .gitignore spec

## [0.7.15] - 2025-3-23

- Improve output on error in `rake prettier` task
- Allow `id` as a named parameter in Naming/MethodParameterName

## [0.7.14] - 2025-3-22

- Enable all cops by default + Update config for new additions

## [0.7.13] - 2025-3-15

- Flip style for Layout/DotPosition. Now: `EnforcedStyle: leading`

## [0.7.12] - 2025-3-1

- Fix `brakeman` task to not report on filtered warnings (i.e. ignored warnings)

## [0.7.11] - 2025-2-15
(0.7.10 yanked)

- Minimize `rake brakeman` output when no warnings; return failure otherwise
- Fail on error in Rubocop rake task
- Add documentation to README + example config file for erb_lint

## [0.7.9] - 2025-2-13

- Add rake task for `erb_lint` for Rails apps

## [0.7.8] - 2025-2-12

- Ignore `create` and `update` methods (controller actions) for Metrics/MethodLength cop
- Ignore `safe_join` method calls for Layout/FirstMethodArgumentLineBreak cop
- Don't consider `hash`es in cop: Metrics/ClassLength

## [0.7.7] - 2025-2-4

- Add Rake task for: `brakeman`

## [0.7.6] - 2025-2-1

- Update RuboCop config to allow long lines of deeply namespaced class comments

## [0.7.5] - 2025-1-18

- Fix eslint.rake to actually find/output/fail on eslint errors

## [0.7.4] - 2025-1-4

- Fix typo in Rubocop cop name

## [0.7.3] - 2025-1-4

- Update minimum Ruby version from 3.1 -> 3.2
- Update RuboCop config to exclude db/seeds.rb from a few of the more restrictive Style/Layout/Metrics cops
- Update reek config to altogether exclude db/seeds.rb

## [0.7.2] - 2024-11-22

- Remove auto-detect of ActiveSupport::TestCase vs Minitest::Spec in favor of manual selection of test/support/much_stub.rb vs test/support/much_stub-rails.rb. This fixes incorrect auto-detection of "Rails" env in gems that include a Rails test dummy.

## [0.7.1] - 2024-11-21

- Auto-detect ActiveSupport::TestCase vs Minitest::Spec (rails vs non-rails) in test/support/much_stub.rb.

## [0.7.0] - 2024-11-21

- Update minimum Ruby version from 2.7 -> 3.1
- Update RuboCop Styles

## [0.6.0] - 2024-10-9

- Update RuboCop Styles, especially for Rails projects
- Add Rake tasks for: `eslint` and `prettier`

## [0.5.3] - 2024-9-1

- Fix `MuchStub.unstub!` to actually run after ActiveSupport::TestCase test cases

## [0.5.2] - 2024-8-22

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
