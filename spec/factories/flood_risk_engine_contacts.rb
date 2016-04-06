FactoryGirl.define do
  factory :flood_risk_engine_contact, class: "FloodRiskEngine::Contact" do
    contact_type 1
    title 1
    suffix "MyString"
    first_name "MyString"
    last_name "MyString"
    date_of_birth "2016-04-06"
    position "MyString"
    email_address "MyString"
    primary_address_id 1
    partnership_organisation_id 1
  end
end
