require "rails_helper"
require_relative "../../support/shared_examples/form_objects"

module FloodRiskEngine
  RSpec.describe Steps::CheckLocationForm, type: :form do
    let(:params_key) { :check_location }
    let(:enrollment) { Enrollment.new }
    let(:model_class) { Enrollment }

    subject { described_class.factory(enrollment) }

    it_behaves_like "a form object"

    it { is_expected.to be_a(described_class) }
    it { is_expected.to respond_to(:location_check) }
    it { is_expected.to respond_to(:redirect?) }
    it { is_expected.to respond_to(:redirection_url) }
    it do
      is_expected.to validate_presence_of(:location_check)
        .with_message(t("errors.select_yes_or_no"))
    end

    describe '#save' do
      it "sets 'redirect' to true if they answered 'no'" do
        expect(enrollment).to receive(:save).and_return(true)
        FloodRiskEngine.config.redirection_url_on_location_unchecked = "http://gov.uk"
        params = { check_location: { location_check: "no" } }

        subject.validate(params)
        subject.save

        expect(subject.redirect?).to eq(true)
        expect(subject.redirection_url).to_not be_nil
      end
      it "sets does not set 'redirect' to true if they answered 'yes'" do
        expect(enrollment).to receive(:save).and_return(true)
        params = { check_location: { location_check: "yes" } }

        subject.validate(params)
        subject.save

        expect(subject.redirect?).to eq(false)
      end
    end
  end
end
