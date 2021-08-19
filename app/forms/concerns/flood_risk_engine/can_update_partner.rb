# frozen_string_literal: true

module FloodRiskEngine
  module CanUpdatePartner
    extend ActiveSupport::Concern

    included do
      attr_accessor :partner

      after_initialize :setup_partner

      private

      def setup_partner
        puts "AWOOOOOOOGA"
        puts transient_registration.transient_people.to_json
        self.partner = transient_registration.transient_people.last
        puts partner.to_json
      end
    end
  end
end
