# frozen_string_literal: true

module FloodRiskEngine
  class ContactEmailFormsController < ::FloodRiskEngine::FormsController
    def new
      super(ContactEmailForm, "contact_email_form")
    end

    def create
      super(ContactEmailForm, "contact_email_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:contact_email_form, {}).permit(:contact_email, :confirmed_email)
    end
  end
end
