class AddStepHistoryToFloodRiskEngineEnrollments < ActiveRecord::Migration
  def change
    add_column :flood_risk_engine_enrollments, :step_history, :text
  end
end
