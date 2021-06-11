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
    auth.first unless auth.nil? || auth.empty?
  end

  c.filter_sensitive_data("<CLIENT_ID>") { ENV["ADDRESS_FACADE_CLIENT_ID"] }
  c.filter_sensitive_data("<CLIENT_KEY>") { ENV["ADDRESS_FACADE_CLIENT_KEY"] }
end
