class AddDescriptionAndDredgingLengthToFloodRiskEngineLocations < ActiveRecord::Migration
  def change
    add_column :flood_risk_engine_locations, :description, :text, limit: 500
    add_column :flood_risk_engine_locations, :dredging_length, :string
  end
end
