module FloodRiskEngine
  module Steps
    class LimitedLiabilityPartnershipNumberForm < BaseForm

      def self.factory(enrollment)
        super enrollment, factory_type: :organisation
      end

      def self.params_key
        :limited_liability_partnership_number
      end

      property :registration_number

      validates :registration_number, presence: { message: t(".errors.blank") }

      validates :registration_number, 'ea/validators/companies_house_number': { allow_blank: true }

      private

      def initialize(model, enrollment)
        super(model, enrollment)
      end

    end
  end
end
