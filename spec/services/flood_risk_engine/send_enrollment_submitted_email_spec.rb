require "rails_helper"

module FloodRiskEngine
  RSpec.describe SendEnrollmentSubmittedEmail, type: :service do
    let(:mailer) { EnrollmentMailer }
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

          message_delivery = instance_double(ActionMailer::MessageDelivery)
          expect(message_delivery).to receive(:deliver_later).exactly(:twice)

          expect(mailer).to receive(:submitted)
            .exactly(:once)
            .with(enrollment_id: enrollment.id, recipient_address: primary_contact_email)
            .and_return(message_delivery)

          expect(mailer).to receive(:submitted)
            .exactly(:once)
            .with(enrollment_id: enrollment.id, recipient_address: secondary_contact_email)
            .and_return(message_delivery)

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

          message_delivery = instance_double(ActionMailer::MessageDelivery)
          expect(message_delivery).to receive(:deliver_later).exactly(:once)

          expect(mailer).to receive(:submitted)
            .exactly(:once)
            .with(enrollment_id: enrollment.id, recipient_address: primary_contact_email)
            .and_return(message_delivery)

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

          message_delivery = instance_double(ActionMailer::MessageDelivery)
          expect(message_delivery).to receive(:deliver_later).exactly(:once)

          expect(mailer).to receive(:submitted)
            .exactly(:once)
            .with(enrollment_id: enrollment.id, recipient_address: primary_contact_email)
            .and_return(message_delivery)

          described_class.new(enrollment).call
        end
      end
    end
  end
end
