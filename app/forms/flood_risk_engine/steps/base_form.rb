require_dependency "reform"

# Common step form functionality.
module FloodRiskEngine
  module Steps
    class BaseForm < Reform::Form
      include ActionView::Helpers::TranslationHelper
      include ActiveModel::Validations

      feature Reform::Form::ActiveModel::Validations

      include BaseFormCommon
      extend BaseFormCommon

      # So we can always build an enrollment step url
      delegate :id, to: :enrollment, prefix: true

      def redirect?
        false
      end

      # Default to the url as defined in the view/partial but provide opportunity for Forms to
      # wire up the continue button as they see require
      def url
        nil
      end

      def initialize(model, enrollment = nil)
        @enrollment = enrollment || model
        super(model)
      end

      def validate(params)
        super params.fetch(params_key, {})
      end

      attr_reader :enrollment

      protected

      def logger
        Rails.logger
      end
    end
  end
end
