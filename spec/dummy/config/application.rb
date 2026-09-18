# frozen_string_literal: true

# Load environment variables from the project root to save having to add a .env file
# to dummy in order to run it with rails console.

require File.expand_path("boot", __dir__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

# Need to require these gems in order for the dummy app to resolve
# the js and css in e.g. assets/stylesheets/application.scss
require "jquery-rails"
require "bootstrap-sass"

Bundler.require(*Rails.groups)

# `dotenv-rails` needs to be defined here to load `.env` in the test environment.
require "dotenv-rails"

require "flood_risk_engine"

Dotenv::Railtie.load

module Dummy
  class Application < Rails::Application
    config.load_defaults 8.1

    # Keep has_secure_token generating on create (the pre-7.1 default). The
    # engine relies on unsaved registrations having no token yet.
    config.active_record.generate_secure_token_on = :create
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

  end
end
