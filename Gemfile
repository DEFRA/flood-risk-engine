source "https://rubygems.org"

# Declare your gem's dependencies in flood_risk_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

group :test do
  gem "rspec-rails", "~> 3.4"
  gem "factory_girl_rails", "~> 4.6"
  gem "simplecov", "~> 0.11", require: false
  gem "faker"
  gem "shoulda-matchers", "~> 3.1", require: false
  gem "poltergeist", "~> 1.9" # Needed for headless testing with Javascript or pages that ref external sites
  gem "capybara", "~> 2.6"
  gem 'rspec-html-matchers'
end
