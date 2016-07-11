class AddDeregisteredReasonToFloodRiskEngineEnrollmentsExemptions < ActiveRecord::Migration
  def change
    add_column :flood_risk_engine_enrollments_exemptions, :deregister_reason, :string
  end
end
