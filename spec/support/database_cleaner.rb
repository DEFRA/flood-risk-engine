# frozen_string_literal: true

# Require this to support automatically cleaning the database when testing
require "database_cleaner"

RSpec.configure do |config|
  # Clean the database before running tests. Setup as per
  # https://github.com/DatabaseCleaner/database_cleaner#rspec-example
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
