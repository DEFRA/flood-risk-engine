module FloodRiskEngine
  module AddressServices
    class SearchServiceFailure
      attr_accessor :exception

      def initialize(ex)
        @exception = ex
      end

      def self.build(ex)
        trap_vcr_errors_due_to_missing_env_vars(ex)

        Airbrake.notify(ex) if defined? Airbrake

        Rails.logger.error "Address lookup service failed: #{ex}"
        Rails.logger.debug("EA::AddressLookup Config was: #{EA::AddressLookup.config.inspect}") if Rails.env.test?

        SearchServiceFailure.new(ex)
      end

      def self.trap_vcr_errors_due_to_missing_env_vars(ex)
        raise ex if Rails.env.test? && ex.message =~ /VCR/
      end
    end
  end
end
