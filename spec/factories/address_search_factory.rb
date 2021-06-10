FactoryBot.define do
  factory :address_search, class: "FloodRiskEngine::AddressSearch" do
    postcode { "BS1 5AH" }
  end
end
