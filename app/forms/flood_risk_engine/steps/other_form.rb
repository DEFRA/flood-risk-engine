module FloodRiskEngine
  module Steps
    class OtherForm < BaseForm

      def self.factory(enrollment)
        organisation = enrollment.organisation || Organisation.new
        new(organisation, enrollment)
      end

      def self.params_key
        :other
      end

      def self.max_length
        200
      end

      property :name

      validates(
        :name,
        presence: {
          message: t(".errors.name.blank")
        },
        "flood_risk_engine/text_field_content" => {
          allow_blank: true
        },
        length: {
          maximum: max_length,
          message: t(".errors.name.too_long", max: max_length)
        }
      )

      def save
        super
        enrollment.organisation ||= model
        enrollment.save
      end
    end
  end
end
