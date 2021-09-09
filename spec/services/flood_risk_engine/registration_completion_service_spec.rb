# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe RegistrationCompletionService do
    let(:new_registration) do
      create(:new_registration,
             :has_required_data_for_limited_company,
             workflow_state: "registration_complete_form")
    end
    let(:subject) { described_class.run(transient_registration: new_registration) }

    describe "#run" do
      it "creates a new enrollment" do
        expect { subject }.to change { Enrollment.count }.by(1)
      end

      it "deletes the old transient registration" do
        new_registration.touch # So the object exists to be counted before the service runs

        expect { subject }.to change { NewRegistration.count }.by(-1)
      end

      context "when an error occurs" do
        before do
          expect(new_registration).to receive(:destroy).and_raise(StandardError)
        end

        it "does not create a new enrollment" do
          old_count = Enrollment.count

          expect { subject }.to raise_error(StandardError)

          expect(Enrollment.count).to eq(old_count)
        end

        it "does not delete the old transient registration" do
          new_registration.touch # So the object exists to be counted before the service runs
          old_count = NewRegistration.count

          expect { subject }.to raise_error(StandardError)

          expect(NewRegistration.count).to eq(old_count)
        end
      end
    end
  end
end
