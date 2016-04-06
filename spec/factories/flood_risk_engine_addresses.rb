FactoryGirl.define do
  factory :address, class: "FloodRiskEngine::Address" do
    premises "MyString"
    street_address "MyString"
    locality "MyString"
    city "MyString"
    postcode "MyString"
    county_province_id 1
    country_iso "MyString"
    address_type 1
    organisation "MyString"
    state_date "2016-04-06"
    blpu_state_code "MyString"
    postal_address_code "MyString"
    logical_status_code "MyString"
  end
end
