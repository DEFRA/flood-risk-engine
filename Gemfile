source "https://rubygems.org"

# Declare your gem's dependencies in flood_risk_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

group :test do
  gem "rspec-rails", "~> 3.4"
  gem "factory_girl_rails", "~> 4.6"
  gem "simplecov", "~> 0.11", require: false
  gem "faker"
  gem "shoulda-matchers", "~> 3.1", require: false
  gem "poltergeist", "~> 1.9" # Needed for headless testing with Javascript or pages that ref external sites
  gem "capybara", "~> 2.6"
  gem 'guard-rspec', require: false
  gem 'rspec-html-matchers'
  gem "database_cleaner", "~> 1.5"
end
