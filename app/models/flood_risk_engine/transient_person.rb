# frozen_string_literal: true

module FloodRiskEngine
  class TransientPerson < ApplicationRecord
    self.table_name = "transient_people"

    belongs_to :transient_registration
    has_one :transient_addresses, as: :transient_addressable
  end
end
