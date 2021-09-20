# frozen_string_literal: true

module FloodRiskEngine
  class CompanyNumberForm < ::FloodRiskEngine::BaseForm
    delegate :company_number, to: :transient_registration

    validates :company_number, "flood_risk_engine/company_number": true

    def business_type
      FloodRiskEngine::TransientRegistration::BUSINESS_TYPES.key(transient_registration.business_type)
    end
  end
end
