FactoryGirl.define do
  factory :contact, class: "FloodRiskEngine::Contact" do
    title 1
    full_name Faker::Name.name
    suffix Faker::Name.suffix
    date_of_birth 30.years.ago
    position Faker::Company.profession
    email_address Faker::Internet.safe_email
    telephone_number Faker::PhoneNumber.phone_number
  end
end
