# frozen_string_literal: true

module FloodRiskEngine
  class ConfirmExemptionForm < ::FloodRiskEngine::BaseForm
    def submit(_params)
      # Assign the params for validation and pass them to the BaseForm method for updating
      attributes = {}

      super(attributes)
    end
  end
end
