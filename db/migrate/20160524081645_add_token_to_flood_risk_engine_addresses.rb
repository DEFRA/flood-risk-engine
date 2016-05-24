class AddTokenToFloodRiskEngineAddresses < ActiveRecord::Migration
  def change
    add_column :flood_risk_engine_addresses, :token, :string
    add_index  :flood_risk_engine_addresses, :token, unique: true
  end
end
