# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe FloodRiskEngine::ApplicationHelper do
    describe "#title" do
      context "when a specific title is provided" do
        before do
          allow(helper).to receive(:content_for?).and_return(true)
          allow(helper).to receive(:content_for).with(:error_title).and_return(nil)
          allow(helper).to receive(:content_for).with(:title).and_return("Foo")
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

    describe "#displayable_address" do

      subject(:displayable_address) { helper.displayable_address(address) }
      context "with a blank address" do
        let(:address) do
          build(:address,
                organisation: nil,
                premises: nil,
                street_address: nil,
                locality: nil,
                city: nil,
                postcode: nil)
        end

        it "returns an empty result" do
          expect(displayable_address).to eq([])
        end
      end

      context "with a non-blank address" do
        let(:address) { build(:address) }

        it "returns the expected content" do
          expect(displayable_address).to eq([
                                              address.organisation,
                                              address.premises,
                                              address.street_address,
                                              address.locality,
                                              address.city,
                                              address.postcode
                                            ])
        end
      end
    end
  end
end
