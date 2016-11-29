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

      VALID_COMPANIES_HOUSE_NAME_REGEX = Regexp.new(/[\^|_~¬`]/).freeze

      def validate_each(record, attribute, value)
        return unless VALID_COMPANIES_HOUSE_NAME_REGEX.match(value)
        record.errors.add(
          attribute,
          (options[:message] || I18n.t("ea.validation_errors.companies_house_name.#{attribute}.invalid"))
        )
      end

      def self.name_max_length
        170
      end

      def self.disallowed_chars
        @disallowed_chars ||= ["^", "|", "_", "~", "¬", "`"]
      end

    end
  end
end
# rubocop:enable Style/AsciiComments
