require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  RSpec.describe Steps::AddExemptionsForm, type: :form do
    let(:params_key) { :add_exemptions }
    let(:enrollment) { FactoryBot.create(:enrollment) }
    let(:model_class) { Enrollment }
    let(:exemption) { FactoryBot.create(:exemption) }
    let(:params) { { params_key => { exemption_ids: exemption.id } } }

    subject { described_class.factory(enrollment) }

    it_behaves_like "a form object"

    it { is_expected.to be_a(described_class) }
    it { is_expected.to respond_to(:all_exemptions) }

    describe ".save" do
      it "adds exemptions to enrollment" do
        expect(enrollment).to receive(:save).and_return(true) # stub save

        subject.validate(params)
        subject.save

        expect(enrollment.exemptions.first).to eq(exemption)
      end

      it "leaves AD mode as unassistaed when no uodate user present" do
        expect(enrollment.updated_by_user_id).to be_nil

        subject.validate(params)
        subject.save

        expect(enrollment.enrollment_exemptions.first.assistance_mode).to eq("unassisted")
        expect(enrollment.enrollment_exemptions.first.unassisted?).to eq true
      end

      it "sets AD mode as fully when update user present" do
        enrollment.update updated_by_user_id: 1

        subject.validate(params)
        subject.save

        expect(enrollment.enrollment_exemptions.first.assistance_mode).to eq("fully_assisted")
        expect(enrollment.enrollment_exemptions.first.fully_assisted?).to eq true
      end
    end

    describe ".validate" do
      context "with empty exemptions params" do
        let(:params) { { params_key => {} } }
        let(:error_message) do
          I18n.t "activemodel.errors.messages.select_at_lease_one_exemptions"
        end
        it "should fail" do
          expect(subject.validate(params)).to be(false)
          expect(subject.errors.messages[:exemption_ids]).to eq([error_message])
        end
      end

      context "with no exemptions params" do
        let(:params) { { params_key => {} } }
        it "should fail" do
          expect(subject.validate(params)).to be(false)
        end
      end

      context "with good params" do
        it "should pass" do
          expect(subject.validate(params)).to be(true)
        end
      end
    end
  end
end
