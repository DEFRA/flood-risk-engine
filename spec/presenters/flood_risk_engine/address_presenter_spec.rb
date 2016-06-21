require "rails_helper"

module FloodRiskEngine
  RSpec.describe AddressPresenter, type: :presenter do
    let(:subject) { AddressPresenter.new(address) }

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
          expect(subject.to_single_line).to eq("a, b, c, d, e")
        end
      end
    end
  end
end
