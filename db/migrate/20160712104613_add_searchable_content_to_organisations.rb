class AddSearchableContentToOrganisations < ActiveRecord::Migration
  def change
    add_column :flood_risk_engine_organisations, :searchable_content, :text
    add_index :flood_risk_engine_organisations, :searchable_content
  end
end
