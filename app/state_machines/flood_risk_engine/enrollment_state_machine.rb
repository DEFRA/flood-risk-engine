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
      event :go_forward, WorkFlow.for(:start).merge(
        if: -> { target.org_type.nil? }
      )
      event :go_back, WorkFlow.for(:start).invert.merge(
        if: -> { target.org_type.nil? }
      )

      event :go_forward, WorkFlow.for(:local_authority).merge(
        if: -> { target.org_type == "local_authority" }
      )
      event :go_back, WorkFlow.for(:local_authority).invert.merge(
        if: -> { target.org_type == "local_authority" }
      )

      event :go_forward, WorkFlow.for(:limited_company).merge(
        if: -> { target.org_type == "limited_company" }
      )
      event :go_back, WorkFlow.for(:limited_company).invert.merge(
        if: -> { target.org_type == "limited_company" }
      )

      event :go_forward, WorkFlow.for(:limited_liability_partnership).merge(
        if: -> { target.org_type == "limited_liability_partnership" }
      )
      event :go_back, WorkFlow.for(:limited_liability_partnership).invert.merge(
        if: -> { target.org_type == "limited_liability_partnership" }
      )

      event :go_forward, WorkFlow.for(:individual).merge(
        if: -> { target.org_type == "individual" }
      )
      event :go_back, WorkFlow.for(:individual).invert.merge(
        if: -> { target.org_type == "individual" }
      )

      event :go_forward, WorkFlow.for(:partnership).merge(
        if: -> { target.org_type == "partnership" }
      )
      event :go_back, WorkFlow.for(:partnership).invert.merge(
        if: -> { target.org_type == "partnership" }
      )

      event :go_forward, WorkFlow.for(:other).merge(
        if: -> { target.org_type == "other" }
      )
      event :go_back, WorkFlow.for(:other).invert.merge(
        if: -> { target.org_type == "other" }
      )
    end
  end
end
