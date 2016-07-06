require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps
    RSpec.describe UnknownForm, type: :form do
      let(:enrollment) { FactoryGirl.create(:enrollment, :with_unknown) }
      let(:form) { described_class.factory(enrollment) }
      let(:params_key) { :unknown }
      let(:params) { { params_key => { foo: :bar } } }

      subject { form }

      describe "#validate" do
        it "should return false" do
          expect(form.validate(params)).to eq(false)
        end
      end

      describe "#save" do
        it "should return false" do
          form.validate(params)
          expect(form.save).to eq(false)
        end
      end
    end
  end
end
