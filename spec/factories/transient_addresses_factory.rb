# frozen_string_literal: true

FactoryBot.define do
  factory :transient_address, class: "FloodRiskEngine::Transient_Address" do
    uprn                { Faker::Lorem.characters(number: 6) }
    premises            { Faker::Address.building_number }
    street_address      { Faker::Address.street_address }
    locality            { Faker::Address.city_prefix }
    city                { Faker::Address.city }
    postcode            { "BS1 5AH" }
    county_province_id  { 1 }
    country_iso         { Faker::Address.country_code }
    organisation        { Faker::Company.name }
    state_date          { 1.year.ago }
    blpu_state_code     { Faker::Lorem.characters(number: 10) }
    postal_address_code { Faker::Lorem.characters(number: 10) }
    logical_status_code { Faker::Lorem.characters(number: 10) }

    trait :site do
      address_type { 2 }
    end

    trait :company do
      address_type { 1 }
    end
  end
end
