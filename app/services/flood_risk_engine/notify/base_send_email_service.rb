# frozen_string_literal: true

module FloodRiskEngine
  module Notify
    class BaseSendEmailService < BaseService
      def run(enrollment:, recipient_address:)
        @enrollment = enrollment
        @recipient_address = recipient_address

        client = Notifications::Client.new(FloodRiskEngine.config.notify_api_key)

        client.send_email(notify_options)
      end

      protected

      def exemption
        @_exemption ||= @enrollment.exemptions.first
      end

      def enrollment_description
        "#{exemption.summary} #{exemption.code}"
      end
    end
  end
end
