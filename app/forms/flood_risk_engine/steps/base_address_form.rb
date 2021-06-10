module FloodRiskEngine
  module Steps
    class BaseAddressForm < BaseForm

      property :uprn
      property :temp_addresses, virtual: true

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

      validates :uprn, presence: { message: I18n.t("flood_risk_engine.validation_errors.uprn.blank") }

      validates :uprn, numericality: {
        only_integer: true,
        allow_blank: true,
        message: I18n.t("flood_risk_engine.validation_errors.uprn.format")
      }

      # This is a form reader - provides view with addresses for drop down selection
      def temp_addresses
        @temp_addresses ||= look_up_addresses
      end

      def initialize(model, enrollment = nil)
        super(model, enrollment)
        temp_addresses
      end

      def validate(params)
        # Use UPRN to find address data and assign to our local address instance
        super(params) && select_and_build_address
      end

      def save
        assign_to_enrollment(assignable_address) if assignable_address
        super
      end

      property :postcode, virtual: true

      # read only param for displaying the Postcode in the view
      def postcode
        address_search_postcode || primary_address_postcode || ""
      end

      protected

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

      def select_and_build_address
        address_attributes = get_address_data

        if address_attributes
          # Given that the address data comes from service we should not validate it here, as these addresses
          # are already displayed to the user for selection so then raising an error is going to be very confusing
          # N.B Addresses from the service may not have Street address but always have UPRN and Postcode
          build_assignable_address(address_attributes)

          true
        else
          false
        end
      end

      def get_address_data
        return {} if uprn.blank?

        data = temp_addresses.detect { |address| address["uprn"] == uprn.to_i }
        return {} unless data

        data.slice(*ADDRESS_DATA_KEYS)
      end

      def address_search_postcode
        enrollment.address_search.try(:postcode)
      end

      def primary_address_postcode
        enrollment.organisation.try(:primary_address).try(:postcode)
      end

      # Most address pages are almost identical for each OrgType so
      # use a default of assigning to Organisation Primary_address

      def assign_to_enrollment(address)
        address.address_type = :primary
        enrollment.organisation.primary_address = address
        enrollment.organisation.save
      end

      # Build an assignable address i.e ready to be assigned to any suitable association on enrollment
      def build_assignable_address(address_attributes)
        @assignable_address = Address.new(address_attributes)
        logger.debug("#{self.class} address now #{@assignable_address.inspect}")
      end

      def assignable_address
        @assignable_address ||= Address.new
      end

      # parser used to convert inbound data into a format we can
      # use to construct an Address
      def parser
        AddressServices::Deserialize::EaFacadeToAddress.new
      end

    end
  end
end
