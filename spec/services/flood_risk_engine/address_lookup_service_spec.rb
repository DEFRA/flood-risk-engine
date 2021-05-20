# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe AddressLookupService, type: :service do
    describe ".run" do
      it "does send a request to os places using the defra ruby gem" do
        postcode = "BS1 5AH"

        expect(DefraRuby::Address::EaAddressFacadeV11Service).to receive(:run).with(postcode)

        described_class.run(postcode)
      end
    end
  end
end
