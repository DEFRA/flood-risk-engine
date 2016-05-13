FactoryGirl.define do
  factory :organisation, class: "FloodRiskEngine::Organisation" do
    org_type 0
    name Faker::Company.name
    company_number Faker::Number.number(8)

    after(:build) do |object|
      object.contact = FloodRiskEngine::Contact.create(contact_type: :establishment_or_undertaking)
    end

    # Create a trait for each Type, in format : as_local_authority
    FloodRiskEngine::Organisation.org_types.keys.each do |ot|
      trait :"as_#{ot}" do
        org_type ot.to_s
      end
    end
  end
end
