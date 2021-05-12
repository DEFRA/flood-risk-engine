source "https://rubygems.org"

# Declare your gem's dependencies in flood_risk_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# The "sync" gem has been removed from ruby 2.17 https://bugs.ruby-lang.org/issues/16170
# Unfortunately, it is used by finite_machine, so we ensure it is here
gem "sync"

group :development, :test do
  # ActiveRecord N+1 detection
  gem "bullet"
  # Call "byebug" anywhere in the code to stop execution and get a debugger
  # console
  gem "byebug", "~> 11.0.1" # 11.1 only supports Ruby 2.4 and up
end

group :test do
  gem "capybara", "~> 2.6"
  gem "database_cleaner", "~> 1.5"
  gem "email_spec"
  gem "factory_bot_rails", "~> 6.1"
  gem "faker", "~> 1.7"
  gem "guard-rspec", require: false
  gem "poltergeist", "~> 1.9" # Needed for headless testing with Javascript or pages that ref external sites
  gem "rspec-html-matchers"
  gem "rspec-rails", "~> 3.4"
  gem "shoulda-matchers", "~> 3.1", require: false
  gem "simplecov", "~> 0.13.0", require: false
  gem "vcr", "~> 3.0"
  gem "webmock", "~> 1.24"
end
