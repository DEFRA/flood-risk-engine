module FloodRiskEngine
  module Steps
    class GridReferenceForm < BaseForm

      def self.factory(enrollment)
        enrollment.exemption_location ||= Location.new
        new(enrollment.exemption_location, enrollment)
      end

      def self.params_key
        :grid_reference
      end

      property :grid_reference

      validates(
        :grid_reference,
        format: {
          with: /([a-zA-Z]{2})\s*(\d{3,5})\s*(\d{3,6})/,
          message: I18n.t("#{locale_key}.errors.grid_reference.invalid"),
          allow_blank: true
        },
        presence: {
          message: I18n.t("#{locale_key}.errors.grid_reference.blank")
        }
      )

      def save
        super
        enrollment.exemption_location ||= model
        enrollment.save
      end
    end
  end
end
