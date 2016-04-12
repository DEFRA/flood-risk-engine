require "spec_helper"

RSpec.shared_examples_for "a form object" do
  describe "#params_key" do
    it "returns the correct symbol for indexing into params" do
      expect(subject.params_key).to eq params_key
    end
  end
end
