# Gemwork

[![Gem Version](https://img.shields.io/github/v/release/pdobb/gemwork)](https://img.shields.io/github/v/release/pdobb/gemwork)

Gemwork is an abstract framework used by [pdobb](https://github.com/pdobb)'s Ruby Gems.

Support for Rails applications is also included, but not as the automatic default. See the "Rails" subheadings in the below sections.

## Installation

Add this line to your `my_gem.gemspec` file:

```ruby
spec.add_development_dependency "gemwork"
```

And then execute:

```bash
bundle

# OR

bin/setup
```

## Rake Integration

Gemwork provides a number of additional Rake tasks that can be integrated into your project.

Create file: `./rakelib/gemwork.rake`
(If the `rakelib` directory doesn't exist, create it at the project root.)

```ruby
# frozen_string_literal: true

spec = Gem::Specification.find_by_name("gemwork")

# Load additional tasks defined by Gemwork.
Dir.glob(
  Pathname.new(spec.gem_dir).
    join("lib", "tasks", "{util,rubocop,reek,test}.rake")) do |task|
  load(task)
end

# Redefine the default `rake` task.
Rake::Task["default"].clear
task :default do
  run_tasks(%i[
    test
    rubocop
    reek
  ])
end
```

Running `rake -T` after this will reveal the additional tasks defined by Gemwork just as if they were defined within your project.

### Rails

For a Rails project, you may need to conditionally run the above by returning early unless the current environment is development. Further, you may want to include other gems & their rake tasks, such as: `erb_lint`, `eslint`, `prettier`, `brakeman`, and `test:system`.

```ruby
# frozen_string_literal: true

return unless Rails.env.development?

spec = Gem::Specification.find_by_name("gemwork")

# Load additional tasks defined by Gemwork.
Dir.glob(
  Pathname.new(spec.gem_dir).join(
    "lib/tasks",
    "{util,rubocop,erb_lint,reek,eslint,prettier,brakeman}.rake")) do |task|
  load(task)
end

# Redefine the default `rake` task.
Rake::Task["default"].clear
task :default do
  run_tasks(%i[
    test
    rubocop
    erb_lint
    reek
    eslint
    prettier
    brakeman
    test:system
  ])
end
```

## RuboCop Integration

### Simple Usage

Add the following to the `.rubocop.yml` file in your gem:

```yaml
# .rubocop.yml

inherit_gem:
  gemwork: lib/rubocop/.rubocop-gems.yml
```

#### Rails

Or, for a Rails project, add the following to the `.rubocop.yml` file in your project:

```yaml
# .rubocop.yml
require:
  - rubocop-rake
  - rubocop-minitest
  - rubocop-performance

inherit_gem:
  gemwork: lib/rubocop/.rubocop-rails.yml
```

### Advanced Usage

The above (simple usage) will automatically includes all RuboCop configuration settings defined in Gemwork. You can, however, require individual cop definitions piecemeal:

```yaml
# .rubocop.yml

# Load RuboCop plugins.
require:
  - rubocop-rake
  - rubocop-minitest
  - rubocop-performance

# Load Cops configuration by Department.
inherit_gem:
  gemwork:
    - lib/rubocop/all_cops.yml
    - lib/rubocop/gemspec.yml
    - lib/rubocop/layout.yml
    - lib/rubocop/lint.yml
    - lib/rubocop/metrics.yml
    - lib/rubocop/minitest.yml
    - lib/rubocop/naming.yml
    - lib/rubocop/performance.yml
    - lib/rubocop/style.yml

# Override values from gemwork's lib/rubocop/all_cops.yml config.
AllCops:
  TargetRubyVersion: 3.4
```

See also: [RuboCop's Configuration Guide on Inheritance](https://github.com/rubocop/rubocop/blob/master/docs/modules/ROOT/pages/configuration.adoc#inheriting-configuration-from-a-dependency-gem).

#### Rails

```yaml
# .rubocop.yml

# Load RuboCop plugins.
require:
  - rubocop-capybara
  - rubocop-minitest
  - rubocop-performance
  - rubocop-rake
  - rubocop-rails

# Load Cops configuration by Department.
inherit_gem:
  gemwork:
    - lib/rubocop/all_cops.yml
    - lib/rubocop/layout.yml
    - lib/rubocop/lint.yml
    - lib/rubocop/metrics.yml
    - lib/rubocop/minitest.yml
    - lib/rubocop/naming.yml
    - lib/rubocop/performance.yml
    - lib/rubocop/rails.yml
    - lib/rubocop/style.yml

# Override values from gemwork's lib/rubocop/all_cops.yml config.
AllCops:
  TargetRubyVersion: 3.4
  Exclude:
    - bin/bundle
```

## Reek

The reek gem doesn't support config files integration. But recommended starting configs have been placed in [lib/reek/](https://github.com/pdobb/gemwork/blob/master/lib/reek). One for gems and one for Rails projects.

## Testing Support

The following requires may be added to `./test/test_helper.rb` to simplify test configuration. These requires support the gem dependencies mentioned in the following section.

```ruby
# frozen_string_literal: true

require "gemwork/test/support/simplecov"

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "say"

require "minitest/autorun"

require "gemwork/test/support/reporters"
require "gemwork/test/support/much_stub"
require "gemwork/test/support/spec_dsl"

# ...
```

## Other Setup

### Rails

For a Rails app, additional configuration may be desired to improve linter support.

#### eslint

The below fixes eslint linting errors in Rails (7+, ...) projects.

```json
// .eslintrc.json

{
  "env": {
    "browser": true,
    "es2021": true
  },
  "extends": ["eslint:recommended", "plugin:prettier/recommended"],
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module"
  },
  "globals": {
    "Turbo": "readonly"
  }
}
```

#### prettier

General config recommendations for prettier:

```
# .prettierignore

vendor
```

```json
// .prettierrc.json

{
  "semi": false
}
```

## Gem Dependencies

Gemwork depends on the following gems. None of these are actually used by Gemwork, itself, but are included for use by child gems. This is meant to ease dependency management for child gems as these things evolve over time.

#### Unit Testing

- [minitest](https://github.com/minitest/minitest)
- [minitest-reporters](https://github.com/minitest-reporters/minitest-reporters) -- Create customizable MiniTest output formats.
- [much-stub](https://github.com/redding/much-stub) -- Stubbing API for replacing method calls on objects in test runs.
- [simplecov](https://github.com/simplecov-ruby/simplecov) -- Code coverage for Ruby.

#### Linters

- [reek](https://github.com/troessner/reek) -- Code smell detector for Ruby.
- [rubocop](https://github.com/rubocop/rubocop) -- A Ruby static code analyzer and formatter, based on the community Ruby style guide.
- [rubocop-minitest](https://github.com/rubocop/rubocop-minitest) -- Code style checking for Minitest files.
- [rubocop-performance](https://github.com/rubocop/rubocop-performance/) -- An extension of RuboCop focused on code performance checks.
- [rubocop-rake](https://github.com/rubocop/rubocop-rake) -- A RuboCop plugin for Rake.

#### Documentation

- [yard](https://github.com/lsegal/yard) -- YARD is a Ruby Documentation tool. The Y stands for "Yay!".

### Rails

For Rails projects, you may want to manually install additional gems as well:

#### Linters

- [rubocop-rails](https://github.com/rubocop/rubocop-rails) -- A RuboCop extension focused on enforcing Rails best practices and coding conventions.
- [rubocop-capybara](https://github.com/rubocop/rubocop-capybara) -- Code style checking for Capybara files.

## Development

Development of Gemwork often requires making updates to its code and then testing them in another child gem that uses Gemwork.

Even if the child gem already has the `gemwork` gem installed from RubyGems, local changes to Gemwork can be compiled and installed as a local gem, which the child gem will then immediately utilize. Here is a macro to facilitate this (just update the path to match your gemwork source directory):

```bash
alias gemworkr!='cd ~/dev/gemwork && bin/setup && rake install:local && cd -'
```

### Testing

To test this gem:

```bash
rake
```

#### Linters

```bash
rubocop

reek

npx prettier . --check
npx prettier . --write
```

### Releases

To release a new version of this gem to RubyGems:

1. Update the version number in `version.rb`
2. Update `CHANGELOG.md`
3. Run `bundle` to update Gemfile.lock with the latest version info
4. Commit the changes. e.g. `Bump to vX.Y.Z`
5. Run `rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pdobb/gemwork. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/pdobb/gemwork/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gemwork project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pdobb/gemwork/blob/master/CODE_OF_CONDUCT.md).
