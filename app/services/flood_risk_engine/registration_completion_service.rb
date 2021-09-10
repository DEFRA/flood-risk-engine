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

      if @transient_registration.partnership?
        add_partnership_organisation
      else
        add_organisation
      end

      assign_exemption
      add_exemption_location

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

    def add_partnership_organisation; end

    def add_organisation
      @registration.organisation = Organisation.new(
        name: @transient_registration.company_name,
        org_type: org_type
      )

      add_address
    end

    def add_address
      address = @transient_registration.company_address
      transferable_attributes = address.attributes.except("address_type",
                                                          "token",
                                                          "addressable_id",
                                                          "addressable_type",
                                                          "created_at",
                                                          "updated_at")

      @registration.organisation.primary_address = Address.new(transferable_attributes)
    end

    def assign_exemption
      @transient_registration.exemptions.each do |exemption|
        @registration.exemptions << exemption
      end
    end

    def add_exemption_location; end

    def assign_reference_number; end

    def org_type
      enrollment_org_types = {
        localAuthority: 0,
        limitedCompany: 1,
        limitedLiabilityPartnership: 2,
        soleTrader: 3,
        partnership: 4,
        charity: 5
      }

      transient_type = @transient_registration.business_type.to_sym

      enrollment_org_types[transient_type]
    end
  end
end
