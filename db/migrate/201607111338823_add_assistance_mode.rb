class AddAssistanceMode < ActiveRecord::Migration
  def change
    add_column :flood_risk_engine_enrollments_exemptions, :assistance_mode, :integer, default: 0
  end
end
