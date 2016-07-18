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

  # Allowing hashes to use :symbol => :symbol syntax as expresses flow direction
  # rubocop:disable Style/HashSyntax
  class EnrollmentStateMachine < FiniteMachine::Definition
    initial :add_exemptions

    alias_target :enrollment

    events do
      # -------------------------------------------------------------------
      # Initial steps up to the point where an organisation type is chosen
      event :go_forward, WorkFlow.for(:start).merge(
        if: -> { enrollment.org_type.nil? }
      )
      event :go_back, WorkFlow.for(:start).invert.merge(
        if: -> { enrollment.org_type.nil? }
      )

      # -------------------------------------------------------------------
      # Central part of process where work flow depends on organisation type
      [
        :local_authority,
        :limited_company,
        :limited_liability_partnership,
        :individual,
        :partnership,
        :other,
        :unknown
      ].each do |org_type|
        steps = WorkFlow.for(org_type)
        criteria = -> { enrollment.org_type == org_type.to_s }

        event :go_forward, steps.merge(if: criteria)
        event :go_back, steps.invert.merge(if: criteria)
      end

      # -------------------------------------------------------------------
      # Final section where work flow can go forward to confirmation, but
      # there is no path back from that point.
      event :go_forward, :declaration => :confirmation
    end

    callbacks do
      on_enter(:confirmation) { |_event| SubmitEnrollmentService.new(target).finalize! }
    end

  end
  # rubocop:enable Style/HashSyntax
end
