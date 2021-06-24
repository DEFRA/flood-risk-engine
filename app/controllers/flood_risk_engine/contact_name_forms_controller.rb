# frozen_string_literal: true

module FloodRiskEngine
  class ContactNameFormsController < ::FloodRiskEngine::FormsController
    def new
      super(ContactNameForm, "contact_name_form")
    end

    def create
      super(ContactNameForm, "contact_name_form")
    end
  end
end
