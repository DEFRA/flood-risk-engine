# frozen_string_literal: true

module FloodRiskEngine
  class CompanyPostcodeForm < BasePostcodeForm
    delegate :business_type, :temp_company_postcode, to: :transient_registration

    validates :temp_company_postcode, "flood_risk_engine/postcode": true

    def submit(params)
      params[:temp_company_postcode] = format_postcode(params[:temp_company_postcode])

      # We persist the postcode regardless of validations.
      transient_registration.update(params)

      super({})
    end
  end
end
