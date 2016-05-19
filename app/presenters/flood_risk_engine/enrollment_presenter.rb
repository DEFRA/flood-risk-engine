#
# A generalised presenter which adds helpers to simplify accessing enrollment data
# from a view.
#
module FloodRiskEngine
  class EnrollmentPresenter
    delegate :exemption_location, to: :enrollment
    delegate :organisation, to: :enrollment
    delegate :grid_reference, to: :exemption_location, allow_nil: true
    delegate :name, to: :organisation, allow_nil: true, prefix: true

    def initialize(enrollment)
      @enrollment = enrollment
    end

    def organisation_type
      enrollment.org_type.to_sym if enrollment.org_type
    end

    def organisation_address
      "yay" # TODO: AddressPresenter.new(organisation.primary_address)
    end

    private

    attr_reader :enrollment
  end
end
