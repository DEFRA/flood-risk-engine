module FloodRiskEngine
  module Steps
    class LimitedLiabilityPartnershipPostcodeForm < BaseAddressSearchForm

      def self.factory(enrollment)
        super enrollment, factory_type: :address_search
      end

      def self.params_key
        :limited_liability_partnership_postcode
      end

      private

      def initialize(model, enrollment)
        super(model, enrollment)
      end

    end
  end
end
