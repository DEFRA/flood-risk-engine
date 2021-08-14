# frozen_string_literal: true

module FloodRiskEngine
  class CompanyAddressLookupFormsController < ::FloodRiskEngine::FormsController
    include CanSkipToManualAddress

    def new
      super(CompanyAddressLookupForm, "company_address_lookup_form")
    end

    def create
      super(CompanyAddressLookupForm, "company_address_lookup_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:company_address_lookup_form, {}).permit(company_address: [:uprn])
    end
  end
end
