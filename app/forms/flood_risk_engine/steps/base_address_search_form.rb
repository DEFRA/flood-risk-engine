module FloodRiskEngine
  module Steps
    class BaseAddressSearchForm < BaseRedirectableForm

      property :postcode

      validates :postcode, presence: { message: I18n.t("flood_risk_engine.validation_errors.postcode.blank") }

      validates :postcode, 'flood_risk_engine/postcode': true, allow_blank: true

      # rubocop:disable Metrics/MethodLength
      def validate(params)
        result = super(params)

        if result
          finder = AddressServices::FindByPostcode.new(postcode)

          address_list = finder.search

          if finder.success?

            # Note, we only need to validate the postcode search not the underlying address data
            unless FloodRiskEngine::AddressServices::Deserialize::EaFacadeToAddress.contains_addresses?(address_list)

              # This is a Valid UK postcode but it does not currently point to any addresses.
              # If we don't save this postcode in the search, get inconsistencies when users enters a Manual
              # address and then goes back
              sync
              model.save

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
      # rubocop:enable Metrics/MethodLength

      def manual_entry_enabled?
        @manual_entry_enabled
      end

      # Currently all OrgType journeys lead from Address to Correspondence Contact Name
      def target_step
        :correspondence_contact_name
      end

    end

  end
end
