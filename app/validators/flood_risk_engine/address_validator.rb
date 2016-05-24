module FloodRiskEngine
  class AddressValidator

    include ActiveModel::Validations

    # The subset of all address fields - only those we currently need to validate

    attr_accessor :premises, :street_address, :locality, :city

    def initialize(attributes = {})
      attributes.each do |name, value|
        writer = "#{name}="
        send(writer, value) if respond_to? writer
      end
    end

    validates :premises, presence: { message: I18n.t("flood_risk_engine.validation_errors.address.premises.blank") }

    validates :premises,
              length: {
                maximum: 200,
                message: I18n.t(".errors.premises.too_long", max: 200)
              }

    validates :street_address, presence: {
      message: I18n.t("flood_risk_engine.validation_errors.address.street_address.blank")
    }

    validates :street_address,
              length: {
                maximum: 160,
                message: I18n.t("flood_risk_engine.validation_errors.address.street_address.too_long", max: 160)
              }

    validates :locality,
              length: {
                maximum: 70,
                message: I18n.t("flood_risk_engine.validation_errors.address.locality.too_long", max: 70)
              }

    validates :city, presence: { message: I18n.t("flood_risk_engine.validation_errors.address.city.blank") }

    validates :city, length: {
      maximum: 30,
      message: I18n.t("flood_risk_engine.validation_errors.address.city.too_long", max: 30)
    }

  end
end
