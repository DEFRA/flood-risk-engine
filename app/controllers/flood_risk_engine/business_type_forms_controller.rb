# frozen_string_literal: true

module FloodRiskEngine
  class BusinessTypeFormsController < ::FloodRiskEngine::FormsController
    def new
      super(BusinessTypeForm, "business_type_form")
    end

    def create
      super(BusinessTypeForm, "business_type_form")
    end
  end
end
