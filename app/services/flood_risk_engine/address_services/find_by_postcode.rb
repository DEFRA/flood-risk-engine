module FloodRiskEngine
  module AddressServices
    class FindByPostcode

      attr_reader :address_result_set, :address_service_failure

      def initialize(post_code)
        Rails.logger.debug("FindByPostcode supplied with params [#{post_code.inspect}]")
        @post_code = post_code
        @address_result_set = []
      end

      def search
        @address_service_failure = nil

        @address_result_set = begin
          EA::AddressLookup.find_by_postcode(post_code)
        rescue => ex
          # dont want exception to bubble up but need to know if there's been a failure
          @address_service_failure = SearchServiceFailure.build(ex)
          []
        end

        @address_result_set
      end

      def success?
        address_service_failure.nil?
      end

      def failure?
        !success
      end

      private

      attr_reader :post_code

    end
  end
end
