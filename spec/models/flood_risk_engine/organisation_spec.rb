# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe Organisation do
    let(:organisation) { create(:organisation) }

    it { is_expected.to belong_to(:contact) }
    it { is_expected.to have_one(:enrollment).dependent(:restrict_with_exception) }
    it { is_expected.to have_one(:primary_address).dependent(:restrict_with_exception) }
    it { is_expected.to have_many(:partners) }

    describe "#contact_search_string" do
      context "when it isn't a partnership" do
        let(:organisation) { create(:organisation) }

        context "when it has no contact" do
          it { expect(organisation.send(:contact_search_string)).to eq("") }
        end

        context "when it has a contact" do
          it "returns a string containing the contact name" do
            organisation.contact = create(:contact)
            expect(organisation.send(:contact_search_string)).to eq(organisation.contact.full_name)
          end
        end
      end

      context "when it is a partnership" do
        let(:organisation) { create(:organisation, org_type: :partnership) }

        it "returns a string containing the partners names" do
          partner1 = create(:partner_with_contact)
          partner2 = create(:partner_with_contact)
          organisation.partners << [partner1, partner2]
          expect(organisation.send(:contact_search_string)).to eq("#{partner1.full_name} #{partner2.full_name}")
        end

        it "returns an empty string when there's no partners" do
          expect(organisation.send(:contact_search_string)).to eq("")
        end
      end
    end
  end
end
