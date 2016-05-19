require "rails_helper"

module FloodRiskEngine
  RSpec.describe AddressPresenter, type: :presenter do
    let(:subject) { AddressPresenter.new(address) }

    describe "to_s" do
      context "when all address parts are present" do
        let(:address) {
          Address.new(premises: "a",
                      street_address: "b",
                      locality: "c",
                      city: "d",
                      postcode: "e")
        }
        it "returns the address as a comma delimited string" do
          expect(subject.to_s).to eq("a,b,c,d,e")
        end
      end
    end
  end
end
