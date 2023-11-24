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

## Development

Development of Gemwork often requires making updates to its code and then testing them in another child gem that uses Gemwork.

Even if the child gem already has the `gemwork` gem installed from RubyGems, local changes to Gemwork can be compiled and installed as a local gem, which the child gem will then immediately utilize. To facilitate this, it is recommended to add this compile/local-install step to the child gem's `bin/setup` executable:

```bash
# ./bin/setup for your child gem:

# ...

# Recompile and install Gemwork locally.
( cd ~/dev/gemwork && rake install:local )

# The above code should be placed above this line in your bin/setup:
bundle install

# ...
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
