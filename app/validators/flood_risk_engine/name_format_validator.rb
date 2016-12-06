# Validates the Format of a Name to match the criteria :
#   If not two words in name
#
module FloodRiskEngine
  class NameFormatValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      return unless value.to_s.strip.split(/\s+/).size < 2
      record.errors.add attribute, I18n.t("flood_risk_engine.validation_errors.#{attribute}.too_few")
    end

  end
end
