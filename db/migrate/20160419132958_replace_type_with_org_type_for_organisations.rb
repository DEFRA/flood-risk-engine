class ReplaceTypeWithOrgTypeForOrganisations < ActiveRecord::Migration
  def up
    remove_index :flood_risk_engine_organisations, :type
    remove_column :flood_risk_engine_organisations, :type
    add_column :flood_risk_engine_organisations, :org_type, :integer
    add_index :flood_risk_engine_organisations, :org_type
  end

  def down
    remove_index :flood_risk_engine_organisations, :org_type
    remove_column :flood_risk_engine_organisations, :org_type
    add_column :flood_risk_engine_organisations, :type, :string
    add_index :flood_risk_engine_organisations, :type
  end
end
