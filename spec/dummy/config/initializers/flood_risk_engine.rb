# frozen_string_literal: true

FloodRiskEngine.configure do |config|
  config.airbrake_enabled = false
  config.airbrake_host = "http://localhost"
  config.airbrake_project_key = "abcde12345"
end
FloodRiskEngine.start_airbrake
