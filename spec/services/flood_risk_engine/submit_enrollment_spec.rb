require "rails_helper"

module FloodRiskEngine
  RSpec.describe SubmitEnrollmentService, type: :service do
    subject { described_class.new(enrollment) }
    let(:initial_status) { :building }
    let(:enrollment_exemption) do
      FactoryGirl.create(
        :enrollment_exemption,
        status: EnrollmentExemption.statuses[initial_status]
      )
    end
    let(:enrollment) do
      FactoryGirl.create(
        :enrollment,
        enrollment_exemptions: [enrollment_exemption]
      )
    end

    it "changes the enrollment status to pending and sends the submitted email" do
      expect_any_instance_of(SendEnrollmentSubmittedEmail)
        .to receive(:call)
        .exactly(:once)
      expect { subject.finalize! }
        .to change { enrollment_exemption.reload.status }
        .from("building")
        .to("pending")
    end

    it "sets the submitted_at date", duff: true do
      expect_any_instance_of(SendEnrollmentSubmittedEmail).to receive(:call).exactly(:once)
      expect { subject.finalize! }.to change { enrollment.submitted_at }.from(nil)
    end

    context "with an enrollment with a status other than 'building'" do
      let(:initial_status) { :approved }
      it "shoudl leave the status unchanged" do
        expect(enrollment_exemption.reload.status).to eq(initial_status.to_s)
      end
    end
  end
end
