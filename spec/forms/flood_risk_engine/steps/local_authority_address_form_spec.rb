require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"
require_relative "../../../support/asserts"

module FloodRiskEngine
  module Steps

    RSpec.describe LocalAuthorityAddressForm, type: :form do
      let(:params_key) { :local_authority_address }

      let(:enrollment) { create(:page_local_authority_address) }

      let(:model_class) { FloodRiskEngine::Address }

      let(:form) { LocalAuthorityAddressForm.factory(enrollment) }

      let(:valid_postcode) { "BS1 5AH" }

      subject { form }

      it_behaves_like "a form object"

      it { is_expected.to be_a(LocalAuthorityAddressForm) }

      it "is not redirectable" do
        expect(form.redirect?).to_not be_truthy
      end

      context "with valid params" do
        def form_requires_address_no_street_lookup
          VCR.use_cassette("address_lookup_no_matches_postcode") do
            yield
          end
        end

        def form_requires_address_lookup
          VCR.use_cassette("address_lookup_valid_postcode") do
            yield
          end
        end

        let(:valid_attributes) {
          {
            "#{form.params_key}": { postcode: valid_postcode, uprn: "340116" }
          }
        }

        it "is valid when valid UK UPRN supplied via drop down rendering process_address" do
          form_requires_address_lookup do
            expect(form.validate(valid_attributes)).to eq true
          end
        end

        let(:valid_but_no_street_address) {
          {
            "#{form.params_key}": { postcode: "HX3 0TD", uprn: "10010175140" }
          }
        }

        it "is valid when valid UK UPRN supplied via drop down but no street_address present" do
          form_requires_address_no_street_lookup do
            expect(form.validate(valid_but_no_street_address)).to eq true
          end
        end

        describe "Save" do
          it "saves a valid address on enrollment" do
            form_requires_address_lookup do
              form.validate(valid_attributes)
              expect(form.save).to eq true
            end

            expect(subject.model.postcode).to eq(valid_attributes[:postcode])

            address = subject.enrollment.reload.organisation.primary_address

            expected_attributes = {
              address_type: "primary",
              premises: "HORIZON HOUSE",
              street_address: "DEANERY ROAD",
              locality: nil,
              city: "BRISTOL",
              postcode: valid_attributes[params_key][:postcode],
              uprn: valid_attributes[params_key][:uprn]
            }

            assert_record_values address, expected_attributes

            expect(address.addressable_id).to eq subject.enrollment.organisation.id
            expect(address.addressable_type).to eq "FloodRiskEngine::Organisation"
          end
        end
      end
    end
  end
end
