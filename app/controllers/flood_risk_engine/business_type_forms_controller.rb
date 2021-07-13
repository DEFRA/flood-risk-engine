# frozen_string_literal: true

module FloodRiskEngine
  class BusinessTypeFormsController < ::FloodRiskEngine::FormsController
    def new
      super(BusinessTypeForm, "business_type_form")
    end

    def create
      super(BusinessTypeForm, "business_type_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:business_type_form, {}).permit(:business_type)
    end
  end
end
