module FloodRiskEngine
  module Steps
    class LimitedLiabilityPartnershipNameForm < BaseForm

      def self.factory(enrollment)
        super enrollment, factory_type: :organisation
      end

      def self.params_key
        :limited_liability_partnership_name
      end

      def self.config
        FloodRiskEngine.config
      end

      def self.max_length
        config.maximum_llp_name_length || 170
      end

      property :name

      validates :name, presence: { message: validation_message_when("name.blank") }

      validates :name, 'ea/validators/companies_house_name': true, allow_blank: true

      validates :name, length: {
        maximum: LimitedLiabilityPartnershipNameForm.max_length,
        message: validation_message_when("name.too_long", max_length: LimitedLiabilityPartnershipNameForm.max_length)
      }

      private

      def initialize(model, enrollment)
        super(model, enrollment)
      end

    end
  end
end
