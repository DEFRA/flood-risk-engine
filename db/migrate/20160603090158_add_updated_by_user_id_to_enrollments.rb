class AddUpdatedByUserIdToEnrollments < ActiveRecord::Migration
  def change
    add_column :flood_risk_engine_enrollments, :updated_by_user_id, :integer
    add_index :flood_risk_engine_enrollments, :updated_by_user_id
  end
end
