# frozen_string_literal: true

module FloodRiskEngine
  class ContactNameFormsController < ::FloodRiskEngine::FormsController
    def new
      super(ContactNameForm, "contact_name_form")
    end

    def create
      super(ContactNameForm, "contact_name_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:contact_name_form, {}).permit(:contact_name, :contact_position)
    end
  end
end
