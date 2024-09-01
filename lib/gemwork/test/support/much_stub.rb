# frozen_string_literal: true

require "much-stub"

# Augment the existing ActiveSupport::TestCase class.
class ActiveSupport::TestCase
  after do
    MuchStub.unstub!
  end
end
