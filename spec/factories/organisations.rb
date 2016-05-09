FactoryGirl.define do
  factory :organisation, class: "FloodRiskEngine::Organisation" do
    org_type 0
    name Faker::Company.name
    contact_id 1
    company_number Faker::Number.number(8)

    # Create a trait for each Type, in format : as_local_authority

    FloodRiskEngine::Organisation.org_types.keys.each do |ot|
      trait_name = :"as_#{ot}"

      trait trait_name do
        org_type ot.to_s
      end
    end

  end
end
