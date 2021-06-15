# Factory fails unless class has be initiated, hence using :name method (\o/)
FactoryBot.define do
  factory :enrollment, class: FloodRiskEngine::Enrollment.name do
    # Create a trait for each Type, in format : with_local_authority, etc
    #   local_authority
    #   limited_company
    #   limited_liability_partnership
    #   individual
    #   partnership
    #   other
    #   unknown

    FloodRiskEngine::Organisation.org_types.each_key do |ot|
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

    trait :with_dredging_exemption do
      after(:build) do |object|
        dredging_code = FloodRiskEngine::Exemption::LONG_DREDGING_CODES.sample
        exemption = create(:exemption, code: dredging_code)
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
        object.organisation.primary_address = build(:address, :primary)
      end
    end

    trait :with_correspondence_contact do
      after(:stub) do |object|
        object.correspondence_contact = build_stubbed :contact
      end
      after(:build) do |object|
        object.correspondence_contact = build :contact
      end
    end

    trait :with_secondary_contact do
      after(:stub) do |object|
        object.secondary_contact = build_stubbed :contact
      end
      after(:build) do |object|
        object.secondary_contact = build :contact
      end
    end

    trait :with_address_search do
      after(:stub) do |object|
        object.address_search = build_stubbed :address_search
      end
      after(:build) do |object|
        object.address_search = build :address_search
      end
    end
  end
end
