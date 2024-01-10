# frozen_string_literal: true

module FloodRiskEngine
  class AddressLookupValidator < ActiveModel::EachValidator
    include CanAddValidationErrors

    def validate_each(record, attribute, value)
      return unless value_is_present?(record, attribute, value)

      postcode_returns_results?(record, attribute, value)
    end

    private

    def value_is_present?(record, attribute, value)
      return true if value.present?

      add_validation_error(record, attribute, :blank)
      false
    end

    def postcode_returns_results?(record, attribute, value)
      response = AddressLookupService.run(value)

      return true if response.successful?

      if response.error.is_a?(DefraRuby::Address::NoMatchError)
        add_validation_error(record, attribute, :no_results)
        false
      else
        record.address_finder_errored!
        true
      end
    end
  end
end
