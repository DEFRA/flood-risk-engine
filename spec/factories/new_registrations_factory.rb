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
  end
end
