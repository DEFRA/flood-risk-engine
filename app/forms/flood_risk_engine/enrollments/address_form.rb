module FloodRiskEngine
  module Enrollments
    class AddressForm < Reform::Form

      def self.t(locale, args = {})
        I18n.t "flood_risk_engine.enrollments.addresses#{locale}", args
      end

      property :premises
      validates(
        :premises,
        presence: { message: t(".errors.premises.blank") },
        length: {
          maximum: 200,
          message: t(".errors.premises.too_long", max: 200)
        }
      )

      property :street_address
      validates(
        :street_address,
        presence: { message: t(".errors.street_address.blank") },
        length: {
          maximum: 160,
          message: t(".errors.street_address.too_long", max: 160)
        }
      )

      property :locality
      validates(
        :locality,
        length: {
          maximum: 70,
          message: t(".errors.locality.too_long", max: 70)
        }
      )

      property :city
      validates(
        :city,
        presence: { message: t(".errors.city.blank") },
        length: {
          maximum: 30,
          message: t(".errors.city.too_long", max: 30)
        }
      )

      #      alias address model
      attr_reader :enrollment
      delegate :id, to: :enrollment, prefix: true

      def initialize(enrollment, address)
        @enrollment = enrollment
        super(address)
      end

      def validate(params)
        super params.fetch(:address, {})
      end

    end
  end
end
