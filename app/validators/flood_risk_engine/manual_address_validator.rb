# frozen_string_literal: true

module FloodRiskEngine
  class ManualAddressValidator < ActiveModel::EachValidator
    include CanAddValidationErrors
    include CanValidatePresence
    include CanValidateLength

    VALIDATION_REQUIREMENTS = {
      premises: { presence: true, max_length: 200 },
      street_address: { presence: true, max_length: 160 },
      locality: { presence: false, max_length: 70 },
      city: { presence: true, max_length: 30 },
      postcode: { presence: false, max_length: 8 }
    }.freeze

    def validate_each(record, _attribute, _value)
      VALIDATION_REQUIREMENTS.each do |attribute, requirement|
        value = record.send(attribute)
        value_is_present?(record, attribute, value) if requirement[:presence]
        value_is_not_too_long?(record, attribute, value, requirement[:max_length]) if value && requirement[:max_length]
      end

      record.errors.empty?
    end
  end
end
