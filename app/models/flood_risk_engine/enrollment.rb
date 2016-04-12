module FloodRiskEngine
  class Enrollment < ActiveRecord::Base
    # We don't define the inverse relationship of applicant_contact as, in WEX at least,
    # we query never from contact to its enrollment
    belongs_to :applicant_contact, class_name: "Contact"

    before_validation :preserve_current_step

    def current_step
      state_machine_state.to_s
    end

    def next_step
      state_machine_next_step
      save
    end

    def set_step_as(step)
      state_machine_restore!(step)
      save!
    end

    def state_machine
      @state_machine ||= initiate_state_machine
    end
    delegate(
      :next_step, :state, :restore!, :states,
      to: :state_machine,
      prefix: true
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
