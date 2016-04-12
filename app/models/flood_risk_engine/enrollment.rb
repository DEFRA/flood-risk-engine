module FloodRiskEngine
  class Enrollment < ActiveRecord::Base
    # We don't define the inverse relationship of applicant_contact as, in WEX at least,
    # we query never from contact to its enrollment
    belongs_to :applicant_contact, class_name: "Contact"

    before_validation :preserve_current_step

    def business_type
      :foo
    end

    def current_step
      state.to_s
    end

    def set_step_as(step)
      restore!(step)
    end

    def state_machine
      @state_machine ||= initiate_state_machine
    end
    delegate(
      :next_step, :state, :restore!,
      to: :state_machine
    )

    validates(
      :step,
      inclusion: {
        in: EnrollmentStateMachine.defined_states,
        message: "not defined in EnrollmentStateMachine"
      },
      allow_nil: true
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
  end
end
