# frozen_string_literal: true

FactoryBot.define do
  factory :new_registration, class: FloodRiskEngine::NewRegistration do
    trait :has_company_address do
      company_address { build(:transient_address, :company) }
    end

    trait :has_named_partner do
      transient_people { [build(:transient_person, :named)] }
    end

    trait :has_named_partner_with_postcode do
      transient_people { [build(:transient_person, :named, :has_temp_postcode)] }
    end

    trait :has_required_data do
      business_type { "soleTrader" }
      company_name { Faker::Company.name }
      contact_email { generate(:random_email) }
      contact_name { Faker::Name.name }
      contact_phone { Faker::PhoneNumber.phone_number }
      contact_position { Faker::Company.profession }
      temp_grid_reference { Faker::Number.number(digits: 10) }
      temp_site_description { Faker::Lorem.sentence }

      exemptions { [build(:exemption)] }
    end

    trait :has_required_data_for_limited_company do
      has_required_data
      has_company_address

      business_type { "limitedCompany" }
      company_number { Faker::Number.number(digits: 8) }
    end

    trait :has_required_data_for_partnership do
      has_required_data

      business_type { "partnership" }
      transient_people { build_list(:transient_person, 2, :named, :completed) }
    end
  end
end
