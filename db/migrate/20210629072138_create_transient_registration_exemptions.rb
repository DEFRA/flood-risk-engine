# frozen_string_literal: true

class CreateTransientRegistrationExemptions < ActiveRecord::Migration[6.0]
  def change
    create_table :transient_registration_exemptions do |t|
      t.string :state
      t.date :registered_on
      t.date :expires_on
      t.belongs_to :transient_registration, index: { name: "transient_registration_id" }
      t.belongs_to :flood_risk_engine_exemption, index: { name: "exemption_id" }
    end
  end
end
