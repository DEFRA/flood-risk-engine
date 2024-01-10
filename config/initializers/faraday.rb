# frozen_string_literal: true

# Currently used only by github_changelog_generator > octokit
Faraday.new do |config|
  config.request :retry, { methods: %i[get] }
end
