FactoryGirl.define do
  factory :organisation, class: "FloodRiskEngine::Organisation" do
    type ""
    name "MyString"
    contact_id 1
    company_number "MyString"
  end
end
