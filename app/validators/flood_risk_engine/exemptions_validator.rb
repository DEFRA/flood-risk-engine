# frozen_string_literal: true

module FloodRiskEngine
  class ExemptionsValidator < ActiveModel::EachValidator
    include CanAddValidationErrors

    def validate_each(record, attribute, value)
      return true if valid_exemption?(value)

      add_validation_error(record, attribute, :inclusion)
      false
    end

    private

    def valid_exemption?(value)
      Exemption.where(id: value).any?
    end
  end
end
