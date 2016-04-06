# rubocop:disable IndentationConsistency, IndentationWidth
FactoryGirl.define do
  factory :address, class: "FloodRiskEngine::Address" do
               premises Faker::Address.building_number
         street_address Faker::Address.street_address
               locality Faker::StarWars.planet
                   city Faker::Address.city
               postcode Faker::Address.postcode
     county_province_id 1
            country_iso Faker::Address.country_code
           address_type 1
           organisation Faker::Company.name
             state_date 1.year.ago
        blpu_state_code Faker::Lorem.characters(10)
    postal_address_code Faker::Lorem.characters(10)
    logical_status_code Faker::Lorem.characters(10)
  end
end
# rubocop:enable IndentationConsistency, IndentationWidth
