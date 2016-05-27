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
            # Note, we only need to validate the postcode search not the underlying adddress data
            unless FloodRiskEngine::AddressServices::Deserialize::EaFacadeToAddress.contains_addresses?(address_list)
              errors.add :postcode, I18n.t("flood_risk_engine.validation_errors.postcode.no_addresses_found")
            end
          else
            errors.add :postcode, I18n.t("flood_risk_engine.validation_errors.postcode.service_unavailable")
          end

          result = errors[:postcode].empty?

          # RIP-74 states when search valid but no postcodes or service type failure, include Manual Address entry link
          @manual_entry_enabled = !result
        end

        result
      end

      # If manual entry activated gives opportunity to  skip certain states and move straight to this target state
      attr_reader :target_step

      def manual_entry_enabled?
        @manual_entry_enabled
      end

    end

  end
end
