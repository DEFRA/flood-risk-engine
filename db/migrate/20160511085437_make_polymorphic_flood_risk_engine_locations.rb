class MakePolymorphicFloodRiskEngineLocations < ActiveRecord::Migration
  def change
    add_column :flood_risk_engine_locations, :locatable_id, :integer
    add_column :flood_risk_engine_locations, :locatable_type, :string
    add_index(
      :flood_risk_engine_locations,
      [:locatable_id, :locatable_type],
      name: :by_locatable
    )

  end
end
