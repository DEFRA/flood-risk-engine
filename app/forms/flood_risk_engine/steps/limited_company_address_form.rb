module FloodRiskEngine
  module Steps

    class LimitedCompanyAddressForm < BaseAddressForm

      def self.factory(enrollment)
        super enrollment, factory_type: :primary_address
      end

      def self.params_key
        :limited_company_address
      end

    end
  end
end
