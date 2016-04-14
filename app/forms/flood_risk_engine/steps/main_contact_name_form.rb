module FloodRiskEngine
  module Steps
    class MainContactNameForm < BaseForm

      # Define the attributes on the inbound model, that you want included in your form/validation with
      # property :name
      # For full API see  - https://github.com/apotonick/reform
        property :full_name
        property :position

      def self.factory(enrollment)
        contact = enrollment.correspondence_contact || Contact.new
        new(contact, enrollment)
      end

      def params_key
        :main_contact_name
      end

      def save
        super
      end
    end
  end
end
