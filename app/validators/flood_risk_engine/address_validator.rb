# frozen_string_literal: true

module FloodRiskEngine
  class AddressValidator < ActiveModel::EachValidator
    include CanAddValidationErrors

    def validate_each(record, attribute, value)
      return true if value && (value[:uprn].present? || value[:postcode].present?)

      add_validation_error(record, attribute, :blank)
      false
    end
  end
end
