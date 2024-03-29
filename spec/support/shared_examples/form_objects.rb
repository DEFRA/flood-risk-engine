# frozen_string_literal: true

require "spec_helper"

RSpec.shared_examples_for "a form object" do
  describe "#params_key" do
    it "returns the correct symbol for indexing into params" do
      expect(subject.params_key).to eq params_key
    end
  end

  describe "#enrollment_id" do
    it "returns the id of the enrollment the form object was initialised with" do
      expect(subject.enrollment_id).to eq(enrollment.id)
    end
  end

  describe "#model" do
    it "is the correct type" do
      expect(subject.model).to be_a(model_class)
    end
  end
end
