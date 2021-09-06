require "rails_helper"

module FloodRiskEngine
  RSpec.describe CheckYourAnswersPresenter, type: :presenter do
    let(:new_registration) do
      build(:new_registration,
            :has_required_data_for_limited_company)
    end

    subject do
      described_class.new(new_registration)
    end

    describe "#registration_rows" do
      let(:expected_data) do
        [
          {
            title: "Exemption type",
            value: "#{new_registration.exemptions.first.code} #{new_registration.exemptions.first.summary}"
          },
          {
            title: "Grid reference",
            value: new_registration.temp_grid_reference
          },
          {
            title: "Site description",
            value: new_registration.temp_site_description
          },
          {
            title: "Organisation type",
            value: "Limited company"
          },
          {
            title: "Company registration number",
            value: new_registration.company_number
          },
          {
            title: "Operator name",
            value: new_registration.company_name
          },
          {
            title: "Operator address",
            value: [
              new_registration.try(:company_address).try(:organisation),
              new_registration.try(:company_address).try(:premises),
              new_registration.try(:company_address).try(:street_address),
              new_registration.try(:company_address).try(:locality),
              new_registration.try(:company_address).try(:city),
              new_registration.try(:company_address).try(:postcode)
            ].join(", ")
          }
        ]
      end

      it "returns the properly-formatted data" do
        expect(subject.registration_rows).to eq(expected_data)
      end

      context "when the registration is a partnership" do
        let(:new_registration) do
          build(:new_registration,
                :has_required_data_for_partnership)
        end

        before do
          first_partner = new_registration.transient_people.first
          first_partner_text = [
            first_partner.full_name,
            first_partner.transient_address.organisation,
            first_partner.transient_address.premises,
            first_partner.transient_address.street_address,
            first_partner.transient_address.locality,
            first_partner.transient_address.city,
            first_partner.transient_address.postcode
          ].join(", ")

          second_partner = new_registration.transient_people.last
          second_partner_text = [
            second_partner.full_name,
            second_partner.transient_address.organisation,
            second_partner.transient_address.premises,
            second_partner.transient_address.street_address,
            second_partner.transient_address.locality,
            second_partner.transient_address.city,
            second_partner.transient_address.postcode
          ].join(", ")

          expected_data[3][:value] = "Partnership"
          # Remove company number, name and address
          expected_data.delete_at(4)
          expected_data.delete_at(4)
          expected_data.delete_at(4)
          # Replace with partnership data
          expected_data.insert(4, title: "Details of responsible partner", value: first_partner_text)
          expected_data.insert(5, title: "Details of responsible partner", value: second_partner_text)
        end

        it "returns the properly-formatted data" do
          expect(subject.registration_rows).to eq(expected_data)
        end
      end

      context "when the registration has a FRA23 exemption" do
        before do
          new_registration.exemptions = [build(:exemption, code: "FRA23")]
          new_registration.dredging_length = 5

          expected_data.insert(3, title: "Dredging length", value: "#{new_registration.dredging_length} metres")
        end

        it "returns the properly-formatted data" do
          expect(subject.registration_rows).to eq(expected_data)
        end
      end
    end

    describe "#contact_rows" do
      let(:expected_data) do
        [
          {
            title: "Contact name",
            value: "#{new_registration.contact_name} (#{new_registration.contact_position})"
          },
          {
            title: "Contact telephone",
            value: new_registration.contact_phone
          },
          {
            title: "Contact email",
            value: new_registration.contact_email
          }
        ]
      end

      it "returns the properly-formatted data" do
        expect(subject.contact_rows).to eq(expected_data)
      end

      context "when the registration has no contact position" do
        before do
          new_registration.contact_position = nil
          expected_data[0][:value] = new_registration.contact_name
        end

        it "returns the properly-formatted data" do
          expect(subject.contact_rows).to eq(expected_data)
        end
      end

      context "when the registration has an additional contact" do
        before do
          new_registration.additional_contact_email = "additional@example.com"
          expected_data[3] = { title: "Additional contact email", value: "additional@example.com" }
        end

        it "returns the properly-formatted data" do
          expect(subject.contact_rows).to eq(expected_data)
        end
      end
    end
  end
end
