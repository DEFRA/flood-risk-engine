module FloodRiskEngine
  module Steps
    class LocalAuthorityPostcodeForm < BaseAddressSearchForm

      def self.factory(enrollment)
        raise(FormObjectError, "No Organisation set for step #{enrollment.current_step}") unless enrollment.organisation

        enrollment.address_search ||= AddressSearch.new

        new(enrollment.address_search, enrollment)
      end

      def self.params_key
        :local_authority_postcode
      end

      def validate(params)
        result = super(params)
        @target_step = :correspondence_contact_name if !result && manual_entry_enabled?
        result
      end

      private

      def initialize(model, enrollment)
        super(model, enrollment)
      end

    end
  end
end
