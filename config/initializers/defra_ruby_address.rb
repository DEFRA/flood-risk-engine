# frozen_string_literal: true

require "defra_ruby/address"

DefraRuby::Address.configure do |configuration|
  configuration.key = ENV["ADDRESS_FACADE_CLIENT_KEY"]
  configuration.client_id = ENV["ADDRESS_FACADE_CLIENT_ID"]
end
