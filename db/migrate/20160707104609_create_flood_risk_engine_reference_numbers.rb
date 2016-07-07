class CreateFloodRiskEngineReferenceNumbers < ActiveRecord::Migration
  def change
    create_table :flood_risk_engine_reference_numbers do |t|
      t.string :number, index: true

      t.timestamps null: false
    end
  end
end
