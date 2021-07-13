# frozen_string_literal: true

module FloodRiskEngine
  class ExemptionForm < ::FloodRiskEngine::BaseForm
    delegate :exemptions, to: :transient_registration

    validates :exemptions, "flood_risk_engine/exemptions": true
  end
end
