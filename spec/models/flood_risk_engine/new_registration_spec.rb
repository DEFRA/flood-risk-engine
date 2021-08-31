# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe NewRegistration, type: :model do
    subject(:new_registration) { create(:new_registration) }

    it_behaves_like "a transient_registration", :new_registration

    it "subclasses TransientRegistration" do
      expect(described_class).to be < TransientRegistration
    end

    context "when it has a company address" do
      let(:address) { TransientAddress.new(address_type: 1) }

      it "can retrieve it" do
        expect {
          subject.company_address = address
          subject.save!
        }.to change { subject.company_address }.from(nil).to(address)
      end
    end
  end
end
