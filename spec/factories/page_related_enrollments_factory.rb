# A suite of Enrollments that enable you to jump straight to a particular page in the journey

FactoryGirl.define do
  factory :page_check_location, class: FloodRiskEngine::Enrollment do
  end

  factory :page_local_authority, parent: :enrollment,
                                 traits: [:with_exemption, :with_locale_authority] do
    step :local_authority
  end

  factory :page_correspondence_contact_name, parent: :page_local_authority do
    step :correspondence_contact_name
  end

  factory :page_correspondence_contact_email, parent: :page_correspondence_contact_name do
    step :correspondence_contact_email
  end
end
