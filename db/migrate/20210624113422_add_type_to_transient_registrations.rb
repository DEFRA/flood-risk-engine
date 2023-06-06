# frozen_string_literal: true

class AddTypeToTransientRegistrations < ActiveRecord::Migration[6.0]
  def up
    add_column :transient_registrations, :type, :string, default: "FloodRiskEngine::NewRegistration"
    # Set any existing TransientRegistrations to NewRegistrations so everything has a type
    execute <<-SQL.squish
       UPDATE transient_registrations
       SET type = 'FloodRiskEngine::NewRegistration';
    SQL

    change_column_null :transient_registrations, :type, false
  end

  def down
    remove_column :transient_registrations, :type
  end
end
