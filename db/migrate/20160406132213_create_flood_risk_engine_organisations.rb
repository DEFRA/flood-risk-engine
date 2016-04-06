class CreateFloodRiskEngineOrganisations < ActiveRecord::Migration
  def change
    create_table :flood_risk_engine_organisations do |t|
      t.string :type
      t.string :name
      t.integer :contact_id
      t.string :company_number

      t.timestamps null: false
    end
  end
end
