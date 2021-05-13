class CreateFloodRiskEngineReferenceNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :flood_risk_engine_reference_numbers do |t|
      t.string :number, index: true

      t.timestamps null: false
    end
  end
end
