# frozen_string_literal: true

module FloodRiskEngine
  class BasePostcodeForm < BaseForm
    def address_finder_errored!
      # Used in the postcode validator to set the parameter.
      # This is then saved in the `#submit` and used by AASM to decide
      # what is the next valid status for the user.
      transient_registration.address_finder_error = true
    end

    private

    def format_postcode(postcode)
      postcode&.upcase&.strip
    end
  end
end
