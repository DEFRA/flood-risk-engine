module FloodRiskEngine
  module Steps
    class OtherAddressForm < BaseAddressForm

      def self.factory(enrollment)
        super enrollment, factory_type: :primary_address
      end

      def self.params_key
        :other_address
      end

    end
  end
end
