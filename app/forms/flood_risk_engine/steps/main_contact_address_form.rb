module FloodRiskEngine
  module Steps
    class MainContactAddressForm < BaseForm

      # For full API see  - https://github.com/apotonick/reform
        property :postcode
        property :premises
        property :street_address
        property :locality
        property :city

      def self.factory(enrollment)
        address =  Address.new
        new(address, enrollment)
      end

      def params_key
        :main_contact_address
      end

      def save
        super
      end
    end
  end
end
