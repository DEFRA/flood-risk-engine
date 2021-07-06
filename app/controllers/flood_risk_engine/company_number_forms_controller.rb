# frozen_string_literal: true

module FloodRiskEngine
  class CompanyNumberFormsController < ::FloodRiskEngine::FormsController
    def new
      super(CompanyNumberForm, "company_number_form")
    end

    def create
      super(CompanyNumberForm, "company_number_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:company_number_form, {}).permit(:company_number)
    end
  end
end
