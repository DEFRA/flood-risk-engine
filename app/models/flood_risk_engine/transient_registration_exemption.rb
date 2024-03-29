# frozen_string_literal: true

module FloodRiskEngine
  class TransientRegistrationExemption < ApplicationRecord
    self.table_name = "transient_registration_exemptions"

    belongs_to :transient_registration
    belongs_to :exemption, foreign_key: "flood_risk_engine_exemption_id"
  end
end
