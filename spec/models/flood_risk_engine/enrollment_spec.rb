# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe Enrollment do
    let(:enrollment) { create(:enrollment) }

    it { is_expected.to belong_to(:applicant_contact) }
    it { is_expected.to belong_to(:organisation) }
    it { is_expected.to have_one(:exemption_location).dependent(:restrict_with_exception) }

    describe "#reference_number" do
      before do
        enrollment.reference_number = ReferenceNumber.create
      end

      it "is of the right format" do
        expect(enrollment.reference_number).to match(/EXFRA\d{6}/)
      end
    end

    describe "#submitted?" do
      it "returns false" do
        expect(enrollment.submitted?).to be(false)
      end

      context "when there is a submitted_at" do
        before { enrollment.submitted_at = Time.current }

        it "returns true" do
          expect(enrollment.submitted?).to be(true)
        end
      end
    end
  end
end
