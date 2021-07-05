# frozen_string_literal: true

class AddFieldsToTransientRegistration < ActiveRecord::Migration[6.0]
  def change
    change_table :transient_registrations do |t|
      t.string :additional_contact_email
      t.string :business_type
      t.string :company_name
      t.string :company_number
      t.string :contact_email
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_position
      t.boolean :declaration
      t.string :temp_company_postcode
      t.string :temp_grid_reference
      t.text :temp_site_description
      t.boolean :address_finder_error, default: false
    end
  end
end
