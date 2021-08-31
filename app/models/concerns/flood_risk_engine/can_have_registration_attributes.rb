# frozen_string_literal: true

module FloodRiskEngine
  module CanHaveRegistrationAttributes
    extend ActiveSupport::Concern

    BUSINESS_TYPES = HashWithIndifferentAccess.new(
      sole_trader: "soleTrader",
      limited_company: "limitedCompany",
      partnership: "partnership",
      limited_liability_partnership: "limitedLiabilityPartnership",
      local_authority: "localAuthority",
      charity: "charity"
    )

    def company_no_required?
      [
        BUSINESS_TYPES[:limited_company],
        BUSINESS_TYPES[:limited_liability_partnership]
      ].include?(business_type)
    end

    def partnership?
      business_type == BUSINESS_TYPES[:partnership]
    end

    def existing_partners?
      transient_people.any?
    end
  end
end
