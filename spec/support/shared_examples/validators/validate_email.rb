# frozen_string_literal: true

# Tests for fields using the EmailValidator
RSpec.shared_examples "validate email" do |form_factory, field|
  it "validates the #{field} using the EmailValidator class" do
    validators = build(form_factory, :has_required_data)._validators
    expect(validators.keys).to include(field)
    expect(validators[field].first.class)
      .to eq(DefraRuby::Validators::EmailValidator)
  end
end
