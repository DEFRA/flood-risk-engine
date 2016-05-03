# Validates the Format of a Name to match the criteria :
#     Make sure the name contains only letters, spaces, commas, full stops, hyphens and apostrophes
#
module FloodRiskEngine
  class NameFormatValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      if value !~ NameFormatValidator.valid_name_regex
        record.errors.add attribute, I18n.t("flood_risk_engine.validation_errors.#{attribute}.invalid")
      end
    end

    def self.valid_name_regex
      /\A[\p{Alpha} ,\.'-]+\z/i
    end

    def self.find_max_column_length(klass, column, default = 255)
      name_max_length = begin
        klass.columns.find { |col| col.name == column }.limit || default
      rescue
        default
      end
      name_max_length
    end

  end
end
