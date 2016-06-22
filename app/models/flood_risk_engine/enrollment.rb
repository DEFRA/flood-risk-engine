require_dependency "has_secure_token"

module FloodRiskEngine
  class Enrollment < ActiveRecord::Base
    extend Concerns::StateMachineSwitcher
    self.default_state_machine = EnrollmentStateMachine

    has_secure_token

    # We don't define the inverse relationship of applicant_contact as, in WEX at least,
    # we query never from contact to its enrollment
    belongs_to :applicant_contact, class_name: "Contact"
    belongs_to :organisation
    delegate :org_type, :partners, to: :organisation, allow_nil: true

    has_many :enrollment_exemptions,
             foreign_key: :enrollment_id,
             dependent: :restrict_with_exception
    has_many :exemptions,
             through: :enrollment_exemptions,
             dependent: :restrict_with_exception

    # The Correspondence Contact Details related to this Application a.k.a Main Contact
    belongs_to :correspondence_contact, class_name: "Contact"

    belongs_to :secondary_contact, class_name: "Contact"

    has_one(
      :exemption_location,
      class_name: :Location,
      as: :locatable,
      dependent: :restrict_with_exception
    )

    has_one :address_search

    serialize :step_history, Array

    before_validation :preserve_current_step

    # Have to use `validate` as `validates` is called on page load, before
    # the state machine class can be switched, and therefore is always run on the
    # default state machine. 'validate' calls the method on the instance so
    # can be run after the state machine class has been changed
    validate :step_defined_in_state_machines

    after_create :generate_and_save_reference_number

    def to_param
      token
    end

    def business_type
      :foo
    end

    def state_machine
      @state_machine ||= StepMachine.new(
        target: self,
        state_machine_class: self.class.state_machine_class,
        step: (step? && step)
      )
    end
    delegate(
      :go_forward, :current_step, :set_step_as, :rollback_to, :previous_step?,
      :previous_step, :next_step, :next_step?, :state_machine_class,
      :defined_steps, :initial_step, :go_back, :go_back!, :can?,
      to: :state_machine
    )

    enum status: {
      building: 0,        # FO: anywhere before the confirmation step
      pending: 1,         # FO: enrollment submitted and awaiting BO processing
      being_processed: 2, # BO: prevents another admin user from processing it
      approved: 3,        # BO: all checks pass
      rejected: 4,        # BO: because e.g. grid ref in an SSI
      expired: 5,         # BO: FRA23/24 only - expiry date has passed
      withdrawn: 6        # BO: used to hide anything created in error
    }

    def submit
      return if submitted_at.present?
      self.submitted_at = Time.zone.now
      pending!
    end

    private

    # The reference_number in the agreed format "<id with up to 6 zero padded digits>"
    # e.g. T.B.D
    def generate_and_save_reference_number
      return if reference_number?
      update_column(:reference_number, sprintf("%06d", id))
    end

    def preserve_current_step
      self.step = current_step
    end

    def step_defined_in_state_machines
      return true if defined_steps.include? step.to_s
      errors.add(:step, "#{step} is not defined in #{state_machine_class}")
    end
  end
end
