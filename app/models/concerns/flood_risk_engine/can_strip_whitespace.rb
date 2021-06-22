# frozen_string_literal: true

module FloodRiskEngine
  # Used to clean up excess whitespace from the start and end of fields
  module CanStripWhitespace
    extend ActiveSupport::Concern

    # Expects a hash of attributes or a Mongoid object
    def strip_whitespace(attributes)
      # Loop over each value and strip the whitespace, or strip the whitespace from values nested within it
      attributes.each_pair do |key, value|
        if value.is_a?(String)
          attributes[key] = strip_string(value)
        elsif value.is_a?(Hash) || value.is_a?(ActionController::Parameters)
          strip_hash(value)
        elsif value.is_a?(Array)
          strip_array(value)
        end
      end
    end

    private

    def strip_string(string)
      string.strip
    end

    def strip_hash(hash)
      strip_whitespace(hash)
    end

    def strip_array(array)
      array.each do |nested_object|
        strip_whitespace(nested_object.attributes) if nested_object.respond_to?(:attributes)
      end
    end
  end
end
