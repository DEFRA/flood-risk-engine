# frozen_string_literal: true

module FloodRiskEngine
  class CompanyNameFormsController < ::FloodRiskEngine::FormsController
    def new
      super(CompanyNameForm, "company_name_form")
    end

    def create
      super(CompanyNameForm, "company_name_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:company_name_form, {}).permit(:company_name)
    end
  end
end
