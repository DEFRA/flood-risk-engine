# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe PartnerPresenter do
    let(:address) do
      create(
        :address,
        premises: "a",
        street_address: "b",
        locality: "c",
        city: "d",
        postcode: "e"
      )
    end
    let(:contact) { create(:contact, address:) }
    let(:organisation) { create(:organisation, :as_partnership) }
    let(:partner) do
      create(:partner, contact:, organisation:)
    end

    subject(:presenter) { described_class.new(partner) }

    describe "#to_single_line" do
      it "returns name and address in single comma delimited line" do
        expect(presenter.to_single_line).to eq("#{contact.full_name}, a, b, c, d, e")
      end
    end
  end
end
