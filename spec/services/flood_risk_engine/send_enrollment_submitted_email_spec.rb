require "rails_helper"

module FloodRiskEngine
  RSpec.describe SendEnrollmentSubmittedEmail, type: :service do
    let(:email_service) do
      FloodRiskEngine::Notify::EnrollmentSubmittedEmailService
    end

    let(:initial_status) { :pending }

    let(:enrollment_exemption) do
      FactoryBot.create(
        :enrollment_exemption,
        status: EnrollmentExemption.statuses[initial_status]
      )
    end

    let(:enrollment) do
      FactoryBot.create(
        :enrollment,
        :with_correspondence_contact,
        :with_secondary_contact,
        enrollment_exemptions: [enrollment_exemption]
      )
    end

    describe "#call" do
      context "argument validation" do
        it "raises an error if there is no correspondence contact email address" do
          enrollment.correspondence_contact.email_address = ""
          error_class = MissingEmailAddressError
          expect { described_class.new(enrollment).call }.to raise_error(error_class)
        end
      end

      context "when correspondence contact and 'other email recipient' (aka "\
              "secondary contact) have different email addresses" do
        it "sends an email to each address" do
          primary_contact_email   = enrollment.correspondence_contact.email_address
          secondary_contact_email = enrollment.secondary_contact.email_address

          expect(primary_contact_email).to be_present
          expect(secondary_contact_email).to be_present
          expect(primary_contact_email).to_not eq(secondary_contact_email)

          expect(email_service).to receive(:run)
            .exactly(:once)
            .with(enrollment:, recipient_address: primary_contact_email)

          expect(email_service).to receive(:run)
            .exactly(:once)
            .with(enrollment:, recipient_address: secondary_contact_email)

          described_class.new(enrollment).call
        end
      end

      context "when correspondence contact and secondary contact have the same email addresses" do
        it "sends one email to the shared address" do
          enrollment.secondary_contact.email_address = enrollment.correspondence_contact.email_address

          primary_contact_email   = enrollment.correspondence_contact.email_address
          secondary_contact_email = enrollment.secondary_contact.email_address

          expect(primary_contact_email).to_not be_blank
          expect(primary_contact_email).to eq(secondary_contact_email)

          expect(email_service).to receive(:run)
            .exactly(:once)
            .with(enrollment:, recipient_address: primary_contact_email)

          described_class.new(enrollment).call
        end
      end

      context "when correspondence contact is present but seconday contact has a '' email "\
              "address, which it does by default if nothing entered the 'email other' form" do
        it "sends one email to the correspondence contact and does not try "\
           " to sent the empty ('') secondary email" do
          enrollment.secondary_contact.email_address = "" # should result in it not being sent

          primary_contact_email   = enrollment.correspondence_contact.email_address
          secondary_contact_email = enrollment.secondary_contact.email_address

          expect(primary_contact_email).to_not be_blank
          expect(secondary_contact_email).to eq("")

          expect(email_service).to receive(:run)
            .exactly(:once)
            .with(enrollment:, recipient_address: primary_contact_email)

          described_class.new(enrollment).call
        end
      end
    end
  end
end
