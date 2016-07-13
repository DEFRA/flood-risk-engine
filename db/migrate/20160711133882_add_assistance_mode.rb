class AddAssistanceMode < ActiveRecord::Migration
  def change

    unless(column_exists?(:flood_risk_engine_enrollments_exemptions, :assistance_mode))
      add_column :flood_risk_engine_enrollments_exemptions, :assistance_mode, :integer, default: 0
    end

  end
end
