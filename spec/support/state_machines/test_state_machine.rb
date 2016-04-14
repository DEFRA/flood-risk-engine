# State machine using FiniteMachine
# https://github.com/piotrmurach/finite_machine
require "finite_machine"
# rubocop:disable Style/HashSyntax
module FloodRiskEngine
  class TestStateMachine < FiniteMachine::Definition
    initial :step1

    module WorkFlow
      extend self

      def foo
        {
          :step1 => :step2,
          :step2 => :step3
        }
      end

      def bar
        {
          :step1 => :step3
        }
      end
    end

    events do
      event :next_step,
        WorkFlow.foo.merge(
          if: -> { target.business_type == :foo }
        )

      event :next_step,
        WorkFlow.bar.merge(
          if: -> { target.business_type == :bar }
        )

      event :go_back,
        WorkFlow.foo.invert.merge(
          if: -> { target.business_type == :foo }
        )

      event :go_back,
        WorkFlow.bar.invert.merge(
          if: -> { target.business_type == :bar }
        )
    end
  end
end
# rubocop:enable Style/HashSyntax
