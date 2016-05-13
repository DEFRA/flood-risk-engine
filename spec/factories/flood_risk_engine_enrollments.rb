FactoryGirl.define do
  factory :enrollment, class: "FloodRiskEngine::Enrollment" do
    trait :with_locale_authority do
      after(:build) do |object|
        object.organisation = build :organisation, :as_local_authority
      end
    end

    trait :with_exemption do
      after(:build) do |object|
        exemption = FloodRiskEngine::Exemption.limit(1).order("RANDOM()").first || create(:exemption)
        object.enrollment_exemptions.build(exemption: exemption)
      end
    end

    trait :with_exemption_location do
      after(:build) do |object|
        object.exemption_location = build(:location)
      end
    end
  end
end
