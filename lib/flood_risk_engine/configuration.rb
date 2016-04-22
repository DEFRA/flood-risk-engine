# Class for setting configuration options in this engine. See e.g.
# http://stackoverflow.com/questions/24104246/how-to-use-activesupportconfigurable-with-rails-engine
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
  class Configuration
    include ActiveSupport::Configurable

    # Define accessors here, e.g.
    # config_accessor(:some_key)
    # or with an optional default
    # config_accessor(:some_key) { "a default value" }
    config_accessor(:redirection_url_on_location_unchecked)
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end
end
