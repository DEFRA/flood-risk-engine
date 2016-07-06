module FloodRiskEngine
  class ReferenceNumber

    def self.with(params)
      new(params).number
    end

    attr_reader :seed, :offset, :minimum_length, :padding, :prefix
    def initialize(
        seed: nil,
        offset: nil,
        minimum_length: nil,
        padding: nil,
        prefix: nil
    )
      @seed = seed
      @offset = offset
      @minimum_length = minimum_length
      @padding = padding
      @prefix = prefix
      check_valid
    end

    def number
      @number ||= [prefix, body].compact.join
    end

    private

    # Main part of reference number without the prefix
    def body
      return increment unless minimum_length
      padded_increment
    end

    # The part of the reference number incremented to make number unique
    def increment
      return seed.to_s unless offset
      (offset + seed).to_s
    end

    def padded_increment
      increment.rjust(body_length, padding)
    end

    # Note that minimum_length defines total length of number, so
    # needs to take into account prefix length if present
    def body_length
      return minimum_length unless prefix && minimum_length
      minimum_length - prefix.length
    end

    def check_valid
      return true unless minimum_length
      raise "A :padding must be specified with a :minimum_length" unless padding
    end
  end
end
