# frozen_string_literal: true

require_relative "lib/gemwork/version"

Gem::Specification.new do |spec|
  spec.name = "gemwork"
  spec.version = Gemwork::VERSION
  spec.authors = ["Paul DobbinSchmaltz"]
  spec.email = ["p.dobbinschmaltz@icloud.com"]

  spec.summary = "Common gem framework code used by pdobb's Ruby Gems."
  spec.description = "Gemwork is an abstract framework used by pdobb's Ruby Gems."
  spec.homepage = "https://github.com/pdobb/gemwork"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/pdobb/gemwork/issues",
    "changelog_uri" => "https://github.com/pdobb/gemwork/releases",
    "source_code_uri" => "https://github.com/pdobb/gemwork",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true",
  }

  # Specify which files should be added to the gem when it is released.
  spec.files =
    Dir.glob(
      %w[
        CHANGELOG.md
        LICENSE.txt
        README.md
        {exe,lib}/**/*
      ],
      File::FNM_DOTMATCH,
    ).reject { |f| File.directory?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"

  # Console/Debug
  spec.add_dependency "debug"
  spec.add_dependency "irb"

  # Documentation
  spec.add_dependency "yard"

  # Unit Testing
  spec.add_dependency "minitest"
  spec.add_dependency "minitest-reporters"
  spec.add_dependency "much-stub"
  spec.add_dependency "simplecov"

  # Linters
  spec.add_dependency "reek"
  spec.add_dependency "rubocop"
  spec.add_dependency "rubocop-minitest"
  spec.add_dependency "rubocop-performance"
  spec.add_dependency "rubocop-rake"
end
