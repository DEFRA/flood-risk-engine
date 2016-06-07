class AddStatusToEnrollments < ActiveRecord::Migration
  def change
    add_column :flood_risk_engine_enrollments, :status, :integer, default: 0, null: false
  end
end
