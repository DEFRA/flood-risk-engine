# frozen_string_literal: true

RSpec.shared_examples "validate postcode" do |form_factory, field|
  context "when a valid transient registration exists" do
    let(:form) { build(form_factory, :has_required_data) }

    context "when a postcode meets the requirements" do
      before do
        example_json = { postcode: "BS1 5AH" }
        response = double(:response, results: [example_json], successful?: true)

        allow(FloodRiskEngine::AddressLookupService).to receive(:run).and_return(response)
      end

      it "is valid" do
        expect(form).to be_valid
      end
    end

    context "when a postcode is blank" do
      before { form.transient_registration.send("#{field}=", "") }

      it { expect(form).not_to be_valid }
    end

    context "when a postcode is in the wrong format" do
      before { form.transient_registration.send("#{field}=", "foo") }

      it { expect(form).not_to be_valid }
    end

    context "when the postcode string has trailing O instead of 0 in the outcode" do
      before { form.transient_registration.send("#{field}=", "SSO 9SL") }

      it { expect(form).not_to be_valid }
    end

    context "when a postcode has no matches" do
      before do
        response = double(:response, successful?: false, error: DefraRuby::Address::NoMatchError.new)

        allow(FloodRiskEngine::AddressLookupService).to receive(:run).and_return(response)
      end

      it { expect(form).not_to be_valid }
    end

    context "when a postcode search returns an error" do
      before do
        response = double(:response, successful?: false, error: "foo")

        allow(FloodRiskEngine::AddressLookupService).to receive(:run).and_return(response)
      end

      it { expect(form).to be_valid }
    end
  end
end
