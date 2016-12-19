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

      # We are required to display a notice regarding use of OS places data in
      # postcode lookup pages. However we wish to display this below the
      # continue button, which means those pages have to take control of where
      # it is positioned. To do this we override the show_continue_button? and
      # return false, so that
      # app/views/flood_risk_engine/enrollments/steps/show.html.erb knows not
      # to take control for showing the button.
      def show_continue_button?
        false
      end

    end

  end
end
