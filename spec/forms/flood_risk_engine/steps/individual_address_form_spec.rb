require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"
require_relative "../../../support/asserts"

module FloodRiskEngine
  module Steps
    RSpec.describe IndividualAddressForm, type: :form do
      let(:params_key) { :individual_address }
      let(:enrollment) { FactoryGirl.create(:enrollment, :with_individual) }
      let(:model_class) { FloodRiskEngine::Address }
      let(:form) { described_class.factory(enrollment) }
      let(:post_code) { "BS1 5AH" }
      let(:uprn) { "340116" }
      let(:params) { { form.params_key => { post_code: post_code, uprn: uprn } } }

      subject { form }

      it_behaves_like "a form object"

      before do
        mock_ea_address_lookup_find_by_postcode
        mock_ea_address_lookup_find_by_uprn
      end

      it "is not redirectable" do
        expect(form.redirect?).to_not be_truthy
      end

      describe "#validate" do
        context "with valid params" do
          it "returns true" do
            expect(form.validate(params)).to eq(true)
          end
        end
      end

      describe "#save" do
        let(:address) { subject.enrollment.reload.organisation.primary_address }

        before do
          form.validate(params)
          expect(form.save).to eq true
        end

        it "saves a valid address on enrollment" do
          expected_attributes = {
            address_type: "primary",
            premises: "HORIZON HOUSE",
            street_address: "DEANERY ROAD",
            locality: "SOMEWHERE",
            city: "BRISTOL",
            postcode: post_code,
            uprn: uprn
          }

          assert_record_values address, expected_attributes
        end

        it "defines the address to organisation relationship correctly" do
          expect(address.addressable_id).to eq(subject.enrollment.organisation.id)
          expect(address.addressable_type).to eq("FloodRiskEngine::Organisation")
        end
      end

      describe "#address" do
        context "when address_search is present but has no postcode" do
          # This happens if an unrecognised postcode is used, and then
          # address is entered manually, and the user returns to page from
          # later in the journey
          before do
            enrollment.address_search = AddressSearch.new
            enrollment.save
            # ensure a primary address has been entered
            form.validate(params)
            expect(form.save).to eq true
          end

          it "should return the primary address postcode" do
            expect(form.postcode).to eq(post_code)
          end
        end
      end
    end
  end
end
