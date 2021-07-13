# frozen_string_literal: true

module FloodRiskEngine
  class ContactNameValidator < ActiveModel::EachValidator
    include CanAddValidationErrors
    include CanValidatePresence
    include CanValidateLength

    def validate_each(record, attribute, value)
      return false unless value_is_present?(record, attribute, value)
      return false unless value_has_no_invalid_characters?(record, attribute, value)

      max_length = 70
      value_is_not_too_long?(record, attribute, value, max_length)
    end

    private

    def value_has_no_invalid_characters?(record, attribute, value)
      # Name fields must contain only letters, spaces, commas, full stops, hyphens and apostrophes
      return true if value.match?(/\A[-a-z\s,.']+\z/i)

      add_validation_error(record, attribute, :invalid)
      false
    end
  end
end
