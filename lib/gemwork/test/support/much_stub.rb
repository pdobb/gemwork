# frozen_string_literal: true

require "much-stub"

if defined?(ActiveSupport::TestCase)
  # Augment the existing ActiveSupport::TestCase class.
  class ActiveSupport::TestCase
    after do
      MuchStub.unstub!
    end
  end
else
  # Augment the existing Minitest::Spec class.
  class Minitest::Spec
    after do
      MuchStub.unstub!
    end
  end
end
