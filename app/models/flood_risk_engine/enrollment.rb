module FloodRiskEngine
  class Enrollment < ActiveRecord::Base
    class StateMachineError < StandardError; end
    # We don't define the inverse relationship of applicant_contact as, in WEX at least,
    # we query never from contact to its enrollment
    belongs_to :applicant_contact, class_name: "Contact"

    serialize :step_history, Array

    before_validation :preserve_current_step

    validates(
      :step,
      inclusion: {
        in: EnrollmentStateMachine.defined_states,
        message: "not defined in EnrollmentStateMachine"
      },
      allow_nil: true
    )

    def business_type
      :foo
    end

    def current_step
      state.to_s
    end

    def set_step_as(step)
      restore!(step)
    end

    def rollback_to(step)
      rollback_valid_with? step
      set_step_as step
      self.step_history = step_history.take_while {|s| s != step.to_sym}
    end

    def previous_step?(step)
      step_history.last == step.to_sym
    end

    def state_machine
      @state_machine ||= initiate_state_machine
    end
    delegate(
      :next_step, :state, :restore!,
      to: :state_machine
    )

    private
    def initiate_state_machine
      state_machine = EnrollmentStateMachine.new
      state_machine.target(self)
      state_machine.restore!(step) if step?
      state_machine
    end

    def preserve_current_step
      self.step = current_step
    end

    def rollback_valid_with?(step)
      return if step_history.include?(step.to_sym)
      raise StateMachineError, "Cannot rollback to step unless in history"
    end
  end
end
