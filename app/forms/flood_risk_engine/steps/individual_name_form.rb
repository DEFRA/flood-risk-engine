module FloodRiskEngine
  module Steps
    class IndividualNameForm < BaseStepsForm

      def self.factory(enrollment)
        super enrollment, factory_type: :organisation
      end

      def self.params_key
        :individual_name
      end

      def self.config
        FloodRiskEngine.config
      end

      def self.max_length
        config.maximum_individual_name_length || 170
      end

      property :name

      validates :name, presence: { message: validation_message_when("name.blank") }

      validates :name, 'flood_risk_engine/text_field_content': true, allow_blank: true

      validates :name, length: {
        maximum: IndividualNameForm.max_length,
        message: validation_message_when("name.too_long", max_length: IndividualNameForm.max_length)
      }

    end
  end
end
