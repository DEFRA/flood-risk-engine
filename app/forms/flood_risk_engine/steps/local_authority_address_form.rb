module FloodRiskEngine
  module Steps

    class LocalAuthorityAddressForm < BaseAddressForm

      def self.factory(enrollment)
        raise(FormObjectError, "No Organisation set for step #{enrollment.current_step}") unless enrollment.organisation

        new(FloodRiskEngine::Address.new(address_type: :primary), enrollment)
      end

      def self.params_key
        :local_authority_address
      end

      property :postcode, virtual: true

      # read only param for displaying the Postcode in the view
      def postcode
        return enrollment.address_search.postcode if enrollment.address_search.present?

        return enrollment.organisation.primary_address.postcode if enrollment.organisation.primary_address.present?

        ""
      end

      protected

      def assign_to_enrollment(address)
        # addressable does not seem to auto populate via association with organisation, so set manually
        address.attributes = { addressable:  enrollment.organisation, address_type:  :primary }
        enrollment.organisation.primary_address = address

        result = enrollment.organisation.save

        # TOFIX:
        # PENDING - RIp-74 does not specify exact behaviour of back button/link
        # If we clear address_search now, when they go back the drop down
        # is cleared and shows zero results. But not sure what the designers want displayed once an address
        # has been saved. Maybe the dropdown should disappear and the address fields be displayed
        # enrollment.address_search.delete if(result)

        result
      end

    end
  end
end
