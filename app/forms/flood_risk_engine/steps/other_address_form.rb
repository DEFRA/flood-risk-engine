module FloodRiskEngine
  module Steps
    class OtherAddressForm < BaseAddressForm

      def self.factory(enrollment)
        raise(FormObjectError, "No Organisation set for step #{enrollment.current_step}") unless enrollment.organisation
        address = enrollment.organisation.primary_address || Address.new(address_type: :primary)
        new(address, enrollment)
      end

      def self.params_key
        :other_address
      end

      property :postcode, virtual: true

      # read only param for displaying the Postcode in the view
      def postcode
        return enrollment.address_search.postcode if enrollment.address_search.present?
        return enrollment.organisation.primary_address.postcode if enrollment.organisation.primary_address.present?
        ""
      end
    end
  end
end
