# frozen_string_literal: true

module FloodRiskEngine
  class RegistrationCompleteFormsController < ::FloodRiskEngine::FormsController
    def new
      super(RegistrationCompleteForm, "registration_complete_form")
    end

    def create; end
  end
end
