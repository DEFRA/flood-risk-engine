# frozen_string_literal: true

module FloodRiskEngine
  class CompanyNameFormsController < ::FloodRiskEngine::FormsController
    def new
      super(CompanyNameForm, "company_name_form")
    end

    def create
      super(CompanyNameForm, "company_name_form")
    end
  end
end
