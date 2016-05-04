require_dependency "reform"

# Common step form functionality.
module FloodRiskEngine
  module Steps
    class BaseForm < Reform::Form
      include ActionView::Helpers::TranslationHelper
      include ActiveModel::Validations

      include BaseFormCommon
      extend BaseFormCommon

      # So we can always build an enrollment step url
      delegate :id, to: :enrollment, prefix: true

      def redirect?
        false
      end

      def initialize(model, enrollment = nil)
        @enrollment = enrollment || model
        super(model)
      end

      def validate(params)
        super params.fetch(params_key) { {} }
      end

      attr_reader :enrollment
    end
  end
end
