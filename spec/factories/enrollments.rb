FactoryGirl.define do
  factory :enrollment, class: "FloodRiskEngine::Enrollment" do
    # Create a trait for each Type, in format : with_local_authority, etc
    #   local_authority
    #   limited_company
    #   limited_liability_partnership
    #   individual
    #   partnership
    #   other
    #   unknown
    FloodRiskEngine::Organisation.org_types.keys.each do |ot|
      trait :"with_#{ot}" do
        after(:build) { |object| object.organisation = create(:organisation, :"as_#{ot}") }
      end
    end

    trait :with_exemption do
      after(:build) do |object|
        exemption = FloodRiskEngine::Exemption.limit(1).order("RANDOM()").first || create(:exemption)
        object.enrollment_exemptions.build(exemption: exemption)
      end
    end

    trait :with_exemption_location do
      after(:build) do |object|
        object.exemption_location = build(:location)
      end
    end

    trait :with_organisation_address do
      after(:build) do |object|
        object.organisation.primary_address = build :address_services
      end
    end

    trait :with_correspondence_contact do
      after(:build) do |object|
        object.correspondence_contact = build :contact
      end
    end
  end
end
