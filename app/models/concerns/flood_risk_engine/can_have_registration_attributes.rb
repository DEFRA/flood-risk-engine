# frozen_string_literal: true

module FloodRiskEngine
  module CanHaveRegistrationAttributes
    extend ActiveSupport::Concern

    def company_no_required?
      false
    end

    def partnership?
      false
    end
  end
end
