# rubocop:disable Style/HashSyntax
require "finite_machine"
module FloodRiskEngine
  class EnrollmentStateMachine < FiniteMachine::Definition
    initial :step1

    events do
      event :next_step, :step1 => :step2,
                        :step2 => :step3
    end

    def self.defined_states
      new.states.collect(&:to_s)
    end
  end
end
# rubocop:enable Style/HashSyntax
