class AddSubmittedAt < ActiveRecord::Migration
  def change
    add_column :flood_risk_engine_enrollments, :submitted_at, :datetime, index: true
  end
end
