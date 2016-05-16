# Validate that a grid reference can be processed.
module FloodRiskEngine
  class GridReferenceValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      return true if allow_blank && value.blank?
      OsMapRef::Location.for(value).easting
    rescue OsMapRef::Error => e
      record.errors.add attribute, (message || e.message)
    end

    attr_reader :message, :allow_blank
    def initialize(options)
      @message = options[:message]
      @allow_blank = options[:allow_blank]
      super options
    end
  end
end
