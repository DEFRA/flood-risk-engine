# frozen_string_literal: true

# Tests for fields using the PhoneNumberValidator
RSpec.shared_examples "validate contact_phone" do |form_factory|
  it "validates the phone number using the PhoneNumberValidator class" do
    validators = build(form_factory, :has_required_data)._validators
    expect(validators.keys).to include(:contact_phone)
    expect(validators[:contact_phone].first.class)
      .to eq(DefraRuby::Validators::PhoneNumberValidator)
  end
end
