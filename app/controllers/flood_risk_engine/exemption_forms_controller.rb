# frozen_string_literal: true

module FloodRiskEngine
  class ExemptionFormsController < ::FloodRiskEngine::FormsController
    def new
      super(ExemptionForm, "exemption_form")
    end

    def create
      super(ExemptionForm, "exemption_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:exemption_form, {}).permit(:exemption_ids)
    end
  end
end
