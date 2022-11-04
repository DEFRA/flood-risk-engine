# frozen_string_literal: true

unless Rails.application.config.consider_all_requests_local
  Rails.application.config.exceptions_app = FloodRiskEngine::Engine.routes
end
