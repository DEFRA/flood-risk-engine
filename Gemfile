# frozen_string_literal: true

source "https://rubygems.org"

# Declare your gem's dependencies in flood_risk_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# As of Rails 7.1, adding the gemm as a dependency in the gemspec does not add
# the gem to the DEPENDENCIES section of Gemfile.lock, and this prevents the
# gem's locale definitions from loading in the app. Adding it here resolves that.
gem "defra_ruby_validators"

group :development, :test do
  # Pretty prints objects in console. Usage `$ ap some_object`
  gem "awesome_print"
  gem "bootstrap-sass", "~> 3"
  # ActiveRecord N+1 detection
  gem "bullet"
  # Call "byebug" anywhere in the code to stop execution and get a debugger
  # console
  gem "byebug"
  gem "defra_ruby_style"
  gem "faraday-retry"
  # Allows us to automatically generate the change log from the tags, issues,
  # labels and pull requests on GitHub. Added as a dependency so all dev's have
  # access to it to generate a log, and so they are using the same version.
  # New dev's should first create GitHub personal app token and add it to their
  # ~/.bash_profile (or equivalent)
  # https://github.com/skywinder/github-changelog-generator#github-token
  gem "github_changelog_generator"
  # Used to ensure the code base matches our agreed styles and conventions
  gem "rubocop"
  gem "rubocop-capybara"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  gem "rubocop-rspec_rails"
  gem "sass-rails", "~> 5"
end

group :test do
  gem "capybara", "~> 3"
  gem "factory_bot_rails", "~> 6"
  gem "faker", "~> 2"
  gem "poltergeist", "~> 1" # Needed for headless testing with Javascript or pages that ref external sites
  gem "rails-controller-testing"
  gem "rgeo-geojson"
  gem "rspec-html-matchers"
  gem "rspec-rails", "~> 6"
  gem "shoulda-matchers", "~> 6", require: false
  gem "simplecov", "~> 0.17.1", require: false
  gem "vcr", "~> 6"
  gem "webmock", "~> 3"
end
