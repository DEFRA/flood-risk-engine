# frozen_string_literal: true

module FloodRiskEngine
  class MatchingEmailValidator < ActiveModel::EachValidator
    include CanAddValidationErrors

    # Expects to be passed an attribute on the same record to confirm against,
    # for example: validates :confirmed_email, matching_email: { compare_to: :contact_email }
    def validate_each(record, attribute, value)
      email_address_to_confirm = record.send(options[:compare_to])
      return true if value == email_address_to_confirm || value.blank?

      add_validation_error(record, attribute, :does_not_match)
      false
    end
  end
end
