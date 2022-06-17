# Validate that a grid reference can be processed.
module FloodRiskEngine
  class GridReferenceValidator < ActiveModel::EachValidator
    require "os_map_ref"

    attr_reader :message, :allow_blank, :value

    def initialize(options)
      @message = options[:message]
      @allow_blank = options[:allow_blank]
      super options
    end

    def validate_each(record, attribute, value)
      @value = value
      return true if allow_blank && value.blank?
      return true unless os_map_ref_detects_error? || invalid_pattern?

      record.errors.add attribute, message
    end

    private

    def os_map_ref_detects_error?
      OsMapRef::Location.for(value).easting
      false
    rescue OsMapRef::Error => e
      @message ||= e.message
    end

    # Note that OsMapRef will work with less stringent coordinates than are
    # specified for this application - so need to add an additional check.
    def invalid_pattern?
      /\A#{grid_reference_pattern}\z/ !~ value.strip
    end

    def grid_reference_pattern
      [
        two_letters, optional_space, five_digits, optional_space, five_digits
      ].join
    end

    def two_letters
      "[A-Za-z]{2}"
    end

    def five_digits
      '\d{5}'
    end

    def optional_space
      '\s*'
    end
  end
end
