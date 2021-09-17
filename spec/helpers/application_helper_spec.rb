# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe FloodRiskEngine::ApplicationHelper, type: :helper do
    describe "title" do
      context "when a specific title is provided" do
        before do
          allow(helper).to receive(:content_for?).and_return(true)
          allow(helper).to receive(:content_for).and_return("Foo")
        end

        it "returns the correct full title" do
          expect(helper.title).to eq("Foo - Register a flood risk activity exemption - GOV.UK")
        end
      end

      context "when no specific title is provided" do
        it "returns the correct full title" do
          expect(helper.title).to eq("Register a flood risk activity exemption - GOV.UK")
        end
      end
    end
  end
end
