source "https://rubygems.org"

# Declare your gem's dependencies in flood_risk_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem "rails", "6.1.5"

group :development, :test do
  gem "defra_ruby_style"
  # ActiveRecord N+1 detection
  gem "bullet"
  # Call "byebug" anywhere in the code to stop execution and get a debugger
  # console
  gem "byebug", "~> 11" # 11.1 only supports Ruby 2.4 and up
end

group :test do
  gem "capybara", "~> 3"
  gem "database_cleaner", "~> 2"
  gem "factory_bot_rails", "~> 6"
  gem "faker", "~> 2"
  gem "govuk_design_system_formbuilder"
  gem "poltergeist", "~> 1" # Needed for headless testing with Javascript or pages that ref external sites
  gem "rails-controller-testing"
  gem "rspec-html-matchers"
  gem "rspec-rails", "~> 5"
  gem "shoulda-matchers", "~> 4.5", require: false
  gem "simplecov", "~> 0.16.0", require: false
  gem "vcr", "~> 6"
  gem "webmock", "~> 3"
end
