require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"
require_relative "../../../support/asserts"

module FloodRiskEngine
  module Steps

    RSpec.describe Steps::LocalAuthorityAddressForm, type: :form do
      let(:params_key)      { :local_authority_address }
      let(:enrollment)      { create(:page_local_authority_address) }
      let(:model_class)     { FloodRiskEngine::Address }
      let(:valid_post_code) { "BS1 5AH" }
      let(:form)            { LocalAuthorityAddressForm.factory(enrollment) }
      subject               { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(LocalAuthorityAddressForm) }

      it "is not redirectable" do
        expect(form.redirect?).to_not be_truthy
      end

      context "with valid params" do
        let(:valid_attributes) {
          {
            "#{form.params_key}": { post_code: valid_post_code, uprn: "340116" }
          }
        }

        it "is valid when valid UK UPRN supplied via drop down rendering process_address" do
          mock_ea_address_lookup_find_by_uprn
          expect(form.validate(valid_attributes)).to eq true
        end

        let(:valid_but_no_street_address) {
          {
            "#{form.params_key}": { post_code: "HX3 0TD", uprn: "10010175140" }
          }
        }

        it "is valid when valid UK UPRN supplied via drop down but no street_address present" do
          mock_ea_address_lookup_find_by_uprn
          expect(form.validate(valid_but_no_street_address)).to eq true
        end

        describe "Save" do
          it "saves a valid address on enrollment" do
            mock_ea_address_lookup_find_by_uprn
            form.validate(valid_attributes)
            expect(form.save).to eq true

            expect(form.model.postcode).to eq(valid_attributes[:post_code])

            address = form.enrollment.reload.organisation.primary_address

            expected_attributes = {
              address_type: "primary",
              premises: "HORIZON HOUSE",
              street_address: "DEANERY ROAD",
              locality: "",
              city: "BRISTOL",
              postcode: valid_attributes[params_key][:post_code],
              uprn: valid_attributes[params_key][:uprn]
            }

            assert_record_values address, expected_attributes

            expect(address.addressable_id).to eq form.enrollment.organisation.id
            expect(address.addressable_type).to eq "FloodRiskEngine::Organisation"
          end
        end
      end
    end
  end
end
