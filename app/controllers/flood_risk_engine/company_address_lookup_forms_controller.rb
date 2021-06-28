# frozen_string_literal: true

module FloodRiskEngine
  class CompanyAddressLookupFormsController < ::FloodRiskEngine::FormsController
    def new
      super(CompanyAddressLookupForm, "company_address_lookup_form")
    end

    def create
      super(CompanyAddressLookupForm, "company_address_lookup_form")
    end
  end
end
