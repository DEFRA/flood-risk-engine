# frozen_string_literal: true

require "defra_ruby_email"

DefraRubyEmail.configure do |configuration|
  configuration.notify_api_key = ENV.fetch("NOTIFY_API_KEY")
end
