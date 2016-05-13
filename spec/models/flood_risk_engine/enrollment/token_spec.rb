require "rails_helper"

module FloodRiskEngine
  RSpec.describe Enrollment, type: :model do
    it { is_expected.to respond_to(:token) }
    it { is_expected.to have_db_index(:token).unique(true) }

    context "when the enrollment is new" do
      it "has a nil token" do
        expect(subject.token).to be_nil
      end
    end
    context "after the enrollment is created" do
      it "has a unique base58 token 24 characters in length" do
        subject.save!
        expect(subject.token).to_not be_nil
        expect(subject.token).to be_a(String)
        expect(subject.token.length).to eq(24)
      end
    end
    context "after the enrollment is saved again" do
      it "the token is not recreated" do
        subject.save!
        expect { subject.save! }.to_not change(subject, :token)
      end
    end

    describe "to_param" do
      it "returns the token, not the id as a normal AR object would" do
        expect(subject.to_param).to eq(subject.token)
      end
    end
  end
end
