# frozen_string_literal: true

module FloodRiskEngine
  class TransientPerson < ApplicationRecord
    self.table_name = "transient_people"

    belongs_to :transient_registration
    has_one :transient_address, as: :addressable, dependent: :destroy
    accepts_nested_attributes_for :transient_address
  end
end
