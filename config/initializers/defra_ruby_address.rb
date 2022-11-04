# frozen_string_literal: true

require "defra_ruby/address"

DefraRuby::Address.configure do |configuration|
  configuration.host = ENV["ADDRESSBASE_URL"] || "http://localhost:9002"
  configuration.key = ENV.fetch("ADDRESS_FACADE_CLIENT_KEY", nil)
  configuration.client_id = ENV.fetch("ADDRESS_FACADE_CLIENT_ID", nil)
end
