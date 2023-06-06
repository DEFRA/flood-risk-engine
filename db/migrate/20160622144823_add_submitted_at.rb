# frozen_string_literal: true

class AddSubmittedAt < ActiveRecord::Migration[4.2]
  def change
    add_column :flood_risk_engine_enrollments, :submitted_at, :datetime
    add_index :flood_risk_engine_enrollments, :submitted_at
  end
end
