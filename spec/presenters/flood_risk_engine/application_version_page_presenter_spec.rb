# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe ApplicationVersionPagePresenter, type: :presenter do
    before do
      FloodRiskEngine.configure do |config|
        config.application_name = nil
        config.git_repository_url = nil
      end
    end

    subject(:presenter) { described_class.new }
    it { is_expected.to respond_to(:git_commit_url) }

    describe "#application_name" do
      it "uses the FloodRiskEngine.config setting if available" do
        FloodRiskEngine.configure do |config|
          config.application_name = "Yay"
        end
        expect(presenter.application_name).to eq(FloodRiskEngine.config.application_name)
      end

      it "defaults to Rails.application.class.module_parent_name" do
        expect(presenter.application_name).to eq("Dummy")
      end
    end

    describe "#git_commit" do
      it "returns nil when run in the test environment" do
        expect(presenter.git_commit).to be_nil
      end
    end

    describe "#git_repository_url" do
      it "uses FloodRiskEngine.config setting if present" do
        dummy_url = "http://example.com"
        FloodRiskEngine.configure do |config|
          config.git_repository_url = dummy_url
        end
        expect(presenter.git_repository_url).to eq("http://example.com")
      end

      it "defaults to a deduced github repo url" do
        expect(presenter.git_repository_url).to eq("https://github.com/defra/dummy")
      end
    end

    describe "git_commit_url" do
      it "returns the git url for the current commit sha" do
        dummy_repo_url = "http://123"
        dummy_commit_sha = "xyz"
        expect(presenter).to receive(:git_repository_url).and_return(dummy_repo_url)
        expect(presenter).to receive(:git_commit).and_return(dummy_commit_sha)
        expected_git_commit_url = File.join(dummy_repo_url, "commit", dummy_commit_sha)
        expect(presenter.git_commit_url).to eq(expected_git_commit_url)
      end
    end
  end
end
