# frozen_string_literal: true

# Tests for fields using the CompanyNumberValidator
RSpec.shared_examples "validate company_number" do |form_factory|
  context "when a valid transient registration exists" do
    let(:form) { build(form_factory, :has_required_data) }

    context "when a company_number meets the requirements" do
      it "is valid" do
        expect(form).to be_valid
      end
    end

    context "when a company_number is blank" do
      before do
        form.transient_registration.company_number = ""
      end

      it "is not valid" do
        expect(form).to_not be_valid
      end
    end

    context "when a company number is too long" do
      before do
        form.transient_registration.company_number = "ak67inm5ijij85w3a7gck"
      end

      it "is not valid" do
        expect(form).to_not be_valid
      end
    end

    context "when a company number is the wrong format" do
      before do
        form.transient_registration.company_number = "incorrect"
      end

      it "is not valid" do
        expect(form).to_not be_valid
      end
    end
  end
end
