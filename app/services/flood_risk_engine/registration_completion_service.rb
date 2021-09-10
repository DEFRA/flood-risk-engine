# frozen_string_literal: true

module FloodRiskEngine
  class RegistrationCompletionService < BaseService
    def run(transient_registration:)
      @transient_registration = transient_registration
      @registration = nil

      @transient_registration.with_lock do
        # This update is necessary as this will make the `with_lock` prevent race conditions
        @transient_registration.update(workflow_state: :creating_registration)

        @registration = Enrollment.new
        transfer_data
        @registration.save!

        @transient_registration.destroy
      end

      @registration
    rescue StandardError => e
      Airbrake.notify(e, reference: @registration&.reference_number) if defined?(Airbrake)
      Rails.logger.error "Completing registration error: #{e}"

      raise e
    end

    private

    def transfer_data
      add_core_data

      add_applicant_contact
      add_correspondence_contact
      add_secondary_contact
      add_organisation

      assign_exemptions
      assign_reference_number
    end

    def add_core_data
      @registration.step = "confirmation"
    end

    def add_applicant_contact; end

    def add_correspondence_contact; end

    def add_secondary_contact; end

    def add_organisation; end

    def assign_exemptions; end

    def assign_reference_number; end
  end
end
