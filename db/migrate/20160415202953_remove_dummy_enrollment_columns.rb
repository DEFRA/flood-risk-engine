# frozen_string_literal: true

class RemoveDummyEnrollmentColumns < ActiveRecord::Migration[4.2]
  def change
    remove_column :flood_risk_engine_enrollments, :dummy_boolean, :boolean
    remove_column :flood_risk_engine_enrollments, :dummy_string1, :string
    remove_column :flood_risk_engine_enrollments, :dummy_string2, :string
  end
end
