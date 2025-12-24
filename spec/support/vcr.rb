# frozen_string_literal: true

# Stubbing HTTP requests
require "webmock/rspec"
# Auto generate fake responses for web-requests
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock

  c.ignore_hosts "127.0.0.1", "codeclimate.com"

  # Strip out authorization info
  c.filter_sensitive_data("Basic <API_KEY>") do |interaction|
    auth = interaction.request.headers["Authorization"]
    auth.presence&.first
  end

  c.filter_sensitive_data("<CLIENT_ID>") { ENV.fetch("ADDRESS_FACADE_CLIENT_ID", nil) }
  c.filter_sensitive_data("<CLIENT_KEY>") { ENV.fetch("ADDRESS_FACADE_CLIENT_KEY", nil) }
end
