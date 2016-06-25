FactoryGirl.define do
  factory :comment, class: "FloodRiskEngine::Comment" do
    user_id nil
    association :commentable, factory: :enrollment_exemption
    content Faker::Lorem.paragraph
    event Faker::Lorem.sentence
  end
end
