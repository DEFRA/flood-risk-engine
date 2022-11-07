# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe TransientAddress do
    subject(:transient_address) { described_class.new(addressable:, address_type: 1) }

    context "when addressable is a TransientRegistration" do
      let(:addressable) { TransientRegistration.new }

      it "is valid" do
        expect do
          transient_address.save!
        end.not_to raise_error
      end

      it "returns the registration" do
        expect(transient_address.addressable).to eq(addressable)
      end

      it "can be found on the registration" do
        transient_address.save!

        expect(addressable.company_address).to eq(transient_address)
      end
    end

    context "when addressable is a Person" do
      let(:addressable) { TransientPerson.new }

      it "is valid" do
        expect do
          transient_address.save!
        end.not_to raise_error
      end

      it "returns the Person" do
        expect(transient_address.addressable).to eq(addressable)
      end

      it "can be found on the Person" do
        transient_address.save!

        expect(addressable.transient_address).to eq(transient_address)
      end
    end
  end
end
