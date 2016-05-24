module FloodRiskEngine

  class FinalizeEnrollmentService
    attr_reader :enrollment

    def initialize(enrollment)
      @enrollment = enrollment
    end

    def finalize!
      Rails.logger.info("Enrollment #{enrollment.id} is complete.")

      # Potential TODO: Set the status - probably required when NCCC back office comes along
      # Potential TODO: Send email confirmation to
    end
  end

end
