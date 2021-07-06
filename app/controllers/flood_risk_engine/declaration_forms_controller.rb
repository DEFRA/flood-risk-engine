# frozen_string_literal: true

module FloodRiskEngine
  class DeclarationFormsController < ::FloodRiskEngine::FormsController
    def new
      super(DeclarationForm, "declaration_form")
    end

    def create
      super(DeclarationForm, "declaration_form")
    end

    private

    def transient_registration_attributes
      params.fetch(:declaration_form, {}).permit(:declaration)
    end
  end
end
