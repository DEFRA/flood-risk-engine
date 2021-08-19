FactoryBot.define do
  factory :transient_person, class: "FloodRiskEngine::Transient_Person" do
    trait :named do
      full_name { Faker::Name.name }
    end

    trait :has_temp_postcode do
      temp_postcode { "BS1 5AH" }
    end
  end
end
