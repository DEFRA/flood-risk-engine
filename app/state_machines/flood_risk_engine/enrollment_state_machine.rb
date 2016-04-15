# State machine using FiniteMachine
# https://github.com/piotrmurach/finite_machine
require "finite_machine"

module FloodRiskEngine
  class EnrollmentStateMachine < FiniteMachine::Definition
    initial :check_location

    events do
      event :go_forward, WorkFlow.for(:local_authority)
      event :go_back, WorkFlow.for(:local_authority).invert
    end
  end
end
