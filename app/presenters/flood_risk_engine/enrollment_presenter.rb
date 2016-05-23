#
# A generalised presenter which adds helpers to simplify accessing enrollment data
# from a view.
#
module FloodRiskEngine
  class EnrollmentPresenter
    delegate :exemption_location, to: :enrollment
    delegate :correspondence_contact, to: :enrollment
    delegate :organisation, to: :enrollment
    delegate :grid_reference, to: :exemption_location, allow_nil: true
    delegate :name,
             :primary_address,
             to: :organisation, allow_nil: true, prefix: true
    delegate :full_name,
             :email_address,
             :telephone_number,
             to: :correspondence_contact, prefix: true, allow_nil: true

    def initialize(enrollment)
      @enrollment = enrollment
    end

    def organisation_type
      enrollment.org_type.to_sym if enrollment.org_type
    end

    def organisation_address
      AddressPresenter.new(organisation_primary_address).to_s
    end

    private

    attr_reader :enrollment
  end
end
