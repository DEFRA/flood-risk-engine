FactoryGirl.define do
  factory :enrollment, class: "FloodRiskEngine::Enrollment" do
    trait :with_exemption do
      after(:create) do |object|
        exemption = FloodRiskEngine::Exemption.limit(1).order("RANDOM()").first || create(:exemption)
        object.enrollment_exemptions.create(exemption: exemption)
      end
    end
  end
end
