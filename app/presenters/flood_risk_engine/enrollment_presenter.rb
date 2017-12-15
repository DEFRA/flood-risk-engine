#
# A generalised presenter which adds helpers to simplify accessing enrollment data
# from a view.
#
module FloodRiskEngine
  class EnrollmentPresenter
    delegate :exemption_location,
             :correspondence_contact,
             :organisation,
             :org_type,
             :reference,
             to: :enrollment
    delegate :grid_reference,
             to: :exemption_location, allow_nil: true
    delegate :name,
             :primary_address,
             to: :organisation, allow_nil: true, prefix: true
    delegate :email_address,
             :telephone_number,
             to: :correspondence_contact, prefix: true, allow_nil: true

    def initialize(enrollment)
      @enrollment = enrollment
    end

    def organisation_type
      return unless org_type
      I18n.t("organisation_types.#{org_type}")
    end

    def organisation_address
      AddressPresenter.new(organisation_primary_address).to_single_line
    end

    def correspondence_contact_name
      return unless correspondence_contact
      title = correspondence_contact.full_name
      title << " (#{correspondence_contact.position})" unless correspondence_contact.position.blank?
      title
    end

    def organisation_registration_number
      return unless enrollment&.organisation&.registration_number.present?
      enrollment.organisation.registration_number
    end

    private

    attr_reader :enrollment
  end
end
