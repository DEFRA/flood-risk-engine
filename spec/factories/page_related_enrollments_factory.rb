# A suite of Enrollments that enable you to jump straight to a particular page in the journey

FactoryGirl.define do
  factory :page_check_location, class: FloodRiskEngine::Enrollment do
  end

  factory :page_local_authority, parent: :enrollment, traits: [:with_exemption, :with_locale_authority] do
    step :local_authority
  end

  factory :page_local_authority_postcode, parent: :page_local_authority do
    step :local_authority_postcode
  end

  factory :page_local_authority_address, parent: :page_local_authority_postcode do
    after(:create) do |object|
      object.create_address_search(postcode: "BS1 5AH")
    end

    step :local_authority_address
  end

  factory :page_correspondence_contact, parent: :page_local_authority_address do
    trait :with_contact do
      after(:create) do |object|
        object.correspondence_contact = create(:flood_risk_engine_contact)
        object.save!
      end
    end
    step :correspondence_contact_name
  end

  factory :page_correspondence_contact_name, parent: :page_correspondence_contact, traits: [:with_contact]

  factory :page_correspondence_contact_email, parent: :page_correspondence_contact_name do
    after(:create) do |object|
      object.correspondence_contact.update_attribute(:email_address, Faker::Internet.email)
    end

    step :correspondence_contact_email
  end

  factory :page_declaration, parent: :page_correspondence_contact_email do
    step :declaration
  end

  factory :page_confirmation, parent: :page_declaration do
    step :confirmation
  end
end
