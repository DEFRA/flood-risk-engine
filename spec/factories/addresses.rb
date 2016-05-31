require "uk_postcode"

FactoryGirl.define do
  factory :address, class: "FloodRiskEngine::Address" do
    premises            Faker::Address.building_number
    street_address      Faker::Address.street_address
    locality            Faker::StarWars.planet
    city                Faker::Address.city
    postcode            Faker::Address.postcode
    county_province_id  1
    country_iso         Faker::Address.country_code
    address_type        1
    organisation        Faker::Company.name
    state_date          1.year.ago
    blpu_state_code     Faker::Lorem.characters(10)
    postal_address_code Faker::Lorem.characters(10)
    logical_status_code Faker::Lorem.characters(10)
  end

  factory :simple_address, class: "FloodRiskEngine::Address" do
    premises            Faker::Address.building_number
    street_address      Faker::Address.street_address
    locality            Faker::StarWars.planet
    city                Faker::Address.city
    postcode            { generate :uk_post_code }
  end

  factory :address_services, parent: :address

  # Faker.postcode seems to produce invalid postcodes now & then
  # so try to bodge our own
  #     https://en.wikipedia.org/wiki/Postcodes_in_the_United_Kingdom
  #
  #
  #  The letters QVX are not used in the first position.
  #  The letters IJZ are not used in the second position.
  #  The only letters to appear in the third position are ABCDEFGHJKPSTUW when the structure starts with A9A.
  #  The only letters to appear in the fourth position are ABEHMNPRVWXY when the structure starts with AA9A.
  #  The final two letters do not use the letters CIKMOV, so as not to resemble digits or each other when hand-written.
  #
  # rubocop:disable Lint/Loop
  #
  sequence(:uk_post_code) do |_n|
    @valid_sequence_1_for_uk_postcode ||= ("A".."Z").to_a - %w(Q V X)
    @valid_sequence_2_for_uk_postcode ||= ("A".."Y").to_a - %w(I J)
    @valid_sequence_3_for_uk_postcode ||= ("A".."K").to_a
    @valid_sequence_4_for_uk_postcode ||= ("A".."Z").to_a - %w(C I K M O V J)

    begin
      shuffled1 = @valid_sequence_1_for_uk_postcode.shuffle
      shuffled2 = @valid_sequence_2_for_uk_postcode.shuffle
      shuffled3 = @valid_sequence_3_for_uk_postcode.shuffle
      shuffled4 = @valid_sequence_4_for_uk_postcode.shuffle

      pc = UKPostcode.parse("#{shuffled1.first}#{shuffled2.first}#{rand 9} #{rand 9}#{shuffled3.last}#{shuffled4.last}")
    end until pc.valid?
    pc.to_s
  end
end
