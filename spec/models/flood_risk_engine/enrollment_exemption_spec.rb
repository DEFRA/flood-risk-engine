require "rails_helper"

module FloodRiskEngine
  RSpec.describe EnrollmentExemption, type: :model do
    let(:enrollment_exemption) { FactoryBot.create(:enrollment_exemption) }
    let(:status) { enrollment_exemption.status }

    it { is_expected.to be_valid }
    it { is_expected.to respond_to(:expires_at) }
    it { is_expected.to respond_to(:valid_from) }
    it { is_expected.to have_many(:comments) }

    context "Factories" do
      it "has a valid factory" do
        expect(build(:enrollment_exemption)).to be_valid
      end
    end

    context "scopes" do
      context ".approved" do
        it "returns all approved enrollment exemptions" do
          active_exemption = FactoryBot.create(:enrollment_exemption, status: :approved)
          not_active_exemption = FactoryBot.create(:enrollment_exemption, status: :building)

          expect(described_class.approved).to eq([active_exemption])
        end
      end
    end

    describe "comments" do
      let(:ee) { FactoryBot.create(:enrollment_exemption) }

      it "returns nil  when no comments" do
        expect(ee.decision_at_and_user).to eq [nil, nil]
        expect(ee.decision_at).to eq nil
        expect(ee.decision_user_id).to eq nil
      end

      it "returns latest decision_at and user id" do
        comments = build_list(:comment, 6, :with_user_id)
        ee.comments << comments
        sorted = comments.sort_by(&:created_at)

        expect(ee.latest_decision.first.to_date).to eq sorted.last.created_at.to_date
        expect(ee.latest_decision.last).to eq sorted.last.user_id
      end
    end

    describe ".include_long_dredging?" do
      before(:each) { FactoryBot.create(:enrollment_exemption) }
      it "returns true if the collection includes a long dredging exemption" do
        dredging_code = FloodRiskEngine::Exemption::LONG_DREDGING_CODES.sample
        dredging_exemption = create(:exemption, code: dredging_code)
        FactoryBot.create(:enrollment_exemption, exemption: dredging_exemption)
        expect(described_class.include_long_dredging?).to be_truthy
      end
      it "returns false if the collection does not include a long dredging exemption" do
        expect(described_class.include_long_dredging?).to be_falsey
      end
    end

    describe "#status_one_of?" do
      it "should return true if state is passed in" do
        expect(enrollment_exemption.status_one_of?(status)).to eq(true)
      end

      it "should return true if state is passed in as one of many" do
        expect(enrollment_exemption.status_one_of?(status, :foo, :bar)).to eq(true)
      end

      it "should return false if state is not passed in" do
        expect(enrollment_exemption.status_one_of?(:foo, :bar)).to eq(false)
      end
    end
  end
end
