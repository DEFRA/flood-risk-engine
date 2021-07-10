# Validates the Format of a Postode
#  Uses external gem : https://github.com/threedaymonk/uk_postcode
#
require "uk_postcode"

module FloodRiskEngine
  class LegacyPostcodeValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      return if UKPostcode.parse(value).full_valid?
      record.errors.add attribute, I18n.t("flood_risk_engine.validation_errors.postcode.enter_a_valid_postcode")
    end

  end
end
