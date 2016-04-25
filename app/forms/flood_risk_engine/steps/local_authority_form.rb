module FloodRiskEngine
  module State
    class LocalAuthorityForm < BaseForm

      def self.factory(enrollment)
        new(enrollment)
      end

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :authority_name


      def params_key
        :local_authority
      end

      def save
        super
      end
    end
  end
end
