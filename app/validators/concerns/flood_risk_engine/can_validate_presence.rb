# frozen_string_literal: true

module FloodRiskEngine
  module CanValidatePresence
    extend ActiveSupport::Concern

    included do
      private

      def value_is_present?(record, attribute, value)
        return true if value.present?

        add_validation_error(record, attribute, :blank)
        false
      end
    end
  end
end
