module FloodRiskEngine
  class StepError < StandardError; end
  class JourneyError < StandardError; end
  class FormObjectError < StandardError; end
  class NotImplementedError < StandardError; end
  class InvalidEnrollmentStateError < StandardError; end
  class MissingEmailAddressError < StandardError; end
  class MissingLocationArgumentError < StandardError; end
end
