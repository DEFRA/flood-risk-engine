# frozen_string_literal: true

require "defra_ruby/alert"

DefraRuby::Alert.configure do |config|
  config.enabled = false
  config.host = "http://localhost"
  config.project_key = "abcde12345"
  config.root_directory = Rails.root
  config.logger = Rails.logger
  config.environment = Rails.env
end
DefraRuby::Alert.start
