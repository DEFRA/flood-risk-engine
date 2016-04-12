module FloodRiskEngine
  class Enrollment < ActiveRecord::Base
    DEFAULT_STATE_MACHINE = EnrollmentStateMachine

    class << self
      attr_writer :state_machine_class
      def state_machine_class
        @state_machine_class ||= DEFAULT_STATE_MACHINE
      end
    end

    # We don't define the inverse relationship of applicant_contact as, in WEX at least,
    # we query never from contact to its enrollment
    belongs_to :applicant_contact, class_name: "Contact"

    serialize :step_history, Array

    before_validation :preserve_current_step

    # Have to use `validate` as `validates` is called on page load, before
    # the state machine class can be switched, and therefore is always run on the
    # default state machine. 'validate' calls the method on the instance so
    # can be run after the state machine class has been changed
    validate :step_defined_in_state_machines

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
      state_machine = state_machine_class.new
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

    def state_machine_class
      self.class.state_machine_class
    end

    def step_defined_in_state_machines
      return true if state_machine_class.defined_states.include? step.to_s
      errors.add(:step, "#{step} is not defined in #{state_machine_class}")
    end
  end
end
