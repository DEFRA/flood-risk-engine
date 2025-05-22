# frozen_string_literal: true

module FloodRiskEngine
  class CompanyNameForm < ::FloodRiskEngine::BaseForm
    delegate :company_name, to: :transient_registration

    validates :company_name, "flood_risk_engine/company_name": true

    def business_type
      FloodRiskEngine::TransientRegistration::BUSINESS_TYPES.key(transient_registration.business_type)
    end
  end
end
