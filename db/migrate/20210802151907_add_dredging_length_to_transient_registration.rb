# frozen_string_literal: true

class AddDredgingLengthToTransientRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :transient_registrations, :dredging_length, :integer
  end
end
