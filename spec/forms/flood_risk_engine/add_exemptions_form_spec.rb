require "rails_helper"
require_relative "../../support/shared_examples/form_objects"

module FloodRiskEngine
  RSpec.describe Steps::AddExemptionsForm, type: :form do
    let(:params_key) { :add_exemptions }
    let(:enrollment) { FactoryGirl.create(:enrollment) }
    let(:model_class) { Enrollment }
    let(:exemptions) { FactoryGirl.create_list(:exemption, 3) }
    let(:params) { { params_key => { exemptions: exemptions.collect(&:id) } } }

    subject { described_class.factory(enrollment) }

    it_behaves_like "a form object"

    it { is_expected.to be_a(described_class) }
    it { is_expected.to respond_to(:exemptions) }

    describe ".save" do
      it "adds exemptions to enrollment" do
        expect(enrollment).to receive(:save).and_return(true) # stub save

        subject.validate(params)
        subject.save

        expect(enrollment.exemptions).to eq(exemptions)
      end
    end

    describe ".validate" do
      context "with empty exemptions params" do
        let(:params) { { params_key => { exemptions: [] } } }
        it "should fail" do
          expect(subject.validate(params)).to be(false)
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
