# frozen_string_literal: true

module FloodRiskEngine
  class ConfirmExemptionFormsController < ::FloodRiskEngine::FormsController
    def new
      super(ConfirmExemptionForm, "confirm_exemption_form")
    end

    def create
      super(ConfirmExemptionForm, "confirm_exemption_form")
    end
  end
end
