module FloodRiskEngine
  module Steps
    class BaseAddressForm < BaseForm

      property :uprn
      property :address_list, virtual: true

      validates :uprn, presence: { message: I18n.t("flood_risk_engine.validation_errors.uprn.blank") }

      validates :uprn, numericality: {
        only_integer: true,
        allow_blank: true,
        message: I18n.t("flood_risk_engine.validation_errors.uprn.format")
      }

      # This is a form reader - provides view with addresses for drop down selection
      def address_list
        @address_list ||= find_by_postcode
      end

      def validate(params)
        valid = super(params)

        # Use UPRN to find address data and assign to our local address instance
        valid = find_and_validate_address_via_uprn if valid

        valid
      end

      def save
        assign_to_enrollment(assignable_address) if assignable_address

        super
      end

      # Derived classes must implement which address instance is being managed
      def assign_to_enrollment(_address)
        raise NotImplementedError, "Address form cannot set underlying Enrollment address"
      end

      protected

      attr_reader :assignable_address

      def find_and_validate_address_via_uprn
        # Use UPRN to find address data
        address_attributes = find_by_uprn

        if address_attributes
          # Given that the address data comes from service we should not validate it here, as these addresses
          # are already displayed to the user for selection so then raising an error is goign to be very confusing
          # N.B Addresses from the service may not have Street address but always have UPRN and Postcode

          # Validation code left for reference, TODO: can be deleted next Sprint
          # validator = AddressValidator.new(address_attributes)

          # if validator.validate
          build_assignable_address(address_attributes)
          # else
          #  validator.clone_errors(self)
          # end

          # validator.valid?
          true
        else
          false
        end
      end

      # Build an assignable address i.e ready to be assigned to any suitable association on enrollment

      def build_assignable_address(address_attributes)
        @assignable_address = Address.new(address_attributes)
        logger.debug("LocalAuthority address now #{@assignable_address.inspect}")
      end

      def find_by_uprn
        logger.debug("Start BaseAddressForm Lookup on UPRN #{uprn}")

        inbound = AddressServices::FindByUprn.new(uprn).search

        # parser used to convert inbound data into a format we can
        # use to construct an Address
        parser = AddressServices::Deserialize::EaFacadeToAddress.new

        flood_address_data = parser.address_data(inbound)

        logger.info("Parsed address #{flood_address_data.first}")

        # We expect at most one address for a uprn
        flood_address_data.first
      end

      def find_by_postcode
        post_code = enrollment.address_search.present? ? enrollment.address_search.postcode : ""

        finder = AddressServices::FindByPostcode.new(post_code)
        inbound = finder.search

        # parser used to convert inbound data into a format for use in Views
        parser = AddressServices::Deserialize::EaFacadeToAddress.new

        parser.selectable_address_data(inbound)
      end

      def initialize(model, enrollment)
        @assignable_address = Address.new
        super(model, enrollment)
      end

    end
  end
end
