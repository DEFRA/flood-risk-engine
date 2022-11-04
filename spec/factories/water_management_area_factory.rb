# frozen_string_literal: true

FactoryBot.define do
  factory :water_management_area, class: "FloodRiskEngine::WaterManagementArea" do
    code { "somewere_in_england" }
    long_name { "Somewere in England" }
  end
end
