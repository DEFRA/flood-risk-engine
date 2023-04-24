# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  module Notify
    RSpec.describe EnrollmentSubmittedEmailService do
      describe ".run" do
        let!(:template_id) { "6e444a8c-c656-45aa-97d8-e95181ff3a75" }
        let(:recipient_address) { Faker::Internet.email }

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
            template_id:,
            personalisation: {
              registration_number: enrollment.reference_number,
              exemption_description:
            }
          }
        end

        before do
          allow_any_instance_of(Notifications::Client)
            .to receive(:send_email)
            .with(expected_notify_options)
            .and_call_original
        end

        subject(:run_service) do
          VCR.use_cassette("enrollment_submitted_sends_an_email") do
            described_class.run(
              enrollment:,
              recipient_address:
            )
          end
        end

        it "sends an email" do
          expect(run_service).to be_a(Notifications::Client::ResponseNotification)
          expect(run_service.template["id"]).to eq(template_id)
          expect(run_service.content["subject"]).to eq("Flood risk activity exemption submitted")
        end
      end
    end
  end
end
