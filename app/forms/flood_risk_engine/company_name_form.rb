# frozen_string_literal: true

module FloodRiskEngine
  class CompanyNameForm < ::FloodRiskEngine::BaseForm
    delegate :company_name, to: :transient_registration

    validates :company_name, "flood_risk_engine/company_name": true
  end
end
