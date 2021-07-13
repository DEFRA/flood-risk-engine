# frozen_string_literal: true

# Tests for fields using the BusinessTypeValidator
RSpec.shared_examples "validate business_type" do |form_factory|
  it "validates the phone number using the BusinessTypeValidator class" do
    validators = build(form_factory, :has_required_data)._validators
    expect(validators.keys).to include(:business_type)
    expect(validators[:business_type].first.class)
      .to eq(DefraRuby::Validators::BusinessTypeValidator)
  end
end
