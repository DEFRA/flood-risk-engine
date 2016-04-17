class RemoveDummyEnrollmentColumns < ActiveRecord::Migration
  def change
    remove_column :flood_risk_engine_enrollments, :dummy_boolean
    remove_column :flood_risk_engine_enrollments, :dummy_string1
    remove_column :flood_risk_engine_enrollments, :dummy_string2
  end
end
