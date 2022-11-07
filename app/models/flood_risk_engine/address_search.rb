# frozen_string_literal: true

module FloodRiskEngine
  class AddressSearch < ApplicationRecord
    belongs_to :enrollment
  end
end
