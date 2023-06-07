# frozen_string_literal: true

source "https://rubygems.org"

# Declare your gem's dependencies in flood_risk_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem "rails", "~> 7.0"

group :development, :test do
  # Pretty prints objects in console. Usage `$ ap some_object`
  gem "awesome_print"
  gem "bootstrap-sass", "~> 3"
  # ActiveRecord N+1 detection
  gem "bullet"
  # Call "byebug" anywhere in the code to stop execution and get a debugger
  # console
  gem "byebug", "~> 11" # 11.1 only supports Ruby 2.4 and up
  gem "defra_ruby_style"
  # Allows us to automatically generate the change log from the tags, issues,
  # labels and pull requests on GitHub. Added as a dependency so all dev's have
  # access to it to generate a log, and so they are using the same version.
  # New dev's should first create GitHub personal app token and add it to their
  # ~/.bash_profile (or equivalent)
  # https://github.com/skywinder/github-changelog-generator#github-token
  gem "github_changelog_generator"
  # Used to ensure the code base matches our agreed styles and conventions
  gem "rubocop"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  gem "sass-rails", "~> 5"
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
  gem "simplecov", "~> 0.17.1", require: false
  gem "vcr", "~> 6"
  gem "webmock", "~> 3"
end
