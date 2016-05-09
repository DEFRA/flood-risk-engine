FactoryGirl.define do
  factory :enrollment, class: "FloodRiskEngine::Enrollment" do
    trait :with_locale_authority do
      after(:create) do |object|
        object.organisation = create :organisation, :as_local_authority
        object.save!
      end
    end

    trait :with_exemption do
      after(:create) do |object|
        exemption = FloodRiskEngine::Exemption.limit(1).order("RANDOM()").first || create(:exemption)
        object.enrollment_exemptions.create(exemption: exemption)
      end
    end
  end
end
