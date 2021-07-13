# frozen_string_literal: true

module FloodRiskEngine
  class TransientAddress < ApplicationRecord
    self.table_name = "transient_addresses"

    belongs_to :transient_addressable, polymorphic: true

    enum address_type: { unknown: 0, operator: 1, contact: 2, site: 3 }
    enum mode: { unknown_mode: 0, lookup: 1, manual: 2, auto: 3 }
  end
end
