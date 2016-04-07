class CreateFloodRiskEngineEnrollments < ActiveRecord::Migration
  def change
    create_table :flood_risk_engine_enrollments do |t|
      t.boolean :dummy_boolean
      t.string :dummy_string1
      t.string :dummy_string2

      t.timestamps null: false
    end
  end
end
