require "rails_helper"

module FloodRiskEngine
  RSpec.describe GridReferenceValidator, type: :model do
    class Foo
      include ActiveModel::Validations
      attr_accessor :grid_reference, :with_message, :with_allow_blank
      def initialize(input)
        @grid_reference = @with_message = @with_allow_blank = input
      end

      validates(
        :grid_reference,
        "flood_risk_engine/grid_reference" => true
      )
      validates(
        :with_message,
        "flood_risk_engine/grid_reference" => {
          message: "Custom"
        }
      )
      validates(
        :with_allow_blank,
        "flood_risk_engine/grid_reference" => {
          allow_blank: true
        }
      )
    end

    let(:grid_reference) { "ST 12345 67890" }
    let(:foo) { Foo.new grid_reference }
    let(:all_tested) { %i[grid_reference with_allow_blank with_message] }

    it "should be valid" do
      expect(foo.valid?).to be true
    end

    context "invalid grid_reference" do
      let(:grid_reference) { "invalid" }
      before do
        foo.valid?
      end

      it "should raise errors on all" do
        expect(foo.errors.attribute_names.sort).to eq(all_tested)
      end

      it "should have error from exception" do
        expect(foo.errors[:grid_reference]).not_to eq(["Custom"])
        expect(foo.errors[:grid_reference].first).to be_a(String)
      end

      it "with_message should have custom message" do
        expect(foo.errors[:with_message]).to eq(["Custom"])
      end
    end

    context "blank grid_reference" do
      let(:grid_reference) { "" }
      before do
        foo.valid?
      end

      it "should raise errors on all except with_allow_blank" do
        expect(foo.errors.attribute_names.sort).to eq(all_tested - [:with_allow_blank])
      end
    end

    context "lower case grid_reference" do
      let(:grid_reference) { "st 12345 67890" }

      it "should be valid" do
        expect(foo.valid?).to be true
      end
    end
  end
end
