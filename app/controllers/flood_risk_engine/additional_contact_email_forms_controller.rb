# frozen_string_literal: true

module FloodRiskEngine
  class AdditionalContactEmailFormsController < ::FloodRiskEngine::FormsController
    def new
      super(AdditionalContactEmailForm, "additional_contact_email_form")
    end

    def create
      super(AdditionalContactEmailForm, "additional_contact_email_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:additional_contact_email_form, {}).permit(:additional_contact_email, :confirmed_email)
    end
  end
end
