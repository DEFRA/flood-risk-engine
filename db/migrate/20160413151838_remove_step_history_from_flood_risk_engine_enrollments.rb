class RemoveStepHistoryFromFloodRiskEngineEnrollments < ActiveRecord::Migration
  def up
    remove_column :flood_risk_engine_enrollments, :step_history
  end

  def down
    add_column :flood_risk_engine_enrollments, :step_history, :text
  end
end
