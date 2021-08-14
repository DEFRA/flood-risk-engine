# frozen_string_literal: true

module FloodRiskEngine
  class CompanyAddressManualFormsController < ::FloodRiskEngine::FormsController
    def new
      super(CompanyAddressManualForm, "company_address_manual_form")
    end

    def create
      super(CompanyAddressManualForm, "company_address_manual_form")
    end

    private

    def transient_registration_attributes
      params
        .fetch(:company_address_manual_form, {})
        .permit(
          company_address: %i[premises street_address locality city postcode]
        )
    end
  end
end
