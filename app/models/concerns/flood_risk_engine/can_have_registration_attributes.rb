# frozen_string_literal: true

module FloodRiskEngine
  module CanHaveRegistrationAttributes
    extend ActiveSupport::Concern

    BUSINESS_TYPES = ActiveSupport::HashWithIndifferentAccess.new(
      local_authority: "localAuthority",
      limited_company: "limitedCompany",
      limited_liability_partnership: "limitedLiabilityPartnership",
      sole_trader: "soleTrader",
      partnership: "partnership",
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
