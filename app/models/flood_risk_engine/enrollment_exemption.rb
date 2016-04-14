module FloodRiskEngine
  class EnrollmentExemption < ActiveRecord::Base
    belongs_to :enrollment, foreign_key: :enrollment_id

    belongs_to :exemption
  end
end
