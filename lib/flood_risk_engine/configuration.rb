# frozen_string_literal: true

require "defra_ruby/alert"
require "defra_ruby/companies_house"

# Class for setting configuration options in this engine.
#
# To override default config values, for example in an initaliser, use e.g.:
#
#   FloodRiskEngine.configure do |config|
#    config.exemptions_expire_after_duration = 3.years - 1.day
#   end
#
# To access configuration settings use e.g.
#   FloodRiskEngine.config.exemptions_expire_after_duration
#
module FloodRiskEngine
  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end

  def self.start_airbrake
    DefraRuby::Alert.start
  end

  class Configuration
    # NOTE: plain accessors rather than ActiveSupport::Configurable, which is
    # deprecated in Rails 8.1 and removed in 8.2.
    attr_accessor :layout,
                  :default_assistance_mode,
                  :minimum_dredging_length_in_metres,
                  :maximum_dredging_length_in_metres,
                  :git_repository_url, # Optionally used in pages/version
                  :application_name, # Optionally used in pages/version
                  :notify_api_key,
                  :govuk_guidance_url
    attr_reader :companies_house_api_key, :companies_house_host

    def initialize
      @layout = "application"
      @minimum_dredging_length_in_metres = 1
      @maximum_dredging_length_in_metres = 1500
      @govuk_guidance_url = "https://www.gov.uk/government/publications/" \
                            "environmental-permitting-regulations-exempt-flood-risk-activities"

      configure_airbrake_rails_properties
      self.companies_house_host = "https://api.companieshouse.gov.uk"
    end

    def airbrake_enabled=(value)
      DefraRuby::Alert.configure do |configuration|
        configuration.enabled = change_string_to_boolean_for(value)
      end
    end

    def airbrake_host=(value)
      DefraRuby::Alert.configure do |configuration|
        configuration.host = value
      end
    end

    def airbrake_project_key=(value)
      DefraRuby::Alert.configure do |configuration|
        configuration.project_key = value
      end
    end

    def airbrake_blocklist=(value)
      DefraRuby::Alert.configure do |configuration|
        configuration.blocklist = value
      end
    end

    # Companies House configuration
    def companies_house_host=(value)
      @companies_house_host = value

      DefraRuby::CompaniesHouse.configure do |configuration|
        configuration.companies_house_host = value
      end
    end

    def companies_house_api_key=(value)
      @companies_house_api_key = value

      DefraRuby::CompaniesHouse.configure do |configuration|
        configuration.companies_house_api_key = value
      end
    end

    # Last Email caching and retrieval functionality
    def use_last_email_cache=(value)
      DefraRubyEmail.configure do |configuration|
        configuration.enable = change_string_to_boolean_for(value)
      end
    end

    private

    # If the setting's value is "true", then set to a boolean true. Otherwise, set it to false.
    def change_string_to_boolean_for(setting)
      setting = setting == "true" if setting.is_a?(String)
      setting
    end

    def configure_airbrake_rails_properties
      DefraRuby::Alert.configure do |configuration|
        configuration.root_directory = Rails.root
        configuration.logger = Rails.logger
        configuration.environment = ENV.fetch("AIRBRAKE_ENV_NAME", Rails.env)
      end
    end
  end
end
