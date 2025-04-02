# frozen_string_literal: true

# Use #given to setup the prerequisites/context of a set of test examples.
#
# @example
#   describe "#<method_name>" do
#     given "<condition>" do
#       before { <setup condition here> }
#
#       it "<result>" do
#         _(subject.<method_name>).must_equal(<result>)
#       end
#
#       it ...
#     end
#   end
#
#   # => <...Test>::#<method_name>::GIVEN <description>...
def given(description, ...) = describe("GIVEN #{description}", ...)

def context(...) = describe(...)
