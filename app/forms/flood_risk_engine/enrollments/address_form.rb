module FloodRiskEngine
  module Enrollments
    class AddressForm < Reform::Form
      include ActionView::Helpers::TranslationHelper

      def self.locale_key
        "flood_risk_engine.enrollments.addressed.show"
      end

      alias address model
      attr_reader :enrollment
      delegate :id, to: :enrollment, prefix: true

      def initialize(address, enrollment)
        @enrollment = enrollment
        super(address)
      end

      def validate(params)
        super params.fetch(params_key, {})
      end

    end
  end
end
