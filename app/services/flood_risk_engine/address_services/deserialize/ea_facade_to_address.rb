# Specific converter - convert EA AddressFacade into other usable forms

module FloodRiskEngine
  module AddressServices
    module Deserialize

      class EaFacadeToAddress

        def self.contains_addresses?(inbound)
          return true if inbound && inbound.is_a?(Hash) && !inbound["results"].empty?

          false
        end

        def selectable_address_data(inbound)
          addresses = inbound["results"] if inbound && inbound.is_a?(Hash)

          addresses ||= []

          results = addresses.collect do |a|
            {
              moniker: a["address"],
              uprn: a["uprn"]
            }
          end

          results
        end

        # Builds collection of attributes in correct format to simply
        # pass to Address new or create - to build an Address (plus Location)

        def address_data(inbound) # rubocop:disable Metrics/MethodLength:
          addresses = inbound["results"] if inbound

          addresses ||= []

          results = addresses.collect do |a|
            a.default = ""

            {
              premises: a["premises"],
              street_address: a["street_address"],
              locality: a["locality"],
              city: a["city"],
              postcode: a["postcode"],
              organisation: a["organisation"] || "",
              state_date: a["state_date"],
              blpu_state_code: a["blpu_state_code"],
              postal_address_code: a["postal_address_code"],
              logical_status_code: a["logical_status_code"],
              uprn: a["uprn"]
            }
          end

          results
        end

        def location_data(inbound)
          addresses = inbound["results"] if inbound

          addresses ||= []

          results = addresses.collect do |a|
            a.default = ""
            {
              easting: EaFacadeToAddress.format_xy(a["x"]),
              northing: EaFacadeToAddress.format_xy(a["y"])
            }
          end

          results
        end

        def self.format_xy(inbound)
          return inbound if inbound.blank?
          # the format can contain leading 0 so have to treat f,d as a string
          f, d = inbound.split(".")
          "#{f.rjust(6, '0')}.#{d || 0}" # handle strings with or without a '.'
        end

      end
    end
  end
end
