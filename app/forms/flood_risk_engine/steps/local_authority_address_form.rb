module FloodRiskEngine
  module Steps

    class LocalAuthorityAddressForm < BaseAddressForm

      def self.factory(enrollment)
        super enrollment, factory_type: :primary_address
      end

      def self.params_key
        :local_authority_address
      end

    end
  end
end
