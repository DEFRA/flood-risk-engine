# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe TransientAddress, type: :model do
    subject(:transient_address) { described_class.new(addressable: addressable, address_type: 1) }

    context "when addressable is a TransientRegistration" do
      let(:addressable) { TransientRegistration.new }

      it "is valid" do
        expect {
          subject.save!
        }.to_not raise_error
      end

      it "returns the registration" do
        expect(subject.addressable).to eq(addressable)
      end

      it "can be found on the registration" do
        subject.save!

        expect(addressable.company_address).to eq(subject)
      end
    end

    context "when addressable is a Person" do
      let(:addressable) { TransientPerson.new }

      it "is valid" do
        expect {
          subject.save!
        }.to_not raise_error
      end

      it "returns the Person" do
        expect(subject.addressable).to eq(addressable)
      end

      it "can be found on the Person" do
        subject.save!

        expect(addressable.transient_address).to eq(subject)
      end
    end
  end
end
