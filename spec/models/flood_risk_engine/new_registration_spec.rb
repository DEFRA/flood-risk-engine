# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration do
    subject(:new_registration) { create(:new_registration) }

    it_behaves_like "a transient_registration", :new_registration

    it "subclasses TransientRegistration" do
      expect(described_class).to be < TransientRegistration
    end

    context "when it has a company address" do
      let(:address) { TransientAddress.new(address_type: 1) }

      it "can retrieve it" do
        expect do
          new_registration.company_address = address
          new_registration.save!
        end.to change(new_registration, :company_address).from(nil).to(address)
      end
    end
  end
end
