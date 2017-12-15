module FloodRiskEngine
  module AddressServices
    class SearchServiceFailure
      attr_accessor :exception

      def initialize(ex)
        @exception = ex
      end

      def self.build(ex)
        begin
          # TOFIX - We are still getting errors in Prod in the guts of this Airbrake code
          # Airbrake::Error (can't parse abstract_response.rb:223
          # Have tried unsuccesfully updating airbrake gem and also rolling back to WEX version  "airbrake", "~> 5.2.1"
          #
          Airbrake.notify(ex) if defined? Airbrake
        rescue StandardError
          Rails.logger.error "WARNING!!! - Cannot notify Airbrake of issues with Address Service"
        end

        Rails.logger.error "Address lookup service failed: #{ex}"
        Rails.logger.debug("EA::AddressLookup Config was: #{EA::AddressLookup.config.inspect}") if Rails.env.test?

        SearchServiceFailure.new(ex)
      end

    end
  end
end
