# frozen_string_literal: true

require_dependency "sucker_punch"

if defined?(Airbrake) && Rails.application.credentials.airbrake_host.present?
  SuckerPunch.exception_handler = ->(ex, _klass, _args) { Airbrake.notify(ex) }
end
