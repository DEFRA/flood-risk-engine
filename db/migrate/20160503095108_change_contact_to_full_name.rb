class ChangeContactToFullName < ActiveRecord::Migration

  def up
    remove_column :flood_risk_engine_contacts, :first_name
    remove_column :flood_risk_engine_contacts, :last_name

    add_column :flood_risk_engine_contacts, :full_name, :string, limit: 255, null: false, default: ''
    add_index :flood_risk_engine_contacts, :full_name

    add_reference :flood_risk_engine_enrollments, :correspondence_contact

    add_index :flood_risk_engine_enrollments,
              :correspondence_contact_id,
              name: 'fre_enrollments_correspondence_contact_id'
  end

  def down
    add_column :flood_risk_engine_contacts, :first_name
    add_column :flood_risk_engine_contacts, :last_name

    remove_column :flood_risk_engine_contacts, :full_name, :string
    remove_index :flood_risk_engine_contacts, :full_name

    remove_reference :flood_risk_engine_enrollments, :correspondence_contact

    remove_index :flood_risk_engine_enrollments,  name: 'fre_enrollments_correspondence_contact_id'
  end

end
