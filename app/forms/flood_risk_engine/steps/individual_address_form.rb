module FloodRiskEngine
  module Steps

    class IndividualAddressForm < BaseAddressForm

      def self.factory(enrollment)
        raise(FormObjectError, "No Organisation set for step #{enrollment.current_step}") unless enrollment.organisation

        address = enrollment.organisation.primary_address || FloodRiskEngine::Address.new(address_type: :primary)

        new(address, enrollment)
      end

      def self.params_key
        :individual_address
      end

    end
  end
end
