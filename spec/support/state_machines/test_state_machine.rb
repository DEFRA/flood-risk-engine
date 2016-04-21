# State machine using FiniteMachine
# https://github.com/piotrmurach/finite_machine
require "finite_machine"
module FloodRiskEngine
  class TestStateMachine < FiniteMachine::Definition
    initial :step1

    module WorkFlow
      extend self

      def steps
        [:step1, :step2, :step3]
      end

      def foo
        {
          steps[0] => steps[1],
          steps[1] => steps[2]
        }
      end

      def bar
        {
          steps[0] => steps[2]
        }
      end
    end

    events do
      event :go_forward,
            WorkFlow.foo.merge(
              if: -> { target.business_type == :foo }
            )

      event :go_forward,
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
