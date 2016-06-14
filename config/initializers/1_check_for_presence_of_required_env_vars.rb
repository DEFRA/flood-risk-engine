# Check up-front that neccessary ENV vars are present. This prevents delayed
# errors, for example email failing on first execution because of missing configuration.
# You can add these variables in development or CI using your .env file.
%w(
  SECRET_KEY_BASE
  ADDRESS_FACADE_SERVER
  ADDRESS_FACADE_PORT
  ADDRESS_FACADE_CLIENT_ID
  ADDRESS_FACADE_KEY
  DEVISE_MAILER_SENDER
  EMAIL_HOST
  EMAIL_PORT
).each do |key|
  ENV.fetch(key) { raise "#{key} not found in ENV" }
end

# Ensure presence of any essential production ENV vars
if Rails.env.production?
  %w(
    AIRBRAKE_HOST
    AIRBRAKE_PROJECT_KEY
  ).each do |key|
    ENV.fetch(key) { raise "#{key} not found in ENV" }
  end
end
