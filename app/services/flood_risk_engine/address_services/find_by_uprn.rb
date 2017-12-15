module FloodRiskEngine
  module AddressServices
    class FindByUprn

      attr_reader :address_data, :address_service_failure

      def initialize(uprn)
        Rails.logger.debug("FindAddressByuPRN supplied with params [#{uprn.inspect}]")
        @uprn = uprn
        @address_data = {}
      end

      def search
        @address_data = begin
          EA::AddressLookup.find_by_uprn(uprn)
        rescue StandardError => ex
          # dont want exception to bubble up but need to know if theres been a failure
          @address_service_failure = SearchServiceFailure.build(ex)
          {}
        end

        @address_data
      end

      def success?
        address_service_failure.nil?
      end

      def failure?
        !success
      end

      private

      attr_reader :uprn

    end
  end
end
