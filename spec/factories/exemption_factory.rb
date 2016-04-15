FactoryGirl.define do
  sequence(:exemption_code) { |n| ("FRA_RSPEC_%0d" % n) }

  factory :exemption, class: FloodRiskEngine::Exemption do
    code { generate(:exemption_code) }

    summary "The construction of footbridges"
    description "This exemption is only for testing"
  end
end
