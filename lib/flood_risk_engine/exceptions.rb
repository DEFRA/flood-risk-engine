# frozen_string_literal: true

module FloodRiskEngine
  class InvalidEnrollmentStateError < StandardError; end
  class MissingEmailAddressError < StandardError; end
  class MissingLocationArgumentError < StandardError; end
end
