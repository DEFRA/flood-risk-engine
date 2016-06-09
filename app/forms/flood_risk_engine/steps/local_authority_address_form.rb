module FloodRiskEngine
  module Steps

    class LocalAuthorityAddressForm < BaseAddressForm

      def self.factory(enrollment)
        raise(FormObjectError, "No Organisation set for step #{enrollment.current_step}") unless enrollment.organisation

        address = enrollment.organisation.primary_address || Address.new(address_type: :primary)

        new(address, enrollment)
      end

      def self.params_key
        :local_authority_address
      end

    end
  end
end
