# frozen_string_literal: true

module FloodRiskEngine
  class CompanyPostcodeFormsController < ::FloodRiskEngine::FormsController
    def new
      super(CompanyPostcodeForm, "company_postcode_form")
    end

    def create
      super(CompanyPostcodeForm, "company_postcode_form")
    end
  end
end
