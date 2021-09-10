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

      add_correspondence_contact
      add_secondary_contact
      add_organisation

      assign_exemptions
      assign_reference_number
    end

    def add_core_data
      @registration.step = "confirmation"
    end

    def add_correspondence_contact
      @registration.correspondence_contact = Contact.new(
        full_name: @transient_registration.contact_name,
        email_address: @transient_registration.contact_email,
        telephone_number: @transient_registration.contact_phone,
        position: @transient_registration.contact_position
      )
    end

    def add_secondary_contact
      return unless @transient_registration.additional_contact_email.present?

      @registration.secondary_contact = Contact.new(
        email_address: @transient_registration.additional_contact_email
      )
    end

    def add_organisation; end

    def assign_exemptions; end

    def assign_reference_number; end
  end
end
