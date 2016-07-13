class AddMissingEngineIndexes < ActiveRecord::Migration
  def change
    add_index :flood_risk_engine_enrollments, :secondary_contact_id
  end
end
