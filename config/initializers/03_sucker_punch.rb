require_dependency "sucker_punch"
require "sucker_punch/async_syntax" # required for rails < 5

if defined?(Airbrake) && Rails.application.secrets.airbrake_host.present?
  SuckerPunch.exception_handler = -> (ex, _klass, _args) { Airbrake.notify(ex) }
end
