# frozen_string_literal: true

module FloodRiskEngine
  class CompanyNumberValidator < ActiveModel::EachValidator
    include CanAddValidationErrors
    include CanValidatePresence

    # Examples we need to validate are
    # 10997904, 09764739
    # SC534714, CE000958
    # IP00141R, IP27702R, SP02252R
    # https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/426891/uniformResourceIdentifiersCustomerGuide.pdf
    VALID_COMPANIES_HOUSE_REGISTRATION_NUMBER_REGEX = Regexp.new(
      /\A(\d{8,8}$)|([a-zA-Z]{2}\d{6}$)|([a-zA-Z]{2}\d{5}[a-zA-Z]{1}$)\z/i
    ).freeze

    def validate_each(record, attribute, value)
      return false unless value_is_present?(record, attribute, value)

      format_is_valid?(record, attribute, value)
    end

    private

    def format_is_valid?(record, attribute, value)
      return true if value.match?(VALID_COMPANIES_HOUSE_REGISTRATION_NUMBER_REGEX)

      add_validation_error(record, attribute, :invalid_format)
      false
    end
  end
end
