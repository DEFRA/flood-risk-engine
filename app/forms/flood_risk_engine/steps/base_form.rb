require_dependency "reform"

# Common step form functionality.
module FloodRiskEngine
  module Steps
    class BaseForm < Reform::Form

      include ActionView::Helpers::TranslationHelper

      # So we can always build an enrollment step url
      def enrollment_id
        @enrollment.id
      end

      def initialize(model, enrollment = nil)
        @enrollment = enrollment || model
        super(model)
      end

      # Moved knowledge of parent key in params (defined in the html form using as: ..
      # otherwise we get very longs form field names etc - see step1.html.erb)
      # since knowing how to extract the form data, and what the expectation of the
      # params structure is, is best here.
      # params_key is a symbol defined by the subclass
      def validate(params)
        super params.fetch(params_key) { {} }
      end

      attr_reader :enrollment
    end
  end
end
