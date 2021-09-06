# frozen_string_literal: true

module FloodRiskEngine
  class CheckYourAnswersForm < ::FloodRiskEngine::BaseForm
    delegate :registration_rows, :contact_rows, to: :check_your_answers_presenter

    private

    def check_your_answers_presenter
      @_check_your_answers_presenter ||= CheckYourAnswersPresenter.new(transient_registration)
    end
  end
end
