# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe AddressPresenter, type: :presenter do
    subject(:presenter) { described_class.new(address) }

    describe "to_single_line" do
      context "when all address parts are present" do
        let(:address) do
          Address.new(premises: "a",
                      street_address: "b",
                      locality: "c",
                      city: "d",
                      postcode: "e")
        end

        it "returns the address as a comma delimited string" do
          expect(presenter.to_single_line).to eq("a, b, c, d, e")
        end
      end
    end
  end
end
