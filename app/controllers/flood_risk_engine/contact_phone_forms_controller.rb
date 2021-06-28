# frozen_string_literal: true

module FloodRiskEngine
  class ContactPhoneFormsController < ::FloodRiskEngine::FormsController
    def new
      super(ContactPhoneForm, "contact_phone_form")
    end

    def create
      super(ContactPhoneForm, "contact_phone_form")
    end
  end
end
