# frozen_string_literal: true

FactoryBot.define do
  factory :new_registration, class: FloodRiskEngine::NewRegistration do
    trait :has_company_address do
      company_address { build(:transient_address, :company) }
    end
  end
end
