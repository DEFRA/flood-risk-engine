# frozen_string_literal: true

# Tests for fields using the PostcodeValidator
RSpec.shared_examples "validate postcode" do |form_factory, field|
  context "when a valid transient registration exists" do
    let(:form) { build(form_factory, :has_required_data) }

    context "when a postcode meets the requirements" do
      before do
        example_json = { postcode: "BS1 5AH" }
        response = double(:response, results: [example_json], successful?: true)

        expect(FloodRiskEngine::AddressLookupService).to receive(:run).and_return(response)
      end

      it "is valid" do
        expect(form).to be_valid
      end
    end

    context "when a postcode is blank" do
      before do
        form.transient_registration.send("#{field}=", "")
      end

      it "is not valid" do
        expect(form).to_not be_valid
      end
    end

    context "when a postcode is in the wrong format" do
      before do
        form.transient_registration.send("#{field}=", "")
      end

      it "is not valid" do
        expect(form).to_not be_valid
      end
    end

    context "when a postcode has no matches" do
      before do
        response = double(:response, successful?: false, error: DefraRuby::Address::NoMatchError.new)

        expect(FloodRiskEngine::AddressLookupService).to receive(:run).and_return(response)
      end

      it "is not valid" do
        expect(form).to_not be_valid
      end
    end

    context "when a postcode search returns an error" do
      before do
        response = double(:response, successful?: false, error: "foo")

        expect(FloodRiskEngine::AddressLookupService).to receive(:run).and_return(response)
      end

      it "is valid" do
        expect(form).to be_valid
      end
    end
  end
end
