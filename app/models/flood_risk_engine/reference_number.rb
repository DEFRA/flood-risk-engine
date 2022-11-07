# frozen_string_literal: true

module FloodRiskEngine
  class ReferenceNumber < ApplicationRecord
    PREFIX = "EXFRA"
    PADDING = "0"
    OFFSET = 1_000
    MINIMUM_LENGTH = 11

    after_create :generate_number

    def increment
      (id + OFFSET).to_s
    end

    private

    def generate_number
      self.number = [
        PREFIX,
        increment.rjust(padding_length, PADDING)
      ].join
      save
    end

    def padding_length
      MINIMUM_LENGTH - PREFIX.length
    end
  end
end
