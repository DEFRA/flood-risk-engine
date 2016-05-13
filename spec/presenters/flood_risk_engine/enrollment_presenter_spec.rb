require "rails_helper"

module FloodRiskEngine
  RSpec.describe EnrollmentPresenter, type: :presenter do
    let(:enrollment) do
      build(:enrollment,
            :with_locale_authority,
            :with_organisation_address,
            :with_exemption,
            :with_exemption_location,
            :with_correspondence_contact)
    end
    subject do
      described_class.new(enrollment)
    end
    it { is_expected.to respond_to(:organisation_type) }

    describe "#grid_reference" do
      it do
        expect(subject.grid_reference)
          .to eq(enrollment.exemption_location.grid_reference)
      end
    end

    describe "#organisation_type" do
      it do
        expect(subject.organisation_type).to eq(I18n.t("organisation_types.local_authority"))
      end
    end

    describe "#organisation_name" do
      it do
        expect(subject.organisation_name).to eq(enrollment.organisation.name)
      end
    end

    describe "#organisation_address" do
      it do
        expect(subject.organisation_address).to be_a(String)
      end
    end

    describe "#correspondence_contact_name" do
      it do
        contact = enrollment.correspondence_contact
        expected = "#{contact.full_name} (#{contact.position})"
        expect(subject.correspondence_contact_name).to eq(expected)
      end
    end
  end
end
