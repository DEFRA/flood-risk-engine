module FloodRiskEngine
  module Steps
    class IndividualPostcodeForm < BaseForm

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
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
        :individual_postcode
      end

      def save
        super
      end
    end
  end
end
