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
      false
    end

    def partnership?
      false
    end

    def address_finder_error
      false
    end

    def company_address
      false
    end

    def existing_partners?
      false
    end
  end
end
