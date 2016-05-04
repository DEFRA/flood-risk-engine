class RecreateExemptionsCodeNumberIndex < ActiveRecord::Migration
  def up
    remove_index :flood_risk_engine_exemptions, :code_number
    add_index :flood_risk_engine_exemptions, :code_number, unique: false
  end
  def down
    remove_index :flood_risk_engine_exemptions, :code_number
    add_index :flood_risk_engine_exemptions, :code_number, unique: true
  end
end
