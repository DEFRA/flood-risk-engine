module FloodRiskEngine
  module Steps
    class BaseAddressSearchForm < BaseRedirectableForm

      property :postcode

      validates :postcode, presence: { message: I18n.t("flood_risk_engine.validation_errors.postcode.blank") }

      validates :postcode, 'flood_risk_engine/postcode': true, allow_blank: true

      def validate(params)
        result = super(params)

        if result
          finder = AddressServices::FindByPostcode.new(postcode)

          address_list = finder.search

          if finder.success?
            unless FloodRiskEngine::AddressServices::Deserialize::EaFacadeToAddress.contains_addresses?(address_list)
              errors.add :postcode, I18n.t("flood_risk_engine.validation_errors.postcode.no_addresses_found")
              result = false
            end
          else
            # TODO: RIP-74 states in this situation to open Manual Address entry
            # so probably need to also setup the redirect URL here
            # redirection_url = manual_address_path.....
            # redirect = true
            errors.add :postcode, I18n.t("flood_risk_engine.validation_errors.postcode.service_unavailable")
            result = false
          end
        end

        result
      end

    end

  end
end
