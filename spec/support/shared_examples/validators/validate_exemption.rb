# frozen_string_literal: true

# Tests for fields using the ExemptionsValidator
RSpec.shared_examples "validate exemptions" do |form_factory|
  it "validates exemptions using the ExemptionsValidator class" do
    validators = build(form_factory, :has_required_data)._validators
    expect(validators.keys).to include(:exemptions)
    expect(validators[:exemptions].first.class)
      .to eq(FloodRiskEngine::ExemptionsValidator)
  end
end
