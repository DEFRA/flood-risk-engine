FactoryGirl.define do
  factory :contact, class: "FloodRiskEngine::Contact" do
    contact_type 1
    title 1
    suffix "MyString"
    full_name "John Smith"
    date_of_birth "2016-04-06"
    position "MyString"
    email_address "MyString"
  end
end
