require "rails_helper"

module FloodRiskEngine
  RSpec.describe PartnerPresenter do
    let(:address) do
      FactoryBot.create(
        :address,
        premises: "a",
        street_address: "b",
        locality: "c",
        city: "d",
        postcode: "e"
      )
    end
    let(:contact) { FactoryBot.create(:contact, address:) }
    let(:organisation) { FactoryBot.create(:organisation, :as_partnership) }
    let(:partner) do
      FactoryBot.create(:partner, contact:, organisation:)
    end
    subject { PartnerPresenter.new(partner) }

    describe "#to_single_line" do
      it "should return name and address in single comma delimited line" do
        expect(subject.to_single_line).to eq("#{contact.full_name}, a, b, c, d, e")
      end
    end
  end
end
