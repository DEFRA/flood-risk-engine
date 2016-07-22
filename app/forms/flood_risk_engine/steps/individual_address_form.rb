module FloodRiskEngine
  module Steps

    class IndividualAddressForm < BaseAddressForm

      def self.factory(enrollment)
        super enrollment, factory_type: :primary_address
      end

      def self.params_key
        :individual_address
      end

    end
  end
end
