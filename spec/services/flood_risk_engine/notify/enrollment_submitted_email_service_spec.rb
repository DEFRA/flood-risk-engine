# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  module Notify
    RSpec.describe EnrollmentSubmittedEmailService do
      describe ".run" do
        let!(:template_id) { "6e444a8c-c656-45aa-97d8-e95181ff3a75" }
        let(:recipient_address) { Faker::Internet.safe_email }

        let!(:enrollment) do
          create(:enrollment, :with_exemption, reference_number: ReferenceNumber.create)
        end

        let(:exemption_description) do
          exemption = enrollment.exemptions.first
          "#{exemption.summary} #{exemption.code}"
        end

        let(:expected_notify_options) do
          {
            email_address: recipient_address,
            template_id: template_id,
            personalisation: {
              registration_number: enrollment.reference_number,
              exemption_description: exemption_description
            }
          }
        end

        before do
          expect_any_instance_of(Notifications::Client)
            .to receive(:send_email)
            .with(expected_notify_options)
            .and_call_original
        end

        subject do
          VCR.use_cassette("enrollment_submitted_sends_an_email") do
            described_class.run(
              enrollment: enrollment,
              recipient_address: recipient_address
            )
          end
        end

        it "sends an email" do
          expect(subject).to be_a(Notifications::Client::ResponseNotification)
          expect(subject.template["id"]).to eq(template_id)
          expect(subject.content["subject"]).to eq("Flood risk activity exemption submitted")
        end
      end
    end
  end
end
