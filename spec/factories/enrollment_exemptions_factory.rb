# frozen_string_literal: true

FactoryBot.define do
  factory :enrollment_exemption, class: "FloodRiskEngine::EnrollmentExemption" do
    enrollment
    exemption
  end
end
