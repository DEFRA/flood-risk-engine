# frozen_string_literal: true

module FloodRiskEngine
  class PartnerPresenter
    attr_reader :partner

    delegate :full_name, :address, to: :partner

    def initialize(partner)
      @partner = partner
    end

    def to_single_line
      name_and_address_parts.join(", ")
    end

    def name_and_address_parts
      [full_name] + address.parts
    end
  end
end
