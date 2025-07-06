# frozen_string_literal: true

require "minitest/reporters"

Minitest::Test.make_my_diffs_pretty!

reporter_options = { color: true }
# Minitest::Reporters.use!(
#   Minitest::Reporters::DefaultReporter.new(reporter_options))

Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new(reporter_options),
)
