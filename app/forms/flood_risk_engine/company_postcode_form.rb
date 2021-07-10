# frozen_string_literal: true

module FloodRiskEngine
  class CompanyPostcodeForm < BaseForm
    delegate :temp_company_postcode, to: :transient_registration

    validates :temp_company_postcode, "flood_risk_engine/postcode": true

    def submit(params)
      params[:temp_company_postcode] = format_postcode(params[:temp_company_postcode])

      # We persist the postcode regardless of validations.
      transient_registration.update(params)

      super({})
    end

    def address_finder_errored!
      # Used in the postcode validator to set the parameter.
      # This is then saved in the `#submit` and used by AASM to decide
      # what is the next valid status for the user.
      transient_registration.address_finder_error = true
    end

    private

    def format_postcode(postcode)
      postcode&.upcase&.strip
    end
  end
end
