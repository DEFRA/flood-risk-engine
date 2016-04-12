FactoryGirl.define do
  factory :enrollment, class: "FloodRiskEngine::Enrollment" do
    dummy_boolean true
    dummy_string1 Faker::Lorem.sentence(3)
    dummy_string2 Faker::Lorem.sentence(3)
  end
end
