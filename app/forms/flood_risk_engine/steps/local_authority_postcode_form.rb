module FloodRiskEngine
  module Steps
    class LocalAuthorityPostcodeForm < BaseAddressSearchForm

      def self.factory(enrollment)
        super enrollment, factory_type: :address_search
      end

      def self.params_key
        :local_authority_postcode
      end

      def target_step
        :correspondence_contact_name
      end
    end
  end
end
