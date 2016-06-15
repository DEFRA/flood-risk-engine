module FloodRiskEngine
  module Steps
    class IndividualPostcodeForm < BaseAddressSearchForm

      def self.factory(enrollment)
        raise(FormObjectError, "No Organisation set for step #{enrollment.current_step}") unless enrollment.organisation

        enrollment.address_search ||= AddressSearch.new

        new(enrollment.address_search, enrollment)
      end

      def self.params_key
        :individual_postcode
      end

      private

      def initialize(model, enrollment)
        super(model, enrollment)
      end

    end
  end
end
