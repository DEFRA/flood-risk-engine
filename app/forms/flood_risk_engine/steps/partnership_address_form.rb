module FloodRiskEngine
  module Steps
    class PartnershipAddressForm < BaseAddressForm
      def self.factory(enrollment)
        address = Address.new(address_type: :partner)
        new(address, enrollment)
      end

      def self.params_key
        :partnership_address
      end

      def partner
        enrollment.partners.order(created_at: :asc).last
      end

      def no_header_in_show
        true
      end

      protected

      def assign_to_enrollment(address)
        address.address_type = :primary
        partner.contact.address = address
        partner.contact.save
      end
    end
  end
end
