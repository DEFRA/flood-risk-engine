# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe RegistrationCompletionService do
    before { VCR.insert_cassette("notify_registration_completion_service") }
    after { VCR.eject_cassette }

    let(:new_registration) do
      create(:new_registration,
             :has_required_data_for_limited_company,
             workflow_state: "registration_complete_form")
    end
    let(:enrollment) { Enrollment.last }

    subject(:run_service) { described_class.run(transient_registration: new_registration) }

    describe "#run" do
      it "creates a new enrollment" do
        expect { run_service }.to change(Enrollment, :count).by(1)
      end

      it "assigns the correct data to the new enrollment" do
        stub_time = Time.zone.local(2000, 1, 1)
        expect(Time.zone).to receive(:now).at_least(:once).and_return(stub_time)

        run_service

        expect(enrollment.step).to eq("confirmation")
        expect(enrollment.submitted_at).to eq(stub_time)
      end

      it "assigns the correct correspondance contact to the new enrollment" do
        correspondence_contact_attributes = {
          "full_name" => new_registration.contact_name,
          "email_address" => new_registration.contact_email,
          "telephone_number" => new_registration.contact_phone,
          "position" => new_registration.contact_position
        }

        run_service

        expect(enrollment.correspondence_contact.attributes).to include(correspondence_contact_attributes)
      end

      it "assigns the correct organisation to the new enrollment" do
        organisation_attributes = {
          "name" => new_registration.company_name,
          "org_type" => "limited_company"
        }

        run_service

        expect(enrollment.organisation.attributes).to include(organisation_attributes)
      end

      it "assigns the correct secondary contact to the new enrollment" do
        secondary_contact_attributes = {
          "email_address" => new_registration.additional_contact_email
        }

        run_service

        expect(enrollment.secondary_contact.attributes).to include(secondary_contact_attributes)
      end

      it "assigns the correct exemption and enrollment_exemption to the new enrollment" do
        expected_exemption = new_registration.exemptions.first

        run_service

        expect(enrollment.exemptions.first).to eq(expected_exemption)
        expect(enrollment.enrollment_exemptions.first.exemption_id).to eq(expected_exemption.id)
      end

      it "assigns the correct address to the new enrollment" do
        expected_address_data = new_registration.company_address.attributes.except(
          "id",
          "address_type",
          "token",
          "addressable_id",
          "addressable_type",
          "created_at",
          "updated_at"
        )

        run_service

        expect(enrollment.organisation.primary_address.attributes).to include(expected_address_data)
      end

      context "when the address doesn't have an organisation field" do
        before { new_registration.company_address.update(organisation: nil) }

        it "assigns the correct address to the new enrollment" do
          run_service

          expect(enrollment.organisation.primary_address[:organisation]).to eq("")
        end
      end

      it "assigns the correct site location to the new enrollment" do
        expect(UpdateWaterManagementAreaJob).to receive(:perform_later).with(an_instance_of(Location))

        location_attributes = {
          "grid_reference" => new_registration.temp_grid_reference,
          "description" => new_registration.temp_site_description,
          "dredging_length" => new_registration.dredging_length
        }

        run_service

        expect(enrollment.exemption_location.attributes).to include(location_attributes)
      end

      it "assigns the correct reference number" do
        run_service

        expect(enrollment.reference_number).to eq(ReferenceNumber.last.number)
      end

      it "assigns the status" do
        run_service

        expect(enrollment.enrollment_exemptions.first.status).to eq("pending")
      end

      it "assigns the assistance mode" do
        run_service

        expect(enrollment.enrollment_exemptions.first.assistance_mode).to eq("unassisted")
      end

      it "sends a confirmation email" do
        expect(SendEnrollmentSubmittedEmail).to receive(:new).with(an_instance_of(Enrollment)).and_call_original

        run_service
      end

      it "deletes the old transient registration" do
        new_registration.touch # So the object exists to be counted before the service runs

        expect { run_service }.to change(NewRegistration, :count).by(-1)
      end

      context "when the business is a partnership" do
        let(:new_registration) do
          create(:new_registration,
                 :has_required_data_for_partnership,
                 workflow_state: "registration_complete_form")
        end

        it "assigns the correct organisation to the new enrollment" do
          organisation_attributes = {
            "name" => nil,
            "org_type" => "partnership"
          }

          run_service

          expect(enrollment.organisation.attributes).to include(organisation_attributes)
        end

        it "assigns the correct partners to the new enrollment" do
          excluded_address_attributes = %w[id address_type token addressable_id addressable_type created_at updated_at]

          first_partner = new_registration.transient_people.first
          first_partner_name = first_partner.full_name
          first_partner_address_attributes = first_partner.transient_address
                                                          .attributes
                                                          .except(*excluded_address_attributes)

          second_partner = new_registration.transient_people.last
          second_partner_name = second_partner.full_name
          second_partner_address_attributes = second_partner.transient_address
                                                            .attributes
                                                            .except(*excluded_address_attributes)

          run_service

          enrollment_first_partner = enrollment.organisation.partners.first
          enrollment_second_partner = enrollment.organisation.partners.last

          expect(enrollment_first_partner.full_name).to eq(first_partner_name)
          expect(enrollment_first_partner.address.attributes).to include(first_partner_address_attributes)

          expect(enrollment_second_partner.full_name).to eq(second_partner_name)
          expect(enrollment_second_partner.address.attributes).to include(second_partner_address_attributes)
        end

        context "when the partner address doesn't have an organisation field" do
          before { new_registration.transient_people.first.transient_address.update(organisation: nil) }

          it "assigns the correct address to the new partner" do
            run_service

            enrollment_first_partner = enrollment.organisation.partners.first

            expect(enrollment_first_partner.address[:organisation]).to eq("")
          end
        end
      end

      context "when an error occurs" do
        before do
          allow(new_registration).to receive(:destroy).and_raise(StandardError)
        end

        it "does not create a new enrollment" do
          old_count = Enrollment.count

          expect { run_service }.to raise_error(StandardError)

          expect(Enrollment.count).to eq(old_count)
        end

        it "does not create new related objects" do
          old_count = Contact.count

          expect { run_service }.to raise_error(StandardError)

          expect(Contact.count).to eq(old_count)
        end

        it "does not delete the old transient registration" do
          new_registration.touch # So the object exists to be counted before the service runs
          old_count = NewRegistration.count

          expect { run_service }.to raise_error(StandardError)

          expect(NewRegistration.count).to eq(old_count)
        end
      end
    end
  end
end
