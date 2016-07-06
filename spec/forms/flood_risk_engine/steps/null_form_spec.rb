require "rails_helper"
module FloodRiskEngine
  module Steps
    RSpec.describe NullForm, type: :form do
      subject { described_class.factory(nil) }

      it "returns true on save" do
        expect(subject.save).to be(true)
      end

      it "returns true on validate" do
        expect(subject.validate({})).to be(true)
      end
    end
  end
end
