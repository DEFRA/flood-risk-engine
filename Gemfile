source "https://rubygems.org"

# Declare your gem's dependencies in flood_risk_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

group :test do
  gem "capybara", "~> 2.6"
  gem "codeclimate-test-reporter", require: false
  gem "database_cleaner", "~> 1.5"
  gem "email_spec"
  gem "factory_girl_rails", "~> 4.6"
  gem "faker"
  gem "guard-rspec", require: false
  gem "poltergeist", "~> 1.9" # Needed for headless testing with Javascript or pages that ref external sites
  gem "rspec-html-matchers"
  gem "rspec-rails", "~> 3.4"
  gem "shoulda-matchers", "~> 3.1", require: false
  gem "simplecov", "~> 0.11", require: false
  gem "vcr", "~> 3.0"
  gem "webmock", "~> 1.24"
end
