# frozen_string_literal: true

module FloodRiskEngine
  class RegistrationCompleteFormsController < ::FloodRiskEngine::FormsController
    include UnsubmittableForm
    include CannotGoBackForm

    def new
      super(RegistrationCompleteForm, "registration_complete_form")
    end
  end
end
