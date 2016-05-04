require "finite_machine"
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

  class EnrollmentStateMachine < FiniteMachine::Definition
    initial :check_location

    events do
      event :go_forward, WorkFlow.for(:start).merge(
        if: -> { target.org_type.nil? }
      )
      event :go_back, WorkFlow.for(:start).invert.merge(
        if: -> { target.org_type.nil? }
      )

      [
        :local_authority,
        :limited_company,
        :limited_liability_partnership,
        :individual,
        :partnership,
        :other
      ].each do |org_type|
        steps = WorkFlow.for(org_type)
        criteria = -> { target.org_type == org_type.to_s }

        event :go_forward, steps.merge(if: criteria)
        event :go_back, steps.invert.merge(if: criteria)
      end
    end
  end
end
