module FloodRiskEngine
  class ApplicationMailer < ActionMailer::Base
    helper(EmailHelper)
    layout "flood_risk_engine/layouts/mail"
  end
end
