require "rails_helper"
module FloodRiskEngine
  module Steps

    describe PartnershipDetailForm, type: :form do
      let(:step) { :partnership_details }
      let(:address) { FactoryGirl.create(:address) }
      let(:contact) { FactoryGirl.create(:contact, address: address) }
      let(:enrollment) do
        FactoryGirl.create(:enrollment, :with_partnership, step: step)
      end
      let(:partner) do
        FactoryGirl.create(
          :partner,
          contact: contact,
          organisation: enrollment.organisation
        )
      end
      let(:model_class) { Enrollment }
      subject { described_class.factory(enrollment) }

      it { is_expected.to be_a(described_class) }

      it "returns true on save" do
        expect(subject.save).to be(true)
      end

      it "returns true on validate" do
        expect(subject.validate({})).to be(true)
      end

      describe ".new" do
        context "when incomplete partners exist" do
          let(:incomplete_contact) { FactoryGirl.create(:contact, address: nil) }
          before do
            partner
            FactoryGirl.create(
              :partner,
              contact: incomplete_contact,
              organisation: enrollment.organisation
            )
            expect(enrollment.partners.count).to eq(2)
          end

          it "should remove the incomplete partner" do
            expect { described_class.new(enrollment.reload) }.to change(Partner, :count).by(-1)
            expect(enrollment.reload.partners).to eq([partner])
          end
        end
      end

      describe "show_continue_button?" do
        it "should start as false" do
          expect(subject.show_continue_button?).to be_falsy
        end

        context "there are more than one partners" do
          let(:address2) { FactoryGirl.create(:address) }
          let(:contact2) { FactoryGirl.create(:contact, address: address2) }
          before do
            partner
            FactoryGirl.create(
              :partner,
              contact: contact2,
              organisation: enrollment.organisation
            )
            expect(enrollment.partners.count).to eq(2)
          end

          it "should be true" do
            expect(subject.show_continue_button?).to be(true)
          end
        end
      end
    end
  end
end
