# frozen_string_literal: true

require "much-stub"

class Minitest::Spec
  after do
    MuchStub.unstub!
  end
end
