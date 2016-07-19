module FloodRiskEngine
  module Steps
    class IndividualPostcodeForm < BaseAddressSearchForm

      def self.factory(enrollment)
        super enrollment, factory_type: :address_search
      end

      def self.params_key
        :individual_postcode
      end

    end
  end
end
