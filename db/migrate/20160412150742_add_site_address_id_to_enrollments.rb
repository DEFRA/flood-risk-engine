# frozen_string_literal: true

class AddSiteAddressIdToEnrollments < ActiveRecord::Migration[4.2]
  def change
    add_column :flood_risk_engine_enrollments, :site_address_id, :integer
    add_index :flood_risk_engine_enrollments, :site_address_id
    add_foreign_key :flood_risk_engine_enrollments,
                    :flood_risk_engine_addresses,
                    column: :site_address_id
  end
end
