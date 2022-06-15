# frozen_string_literal: true

module FloodRiskEngine
  class CompanyAddressLookupForm < BaseAddressLookupForm
    delegate :temp_company_postcode, :business_type, :company_address, to: :transient_registration

    alias existing_address company_address
    alias postcode temp_company_postcode

    validates :company_address, "flood_risk_engine/address": true

    def submit(params)
      company_address_params = params.fetch(:company_address, {})
      company_address_attributes = get_address_data(company_address_params[:uprn], :operator)

      super(company_address_attributes:)
    end
  end
end
