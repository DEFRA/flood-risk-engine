# frozen_string_literal: true

module FloodRiskEngine
  class BaseAddressLookupForm < BaseForm
    attr_accessor :temp_addresses

    after_initialize :look_up_addresses

    ADDRESS_DATA_KEYS = %w[uprn
                           organisation
                           premises
                           street_address
                           locality
                           city
                           postcode
                           state_date
                           blpu_state_code
                           postal_address_code
                           logical_status_code
                           county_province_id
                           country_iso].freeze

    private

    # Look up addresses based on the postcode
    def look_up_addresses
      self.temp_addresses = if postcode.present?
                              request_matching_addresses
                            else
                              []
                            end
    end

    def request_matching_addresses
      AddressLookupService.run(postcode).results
    end

    def get_address_data(uprn, type)
      return {} if uprn.blank?

      data = temp_addresses.detect { |address| address["uprn"] == uprn.to_i }
      return {} unless data

      data
        .slice(*ADDRESS_DATA_KEYS)
        .merge(address_type: type)
    end
  end
end
