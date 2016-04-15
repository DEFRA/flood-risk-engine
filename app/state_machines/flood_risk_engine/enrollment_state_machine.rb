# State machine using FiniteMachine
# https://github.com/piotrmurach/finite_machine
require "finite_machine"
# Turning off Style/HashSyntax as `:step1 => :step2` describes the flow
# better than `step1: :step2`
# rubocop:disable Style/HashSyntax
module FloodRiskEngine
  class EnrollmentStateMachine < FiniteMachine::Definition
    initial :check_location
      
    events do
      event :go_forward, WorkFlow.for(:local_authority)
      event :go_back, WorkFlow.for(:local_authority).invert
    end
  end
end
# rubocop:enable Style/HashSyntax
