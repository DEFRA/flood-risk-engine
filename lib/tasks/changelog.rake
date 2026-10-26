# frozen_string_literal: true

require "github_changelog_generator/task"

# github_changelog_generator makes an API request per merged PR just to find its
# merge commit, which hits GitHub's rate limits. These changes override the gem
# methods to take advantage of the fact that the merge commit is already in
# the pull requests list it fetches, so use that instead. See the gem's own note:
# https://github.com/github-changelog-generator/github-changelog-generator/blob/5a0cbdb6860ffc449e838541faf3f24e10d75722/lib/github_changelog_generator/generator/generator_fetcher.rb#L69
#
# The back and front office apps load this file too.
module ChangelogRateLimitFix
  # Remember each PR's merge commit from the list the gem already fetches
  def fetch_closed_pull_requests
    super.tap do |pull_requests|
      @merge_commit_shas = pull_requests.to_h { |pr| [pr["number"], pr["merge_commit_sha"]] }
    end
  end

  # Instead of fetching every PR's events, give each PR just the "merged" event
  # the gem reads. Assumes no plain GitHub issues, which our repos don't use.
  def fetch_events_async(issues)
    issues.each do |issue|
      issue["events"] = [{ "event" => "merged", "commit_id" => @merge_commit_shas[issue["number"]] }]
    end
  end
end

GitHubChangelogGenerator::OctoFetcher.prepend(ChangelogRateLimitFix)

GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = "defra"
  config.project = "flood-risk-engine"
end
