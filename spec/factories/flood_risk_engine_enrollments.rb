FactoryGirl.define do
  factory :flood_risk_engine_enrollment, class: "FloodRiskEngine::Enrollment" do
    one "MyString"
    two "MyString"
    three "MyString"
    state "MyString"
  end
end
