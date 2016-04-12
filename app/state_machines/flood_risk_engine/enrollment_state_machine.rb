# rubocop:disable Style/HashSyntax
require "finite_machine"
module FloodRiskEngine
  class EnrollmentStateMachine < FiniteMachine::Definition
    initial :step1

    events do
      event :next_step, if: -> { target.business_type == :foo },
        :step1 => :step2,
        :step2 => :step3

      event :next_step, if: -> { target.business_type == :bar },
        :step1 => :step3
    end

    def self.defined_states
      new.states.collect(&:to_s)
    end
  end
end
# rubocop:enable Style/HashSyntax
