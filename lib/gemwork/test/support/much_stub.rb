# frozen_string_literal: true

require "much-stub"

# Augment the existing Minitest::Spec class.
class Minitest::Spec
  after do
    MuchStub.unstub!
  end
end
