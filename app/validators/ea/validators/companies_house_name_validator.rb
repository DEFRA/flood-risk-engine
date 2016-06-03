# Validates a company name.
# Allowed characters in legislation:
#   http://www.legislation.gov.uk/uksi/2009/1085/schedule/1/made'
#
# rubocop:disable Style/AsciiComments
#
# Illegal characters - the company name cannot contain any of these characters: ^ | _ ~ ¬ or `
#
module EA
  module Validators

    class CompaniesHouseNameValidator < ActiveModel::EachValidator

      def validate_each(record, attribute, value)
        if value !~ CompaniesHouseNameValidator.valid_name_regex
          record.errors.add(
            attribute,
            (options[:message] || I18n.t("ea.validation_errors.companies_house_name.#{attribute}.invalid"))
          )
        end
      end

      def self.name_max_length
        160
      end

      def self.valid_name_regex
        /\A[\p{Alpha}\p{N}][^\^|_~¬`]+\z/i
      end

    end
  end
end
# rubocop:enable Style/AsciiComments
