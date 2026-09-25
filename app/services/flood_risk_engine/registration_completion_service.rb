# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
module FloodRiskEngine
  class RegistrationCompletionService < BaseService
    def run(transient_registration:)
      @transient_registration = transient_registration
      @registration = nil

      @transient_registration.with_lock do
        @registration = Enrollment.new
        transfer_data
        @registration.save!
        @registration.organisation.save!

        @transient_registration.destroy
      end

      update_water_management_area
      send_confirmation_email

      @registration
    rescue StandardError => e
      Airbrake.notify(e, reference: @registration&.ref_number) if defined?(Airbrake)
      Rails.logger.error "Completing registration error: #{e}\n#{@registration.errors.inspect}"

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
      update_status_and_assistance_mode
    end

    def add_core_data
      @registration.step = "confirmation"
      @registration.submitted_at = Time.zone.now
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
      @registration.secondary_contact = Contact.new(
        email_address: @transient_registration.additional_contact_email
      )
    end

    def add_partnership_organisation
      @registration.organisation = Organisation.create!(
        org_type:
      )

      add_partners
    end

    def add_partners
      @transient_registration.transient_people.each do |partner|
        contact = Contact.new(
          full_name: partner.full_name,
          address: build_partner_address(partner)
        )

        @registration.organisation.partners << Partner.new(contact:)
      end
    end

    def build_partner_address(partner)
      attributes = transferable_address_attributes(partner.transient_address)
      attributes["organisation"] ||= ""

      Address.new(attributes)
    end

    def add_organisation
      @registration.organisation = Organisation.new(
        name: @transient_registration.company_name,
        org_type:
      )

      add_address
    end

    def add_address
      attributes = transferable_address_attributes(@transient_registration.company_address)
      attributes["organisation"] ||= ""

      @registration.organisation.primary_address = Address.new(attributes)
    end

    def assign_exemption
      @transient_registration.exemptions.each do |exemption|
        @registration.exemptions << exemption
      end
    end

    def add_exemption_location
      @registration.exemption_location = Location.new(
        grid_reference: @transient_registration.temp_grid_reference,
        description: @transient_registration.temp_site_description,
        dredging_length: @transient_registration.dredging_length
      )
    end

    def assign_reference_number
      @registration.reference_number = ReferenceNumber.create
    end

    def update_status_and_assistance_mode
      @registration.enrollment_exemptions.each do |ee|
        ee.status = 1
        ee.assistance_mode = FloodRiskEngine.config.default_assistance_mode
      end
    end

    def update_water_management_area
      # location.id must be present for ActiveJob serialization:
      @registration.exemption_location.save!

      UpdateWaterManagementAreaJob.perform_later(@registration.exemption_location)
    end

    def send_confirmation_email
      SendEnrollmentSubmittedEmail.new(@registration).call
    end

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

    def transferable_address_attributes(address)
      address.attributes.except("id",
                                "address_type",
                                "token",
                                "addressable_id",
                                "addressable_type",
                                "created_at",
                                "updated_at")
    end
  end
end
# rubocop:enable Metrics/ClassLength
