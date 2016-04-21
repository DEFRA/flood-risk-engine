module FloodRiskEngine
  # State machine using FiniteMachine
  #
  # This class defines the methods that are used to trigger a transition
  # from one state to another. There are some restrictions as to how much
  # this object can be modified. For example, instance methods are ignored
  # within definitions. Therefore, additional methods that cannot be easily
  # added to this object, are instead defined in the wrapper StepMachine.
  #
  # See finite_machine README for usage information:
  #   https://github.com/piotrmurach/finite_machine
  require "finite_machine"
  class EnrollmentStateMachine < FiniteMachine::Definition
    initial :check_location

    events do
      event :go_forward, WorkFlow.for(:local_authority)
      event :go_back, WorkFlow.for(:local_authority).invert
    end
  end
end
