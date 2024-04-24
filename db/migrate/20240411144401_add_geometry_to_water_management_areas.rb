# frozen_string_literal: true

class AddGeometryToWaterManagementAreas < ActiveRecord::Migration[7.1]

  def self.up
    enable_extension "postgis"

    change_table :flood_risk_engine_water_management_areas do |t|
      t.column :area, :geometry
      t.index :area, using: :gist
    end
  end

  def self.down
    remove_column :flood_risk_engine_water_management_areas, :area
    remove_index :flood_risk_engine_water_management_areas, :area
  end
end
