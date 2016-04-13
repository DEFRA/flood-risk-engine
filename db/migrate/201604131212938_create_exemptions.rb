class CreateExemptions < ActiveRecord::Migration

  def change

    create_table :flood_risk_engine_exemptions do |t|
      t.string  :code
      t.string  :summary
      t.text    :description
      t.string  :url
      t.integer :category

      t.date		:valid_from
      t.date		:valid_to

      t.timestamps null: false
    end

    create_table :flood_risk_engine_enrollments_exemptions, force: :cascade do |t|
      t.references  :enrollment,      null: false
      t.references  :exemption,       null: false
      t.integer  :status,             default: 0
      t.datetime :expires_at
      t.datetime :valid_from
    end

    add_foreign_key :flood_risk_engine_enrollments_exemptions,
                    :flood_risk_engine_enrollments, column: :enrollment_id

    add_foreign_key :flood_risk_engine_enrollments_exemptions,
                    :flood_risk_engine_exemptions, column: :exemption_id

  end

end
