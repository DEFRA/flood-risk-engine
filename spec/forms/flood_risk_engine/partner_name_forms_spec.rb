# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe PartnerNameForm, type: :model do

    describe "#submit" do
      context "when the form is valid" do
        let(:partner_name_form) { build(:partner_name_form, :has_required_data) }
        let(:valid_params) do
          {
            token: partner_name_form.token,
            full_name: "Aaron A Aaronson"
          }
        end
        let(:transient_registration) { partner_name_form.transient_registration }

        it "should submit" do
          expect(partner_name_form.submit(valid_params)).to eq(true)
        end

        it "saves a new partner" do
          partner_name_form.submit(valid_params)

          first_partner = transient_registration.reload.transient_people.first

          expect(first_partner).to be_a(TransientPerson)
          expect(first_partner.full_name).to eq(valid_params[:full_name])
        end
      end

      context "when the form is not valid" do
        let(:partner_name_form) { build(:partner_name_form, :has_required_data) }
        let(:invalid_params) { { token: "foo" } }

        it "should not submit" do
          expect(partner_name_form.submit(invalid_params)).to eq(false)
        end
      end
    end
  end
end
