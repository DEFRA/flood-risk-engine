# frozen_string_literal: true

module FloodRiskEngine
  class CompanyAddressManualFormsController < ::FloodRiskEngine::FormsController
    def new
      super(CompanyAddressManualForm, "company_address_manual_form")
    end

    def create
      super(CompanyAddressManualForm, "company_address_manual_form")
    end
  end
end
