# A suite of Enrollments that enable you to jump straight to a particular page in the jounrey

FactoryGirl.define do
  factory :page_check_location, class: FloodRiskEngine::Enrollment do
  end

  factory :page_local_authority, class: FloodRiskEngine::Enrollment do
    step :local_authority
  end
end
