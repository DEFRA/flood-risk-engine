# frozen_string_literal: true

class AddCodeNumberToFloodRiskEngineExemptions < ActiveRecord::Migration[4.2]
  def change
    add_column :flood_risk_engine_exemptions, :code_number, :integer

    add_index :flood_risk_engine_exemptions, :code_number, unique: true

    FloodRiskEngine::Exemption.find_each(&:save)
  end
end
