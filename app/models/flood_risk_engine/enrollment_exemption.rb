module FloodRiskEngine
  class EnrollmentExemption < ActiveRecord::Base
    self.table_name = "flood_risk_engine_enrollments_exemptions"

    belongs_to :enrollment, foreign_key: :enrollment_id

    belongs_to :exemption
  end
end
