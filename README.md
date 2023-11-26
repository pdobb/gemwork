# Gemwork

Gemwork is an abstract framework used by [pdobb](https://github.com/pdobb)'s Ruby Gems.

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

# Load additional tasks defined by Gemwork.
Gem::Specification.find_by_name("gemwork").tap do |gemspec|
  Rake.load_rakefile("#{gemspec.gem_dir}/lib/tasks/Rakefile")
end
```

Running `rake -T` after this will reveal the additional tasks defined by Gemwork just as if they were defined within your project.

## Rubocop Integration
### Simple Usage

Add the following to the `.rubocop.yml` file in your gem:

```yaml
# .rubocop.yml

inherit_gem:
  gemwork: lib/rubocop/.rubocop.yml
```

### Advanced Usage

The above (simple usage) will automatically includes all RuboCop configuration settings defined in Gemwork. You can, however, require individual cop definitions piecemeal:

```yaml
# .rubocop.yml

# Load Rubocop plugins.
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
    - lib/rubocop/naming.yml
    - lib/rubocop/style.yml
```

See also: [RuboCop's Configuration Guide on Inheritance](https://github.com/rubocop/rubocop/blob/master/docs/modules/ROOT/pages/configuration.adoc#inheriting-configuration-from-a-dependency-gem).

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

## Gem Dependencies

Gemwork depends on the following gems. None of these are actually used by Gemwork, itself, but are included for use by child gems. This is meant to ease dependency management for child gems as these things evolve over time.

#### Unit Testing
- [minitest](https://github.com/minitest/minitest)
- [minitest-reporters](https://github.com/minitest-reporters/minitest-reporters) -- Create customizable MiniTest output formats.
- [much-stub](https://github.com/redding/much-stub) -- Stubbing API for replacing method calls on objects in test runs.
- [simplecov](https://github.com/simplecov-ruby/simplecov) -- Code coverage for Ruby.

#### Linters
- [reek](https://github.com/troessner/reek) -- Code smell detector for Ruby.
- [rubocop](https://github.com/rubocop/rubocop)  -- A Ruby static code analyzer and formatter, based on the community Ruby style guide.
- [rubocop-minitest](https://github.com/rubocop/rubocop-minitest) -- Code style checking for Minitest files.
- [rubocop-performance](https://github.com/rubocop/rubocop-performance/) -- An extension of RuboCop focused on code performance checks.
- [rubocop-rake](https://github.com/rubocop/rubocop-rake) -- A RuboCop plugin for Rake.
- [yard](https://github.com/lsegal/yard) -- YARD is a Ruby Documentation tool. The Y stands for "Yay!".

## Development

Development of Gemwork often requires making updates to its code and then testing them in another child gem that uses Gemwork.

Even if the child gem already has the `gemwork` gem installed from RubyGems, local changes to Gemwork can be compiled and installed as a local gem, which the child gem will then immediately utilize. To facilitate this, it is recommended to add this compile/local-install step to the child gem's `bin/setup` executable:

```bash
# Example ./bin/setup for your child gem:

#!/usr/bin/env bash

# Recompile and install Gemwork locally.
if [ -n "$REBUILD_GEMWORK" ]; then
  ( cd ~/dev/gemwork && bin/setup && rake install:local )
fi

set -euo pipefail
IFS=$'\n\t'
set -vx

bundle install

# Do any other automated setup that you need to do here
```

With the above, you can opt in to using a locally built and installed Gemwork gem from your child gem:

```bash
REBUILD_GEMWORK=1 bin/setup
```

### Releases

To release a new version of Gemwork to RubyGems:

1. Update the version number in `version.rb`
2. Update `CHANGELOG.md`
3. Run `rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pdobb/gemwork. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/pdobb/gemwork/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gemwork project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pdobb/gemwork/blob/master/CODE_OF_CONDUCT.md).
