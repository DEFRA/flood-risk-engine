# frozen_string_literal: true

module FloodRiskEngine
  class TransientAddress < ApplicationRecord
    self.table_name = "transient_addresses"

    belongs_to :addressable, polymorphic: true

    enum address_type: { unknown: 0, operator: 1, contact: 2, site: 3 }

    def manual?
      uprn.blank?
    end
  end
end
