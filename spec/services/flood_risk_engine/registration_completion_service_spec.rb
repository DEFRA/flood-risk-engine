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
    let(:enrollment) { Enrollment.last }

    describe "#run" do
      it "creates a new enrollment" do
        expect { subject }.to change { Enrollment.count }.by(1)
      end

      it "assigns the correct data to the new enrollment" do
        subject

        expect(enrollment.step).to eq("confirmation")
      end

      it "assigns the correct correspondance contact to the new enrollment" do
        correspondence_contact_attributes = {
          "full_name" => new_registration.contact_name,
          "email_address" => new_registration.contact_email,
          "telephone_number" => new_registration.contact_phone,
          "position" => new_registration.contact_position
        }

        subject

        expect(enrollment.correspondence_contact.attributes).to include(correspondence_contact_attributes)
      end

      it "assigns the correct organisation to the new enrollment" do
        organisation_attributes = {
          "name" => new_registration.company_name,
          "org_type" => "limited_company"
        }

        subject

        expect(enrollment.organisation.attributes).to include(organisation_attributes)
      end

      context "when an additional contact email was given" do
        before { new_registration.update(additional_contact_email: "test@example.com") }

        it "assigns the correct secondary contact to the new enrollment" do
          secondary_contact_attributes = {
            "email_address" => new_registration.additional_contact_email
          }

          subject

          expect(enrollment.secondary_contact.attributes).to include(secondary_contact_attributes)
        end
      end

      it "assigns the correct exemption and enrollment_exemption to the new enrollment" do
        expected_exemption = new_registration.exemptions.first

        subject

        expect(enrollment.exemptions.first).to eq(expected_exemption)
        expect(enrollment.enrollment_exemptions.first.exemption_id).to eq(expected_exemption.id)
      end

      it "assigns the correct address to the new enrollment" do
        expected_address_data = new_registration.company_address.attributes.except(
          "address_type",
          "token",
          "addressable_id",
          "addressable_type",
          "created_at",
          "updated_at"
        )

        subject

        expect(enrollment.organisation.primary_address.attributes).to include(expected_address_data)
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

        it "does not create new related objects" do
          old_count = Contact.count

          expect { subject }.to raise_error(StandardError)

          expect(Contact.count).to eq(old_count)
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