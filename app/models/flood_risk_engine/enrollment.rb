module FloodRiskEngine
  class Enrollment < ActiveRecord::Base
    extend Concerns::StateMachineSwitcher
    self.default_state_machine = EnrollmentStateMachine

    # We don't define the inverse relationship of applicant_contact as, in WEX at least,
    # we query never from contact to its enrollment
    belongs_to :applicant_contact, class_name: "Contact"
    belongs_to :organisation
    belongs_to :site_address, class_name: "Address"

    has_many :enrollment_exemptions, foreign_key: :enrollment_id,
             dependent: :restrict_with_exception
    accepts_nested_attributes_for :enrollment_exemptions

    has_many :exemptions, through: :enrollment_exemptions, dependent: :restrict_with_exception
    accepts_nested_attributes_for :exemptions

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

    def state_machine
      @state_machine ||= StepMachine.new(
        host: self,
        state_machine_class: self.class.state_machine_class
      )
    end
    delegate(
      :next_step, :current_step, :set_step_as, :rollback_to, :previous_step?,
      :next_step?, :state_machine_class, :defined_steps, :go_back, :go_back!,
      to: :state_machine
    )

    private
    def preserve_current_step
      self.step = current_step
    end

    def step_defined_in_state_machines
      return true if defined_steps.include? step.to_s
      errors.add(:step, "#{step} is not defined in #{state_machine_class}")
    end
  end
end
