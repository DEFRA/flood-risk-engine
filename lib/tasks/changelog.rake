# frozen_string_literal: true

require "github_changelog_generator/task"

GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = "defra"
  config.project = "flood-risk-engine"
end
