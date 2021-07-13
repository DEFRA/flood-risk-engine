# frozen_string_literal: true

module FloodRiskEngine
  class ContactPhoneFormsController < ::FloodRiskEngine::FormsController
    def new
      super(ContactPhoneForm, "contact_phone_form")
    end

    def create
      super(ContactPhoneForm, "contact_phone_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:contact_phone_form, {}).permit(:contact_phone)
    end
  end
end
