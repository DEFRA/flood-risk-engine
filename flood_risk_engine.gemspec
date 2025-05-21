# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "flood_risk_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name                  = "flood_risk_engine"
  s.version               = FloodRiskEngine::VERSION
  s.authors               = ["Digital Services Team, EnvironmentAgency"]
  s.email                 = ["dst@environment-agency.gov.uk"]
  s.homepage              = "https://github.com/defra/flood-risk-engine"
  s.summary               = "FloodRiskEngine package containing core elements and functionality"
  s.description           = "FloodRiskEngine package containing core elements and functionality"
  s.license               = "The Open Government Licence (OGL) Version 3"
  s.required_ruby_version = ">= 3.2"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]
  # Use AASM to manage states and transitions
  s.add_dependency "aasm", "~> 5.5"
  s.add_dependency "activerecord-session_store", "~> 2"
  # Airbrake catches exceptions and sends them to our instances of Errbit
  # defra_ruby_alert is a gem we created to manage airbrake across projects
  s.add_dependency "defra_ruby_alert", "~> 2.1"
  # Manages data seeding
  s.add_dependency "dibber", "~> 0.5"
  # Env Vars drive some config. This loads environment variables from .env
  s.add_dependency "dotenv-rails", "~> 2"
  # Used for address lookups on OS Places
  s.add_dependency "defra_ruby_address"
  # Used to determine the EA area for a registered exemption
  s.add_dependency "defra_ruby_area", "~> 2.2"
  # Used as part of testing. When enabled adds a /email/last-email route from
  # which details of the last email sent by the app can be accessed
  s.add_dependency "defra_ruby_email", "~> 1"
  s.add_dependency "defra_ruby_validators"
  # Rails engine for static pages. https://github.com/thoughtbot/high_voltage
  s.add_dependency "high_voltage", "~> 3"
  s.add_dependency "jquery-rails", "~> 4"
  s.add_dependency "nokogiri", ">= 1"
  # Use Notify to send emails and letters
  s.add_dependency "notifications-ruby-client"
  s.add_dependency "os_map_ref", "0.5"
  # Add telephone number validation
  s.add_dependency "phonelib", "~> 0.6"
  s.add_dependency "rails", "~> 7.2.2.1"
  # ActiveJob background processing using another thread
  s.add_dependency "sucker_punch", "~> 3"
  # Validate e-mail addresses against RFC 2822 and RFC 3696
  s.add_dependency "validates_email_format_of", "~> 1"

  # for handling Water Managment Areas spatial data
  s.add_dependency "activerecord-postgis-adapter"
  s.add_dependency "rgeo"
  s.add_dependency "rgeo-activerecord", "~> 7"

  s.add_dependency "matrix", "~> 0.4"
  s.add_dependency "net-imap", "~> 0.2"
  s.add_dependency "net-pop", "~> 0.1"
  s.add_dependency "pg", "~> 1"

  s.metadata["rubygems_mfa_required"] = "true"
end
