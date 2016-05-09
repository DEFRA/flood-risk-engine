$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "flood_risk_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "flood_risk_engine"
  s.version     = FloodRiskEngine::VERSION
  s.authors     = ["Digital Services Team, EnvironmentAgency"]
  s.email       = ["dst@environment-agency.gov.uk"]
  s.homepage    = "https://github.com/EnvironmentAgency/flood-risk-engine"
  s.summary     = "FloodRiskEngine package containing core elements and functionality"
  s.description = "FloodRiskEngine package containing core elements and functionality"
  s.license     = "The Open Government Licence (OGL) Version 3"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2"
  s.add_dependency "reform", "~> 2.1"
  s.add_dependency "reform-rails", "~> 0.1"
  s.add_dependency "dotenv-rails", "~> 2.1"
  s.add_dependency "finite_machine", "~> 0.10"
  s.add_dependency "dibber", "~> 0.5" # Manages data seeding
  s.add_dependency "jquery-rails", "~> 4.1"
  s.add_dependency "validates_email_format_of", "~> 1.6" # Validate e-mail addresses against RFC 2822 and RFC 3696
  s.add_dependency "phonelib", "~> 0.6" # Add telephone number validation

  s.add_development_dependency "pg", "~> 0.18"
  s.add_development_dependency "before_commit", "~> 0.6"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "bootstrap-sass", "~> 3.3"
  s.add_development_dependency "sass-rails", ">= 3.2"
  s.add_development_dependency "quiet_assets", "~> 1.1"
  s.add_development_dependency "byebug", "~> 8.2"
end
