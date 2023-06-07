# frozen_string_literal: true

class AddAssistanceMode < ActiveRecord::Migration[4.2]
  def change
    return if column_exists?(:flood_risk_engine_enrollments_exemptions, :assistance_mode)

    add_column :flood_risk_engine_enrollments_exemptions, :assistance_mode, :integer, default: 0
  end
end
