# frozen_string_literal: true

module FloodRiskEngine
  module CanUpdatePartner
    extend ActiveSupport::Concern

    included do
      attr_accessor :partner

      after_initialize :setup_partner

      private

      def setup_partner
        self.partner = transient_registration.transient_people.last
      end
    end
  end
end
