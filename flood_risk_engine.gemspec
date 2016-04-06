$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "flood_risk_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "flood_risk_engine"
  s.version     = FloodRiskEngine::VERSION
  s.authors     = ["Rob Nichols"]
  s.email       = ["robnichols.ea@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of FloodRiskEngine."
  s.description = "TODO: Description of FloodRiskEngine."
  s.license     = "LICENSE"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "before_commit"
end
