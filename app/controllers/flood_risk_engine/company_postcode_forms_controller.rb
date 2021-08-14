# frozen_string_literal: true

module FloodRiskEngine
  class CompanyPostcodeFormsController < ::FloodRiskEngine::FormsController
    include CanSkipToManualAddress

    def new
      super(CompanyPostcodeForm, "company_postcode_form")
    end

    def create
      super(CompanyPostcodeForm, "company_postcode_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:company_postcode_form, {}).permit(:temp_company_postcode)
    end
  end
end
