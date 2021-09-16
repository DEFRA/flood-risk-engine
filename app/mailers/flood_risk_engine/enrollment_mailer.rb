module FloodRiskEngine
  class EnrollmentMailer < ApplicationMailer
    def submitted(enrollment_id:, recipient_address:)
      i18n_scope = "flood_risk_engine.enrollment_mailer.submitted"
      subject = I18n.t(".subject", scope: i18n_scope)
      @enrollment = Enrollment.find(enrollment_id)
      @exemption = @enrollment.exemptions.first

      mail to: recipient_address,
           from: ENV["DEVISE_MAILER_SENDER"],
           subject: subject
    end
  end
end
