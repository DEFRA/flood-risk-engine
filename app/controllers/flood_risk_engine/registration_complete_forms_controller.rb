# frozen_string_literal: true

module FloodRiskEngine
  class RegistrationCompleteFormsController < ::FloodRiskEngine::FormsController
    include UnsubmittableForm
    include CannotGoBackForm

    def new
      return unless super(RegistrationCompleteForm, "registration_complete_form")

      @enrollment = RegistrationCompletionService.run(transient_registration: @transient_registration)
    end
  end
end
