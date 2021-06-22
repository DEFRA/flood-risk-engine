# frozen_string_literal: true

RSpec.shared_examples "a transient_registration" do |model_factory|
  subject(:transient_registration) { create(model_factory) }

  describe "#token" do
    context "when a transient registration is created" do
      it "has a token" do
        expect(transient_registration.token).not_to be_empty
      end
    end
  end
end
