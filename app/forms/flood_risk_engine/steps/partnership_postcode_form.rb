module FloodRiskEngine
  module Steps
    class PartnershipPostcodeForm < BaseAddressSearchForm

      def self.factory(enrollment)
        enrollment.address_search ||= AddressSearch.new
        new(enrollment.address_search, enrollment)
      end

      def self.params_key
        :partnership_postcode
      end

      def target_step
        :partnership_details
      end

      def partner
        enrollment.partners.order(created_at: :asc).last
      end

      def no_header_in_show
        true
      end

    end
  end
end
