require "rails_helper"

module FloodRiskEngine
  RSpec.describe SubmitEnrollmentService, type: :service do
    subject { described_class.new(enrollment) }
    let(:initial_status) { :building }
    let(:enrollment_exemption) do
      FactoryBot.create(
        :enrollment_exemption,
        status: EnrollmentExemption.statuses[initial_status]
      )
    end
    let(:enrollment) do
      FactoryBot.create(
        :enrollment,
        enrollment_exemptions: [enrollment_exemption]
      )
    end

    describe "#finalize!" do
      before do
        expect_any_instance_of(SendEnrollmentSubmittedEmail)
          .to receive(:call)
          .exactly(:once)
      end

      it "changes the enrollment status to pending and sends the submitted email" do
        expect { subject.finalize! }
          .to change { enrollment_exemption.reload.status }
          .from("building")
          .to("pending")
      end

      it "sets the submitted_at date", duff: true do
        expect { subject.finalize! }.to change { enrollment.submitted_at }.from(nil)
      end

      it "should generate a new reference number" do
        expect { subject.finalize! }.to change { ReferenceNumber.count }.by(1)
        expect(enrollment.reference_number).to eq(ReferenceNumber.last.number)
      end
    end

    context "with an enrollment with a status other than 'building'" do
      let(:initial_status) { :approved }
      it "shoudl leave the status unchanged" do
        expect(enrollment_exemption.reload.status).to eq(initial_status.to_s)
      end
    end
  end
end
