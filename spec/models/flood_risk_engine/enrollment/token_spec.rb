# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe Enrollment do
    it { is_expected.to respond_to(:token) }
    it { is_expected.to have_db_index(:token).unique(true) }

    subject(:enrollment) { described_class.new }

    context "when the enrollment is new" do
      it "has a nil token" do
        expect(enrollment.token).to be_nil
      end
    end

    context "when the enrollment has been created" do
      it "has a unique base58 token 24 characters in length" do
        enrollment.save!
        expect(enrollment.token).not_to be_nil
        expect(enrollment.token).to be_a(String)
        expect(enrollment.token.length).to eq(24)
      end
    end

    context "when the enrollment has been saved again" do
      it "the token is not recreated" do
        enrollment.save!
        expect { enrollment.save! }.not_to change(enrollment, :token)
      end
    end

    describe "to_param" do
      it "returns the token, not the id as a normal AR object would" do
        expect(enrollment.to_param).to eq(enrollment.token)
      end
    end
  end
end
