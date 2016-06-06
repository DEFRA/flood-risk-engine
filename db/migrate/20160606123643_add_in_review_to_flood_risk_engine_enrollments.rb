class AddInReviewToFloodRiskEngineEnrollments < ActiveRecord::Migration
  def change
    add_column :flood_risk_engine_enrollments, :in_review, :boolean
  end
end
