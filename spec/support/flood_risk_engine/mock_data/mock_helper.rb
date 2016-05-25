require_relative "mock_data"
module FloodRiskEngine
  module MockHelper
    # Use data from:
    #   spec/support/flood_risk_engine/mock_data/address_lookup.yml
    # to mock calls to EA::AddressLookup
    module AddressLookup

      def mock_find_by_uprn
        allow(EA::AddressLookup)
          .to receive(:find_by_uprn)
          .and_return(mock_data.data_for(:uprn_lookup))
      end

      def mock_failure_to_find_by_uprn
        allow(EA::AddressLookup)
          .to receive(:find_by_uprn)
          .and_raise("Whoops")
      end

      def mock_find_by_postcode
        allow(EA::AddressLookup)
          .to receive(:find_by_postcode)
          .and_return(mock_data.data_for(:postcode_lookup))
      end

      def mock_failure_to_find_by_postcode
        allow(EA::AddressLookup)
          .to receive(:find_by_postcode)
          .and_raise("Whoops")
      end

      private

      def mock_data
        @mock_data ||= FloodRiskEngine::MockData.new :address_lookup
      end

    end
  end
end
