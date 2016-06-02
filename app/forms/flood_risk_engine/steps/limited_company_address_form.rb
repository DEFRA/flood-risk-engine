module FloodRiskEngine
  module Steps

    class LimitedCompanyAddressForm < BaseAddressForm

      def self.factory(enrollment)
        raise(FormObjectError, "No Organisation set for step #{enrollment.current_step}") unless enrollment.organisation

        address = enrollment.organisation.primary_address || FloodRiskEngine::Address.new(address_type: :primary)

        new(address, enrollment)
      end

      def self.params_key
        :limited_company_address
      end

      property :postcode, virtual: true

      # read only param for displaying the Postcode in the view
      def postcode
        return enrollment.address_search.postcode if enrollment.address_search.present?

        return enrollment.organisation.primary_address.postcode if enrollment.organisation.primary_address.present?

        ""
      end

      private

      def initialize(model, enrollment)
        super(model, enrollment)
      end

    end
  end
end
