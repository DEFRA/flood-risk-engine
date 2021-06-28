# frozen_string_literal: true

module FloodRiskEngine
  class AdditionalContactEmailFormsController < ::FloodRiskEngine::FormsController
    def new
      super(AdditionalContactEmailForm, "additional_contact_email_form")
    end

    def create
      super(AdditionalContactEmailForm, "additional_contact_email_form")
    end
  end
end
