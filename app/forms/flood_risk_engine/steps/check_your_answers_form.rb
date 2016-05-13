module FloodRiskEngine
  module Steps
    class CheckYourAnswersForm < BaseForm
      delegate :rows, to: :review_presenter

      def self.factory(enrollment)
        new(enrollment)
      end

      def params_key
        :check_your_answers
      end

      def save
        true
      end

      def review_presenter
        @review_presenter ||= begin
          TabularEnrollmentDetailPresenter.new(enrollment: model,
                                               i18n_scope: locale_key,
                                               display_change_url: true)
        end
      end

      def view_path
        :check_your_answers
      end
    end
  end
end
