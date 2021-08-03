# frozen_string_literal: true

module FloodRiskEngine
  class SiteDescriptionValidator < ActiveModel::EachValidator
    include CanAddValidationErrors
    include CanValidatePresence
    include CanValidateLength

    def validate_each(record, attribute, value)
      return false unless value_is_present?(record, attribute, value)

      max_length = 500
      value_is_not_too_long?(record, attribute, value, max_length)
    end
  end
end
