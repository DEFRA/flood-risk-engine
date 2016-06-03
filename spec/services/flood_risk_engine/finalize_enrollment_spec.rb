require "rails_helper"

module FloodRiskEngine
  RSpec.describe FinalizeEnrollmentService, type: :service do
    subject { described_class.new(enrollment) }
    let(:enrollment) do
      build_stubbed(:enrollment, status: Enrollment.statuses[:building])
    end

    it "changes the enrollment status to pending and sends the submitted email" do
      expect_any_instance_of(SendEnrollmentSubmittedEmail)
        .to receive(:call)
        .exactly(:once)
      expect { subject.finalize! }
        .to change { enrollment.status }
        .from("building")
        .to("pending")
    end

    context "with a nil enrollment" do
      let(:enrollment) { nil }
      it "raises an error" do
        expect { subject.finalize! }.to raise_error(ArgumentError)
      end
    end

    context "with an enrollment with a status other than 'building', "\
            "for example one that already has a status of 'pending'" do
      let(:enrollment) do
        build_stubbed(:enrollment, status: Enrollment.statuses[:pending])
      end
      it "raises an error" do
        expect { subject.finalize! }
          .to raise_error(InvalidEnrollmentStateError)
      end
    end
  end
end
