module FloodRiskEngine
  module Steps
    class PartnershipForm < BaseStepsForm
      def self.factory(enrollment)
        contact = Contact.new
        new(contact, enrollment)
      end

      def self.params_key
        :partnership
      end

      def self.max_length
        70
      end

      # Used to work out whether this is the first partner being created.
      # The count is effectively, the number of partners already built,
      # plus the one being built. So the total number of partners.
      # Counting this way makes the translations easier (:one and :other syntax)
      def partner_count
        enrollment.organisation.partners.count + 1
      end

      property :full_name

      validates(
        :full_name,
        presence: {
          message: t(".errors.full_name.blank")
        },
        "flood_risk_engine/text_field_content" => {
          allow_blank: true
        },
        length: {
          maximum: max_length,
          message: t(".errors.full_name.too_long", max: max_length)
        }
      )

      def save
        super
        enrollment.organisation.partners.create(contact: model)
      end

    end
  end
end
