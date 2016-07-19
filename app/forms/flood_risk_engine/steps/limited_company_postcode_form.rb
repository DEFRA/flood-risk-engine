module FloodRiskEngine
  module Steps
    class LimitedCompanyPostcodeForm < BaseAddressSearchForm

      def self.factory(enrollment)
        super enrollment, factory_type: :address_search
      end

      def self.params_key
        :limited_company_postcode
      end

      def target_step
        :correspondence_contact_name
      end

    end
  end
end
