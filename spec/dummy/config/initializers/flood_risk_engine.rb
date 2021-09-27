# frozen_string_literal: true

FloodRiskEngine.configure do |config|
  config.airbrake_enabled = false
  config.airbrake_host = "http://localhost"
  config.airbrake_project_key = "abcde12345"
  config.airbrake_blocklist = [/password/i, /postcode/i]

  config.default_assistance_mode = 0

  config.companies_house_api_key = ENV["COMPANIES_HOUSE_API_KEY"]
end
FloodRiskEngine.start_airbrake
