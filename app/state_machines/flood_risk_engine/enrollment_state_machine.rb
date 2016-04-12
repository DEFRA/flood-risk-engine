# A state machine using FiniteMachine
# https://github.com/piotrmurach/finite_machine
#
# Turning off Style/HashSyntax as `:step1 => :step2` describes the flow
# better than `step1: :step2`
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

    callbacks do
      on_enter do |event|
        target.step_history << event.from
      end
    end

    def self.defined_states
      new.states.collect(&:to_s)
    end
  end
end
# rubocop:enable Style/HashSyntax
