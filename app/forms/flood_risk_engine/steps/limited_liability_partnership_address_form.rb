module FloodRiskEngine
  module Steps
    class LimitedLiabilityPartnershipAddressForm < BaseAddressForm

      def self.factory(enrollment)
        super enrollment, factory_type: :primary_address
      end

      def self.params_key
        :limited_liability_partnership_address
      end

      private

      def initialize(model, enrollment)
        super(model, enrollment)
      end

    end
  end
end
