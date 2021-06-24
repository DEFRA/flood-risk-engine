# frozen_string_literal: true

module FloodRiskEngine
  class CheckYourAnswersFormsController < ::FloodRiskEngine::FormsController
    def new
      super(CheckYourAnswersForm, "check_your_answers_form")
    end

    def create
      super(CheckYourAnswersForm, "check_your_answers_form")
    end
  end
end
