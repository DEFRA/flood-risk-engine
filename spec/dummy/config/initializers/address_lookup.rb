EA::AddressLookup.configure do |config|
  config.address_facade_server  = ENV["ADDRESS_FACADE_TEST_SERVER"]
  config.address_facade_port    = ENV["ADDRESS_FACADE_TEST_PORT"]
  config.address_facade_url     = "/address-service/v1/addresses/postcode"
  config.timeout_in_seconds     = 10

  config.address_facade_client_id =  ENV["ADDRESS_FACADE_CLIENT_ID"]
  config.address_facade_key       =  ENV["ADDRESS_FACADE_KEY"]
end
