# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe ExemptionForm, type: :model do
    describe "#submit" do
      context "when the form is valid" do
        let(:exemption) { create(:exemption) }
        let(:exemption_form) { build(:exemption_form, :has_required_data) }
        let(:valid_params) do
          { token: exemption_form.token, exemption_ids: [exemption.id] }
        end

        it "submits" do
          expect(exemption_form.submit(valid_params)).to be(true)
        end

        it "updates the transient registration with the selected exemption" do
          transient_registration = exemption_form.transient_registration
          expect(transient_registration.exemptions).to be_empty

          exemption_form.submit(valid_params)

          expect(transient_registration.exemptions.first.code).to eq(exemption.code)
        end
      end

      context "when the form is not valid" do
        let(:exemption_form) { build(:exemption_form, :has_required_data) }
        let(:invalid_params) { { exemption_ids: [] } }

        it "does not submit" do
          expect(exemption_form.submit(invalid_params)).to be(false)
        end
      end
    end

    it_behaves_like "validate exemptions", :exemption_form
  end
end
