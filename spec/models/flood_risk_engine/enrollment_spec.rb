require "rails_helper"

module FloodRiskEngine
  RSpec.describe Enrollment, type: :model do
    let(:enrollment) { create(:enrollment) }
    let(:steps) { %w[step1 step2 step3] }
    let(:initial_step) { steps[0] }

    it { is_expected.to belong_to(:applicant_contact) }

    describe "intializing an instance" do
      context "with a new instance" do
        it "should have the current step set as the initial step" do
          expect(enrollment.current_step).to eq(initial_step)
        end
      end

      context "with a saved instance" do
        let(:enrollment) { create(:enrollment, step: steps[1]) }
        it "should have current step matching the saved step" do
          expect(enrollment.current_step).to eq(steps[1])
        end
      end
    end

    describe "#next_step" do
      it "should change current step to next step" do
        expect(enrollment.current_step).to eq(steps[0])
        enrollment.next_step
        expect(enrollment.current_step).to eq(steps[1])
        enrollment.next_step
        expect(enrollment.current_step).to eq(steps[2])
      end

      it "should preserve the current step after save" do
        enrollment.next_step
        enrollment.reload
        expect(enrollment.step).to eq(steps[1])
        expect(enrollment.current_step).to eq(steps[1])
      end
    end

    describe "#set_step_as" do
      context "with valid step" do
        let(:new_step) { steps[2] }
        before do
          enrollment.set_step_as new_step
        end
        it "should change the current step to the new step" do
          expect(enrollment.current_step).to eq(new_step)
        end
        it "should change the step to the new step" do
          expect(enrollment.step).to eq(new_step)
        end
        it "the change should be preserved" do
          enrollment.reload
          expect(enrollment.step).to eq(new_step)
          expect(enrollment.current_step).to eq(new_step)
        end
      end
      context "with unknown step" do
        let(:new_step) { "unknown" }
        it "should raise an error and the step should not be saved" do
          expect do
            enrollment.set_step_as new_step
          end.to raise_error(ActiveRecord::RecordInvalid)

          enrollment.reload
          expect(enrollment.step).to eq(initial_step)
        end
      end
    end
  end
end
