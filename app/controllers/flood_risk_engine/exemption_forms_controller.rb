# frozen_string_literal: true

module FloodRiskEngine
  class ExemptionFormsController < ::FloodRiskEngine::FormsController
    def new
      super(ExemptionForm, "exemption_form")
    end

    def create
      super(ExemptionForm, "exemption_form")
    end
  end
end
