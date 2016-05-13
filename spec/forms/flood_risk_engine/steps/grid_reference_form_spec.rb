require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps
    RSpec.describe GridReferenceForm, type: :form do
      let(:params_key) { :grid_reference }
      let(:enrollment) { FactoryGirl.create(:enrollment) }
      let(:model_class) { Location }
      let(:grid_reference) { "ST 58132 72695" }

      subject { described_class.factory(enrollment) }

      it_behaves_like "a form object"

      it { is_expected.to be_a(described_class) }
      it { is_expected.to respond_to(:grid_reference) }

      let(:params) { { params_key => { grid_reference: @grid_reference } } }

      describe "#validate" do
        let(:error_message) { subject.errors.messages[:grid_reference] }
        let(:locale_key) { described_class.locale_key }

        it "should return true with a valid grid reference" do
          @grid_reference = grid_reference
          expect(subject.validate(params)).to eq(true)
        end

        it "should ignore spacing" do
          @grid_reference = grid_reference.gsub(/\s/, "")
          expect(subject.validate(params)).to eq(true)
        end

        context "with an invalid grid reference" do
          before { @grid_reference = "invalid" }

          it "should return false" do
            expect(subject.validate(params)).to eq(false)
          end

          it "should display the locale error message" do
            subject.validate(params)
            expect(error_message)
              .to eq([I18n.t("#{locale_key}.errors.grid_reference.invalid")])
          end
        end

        context "with an out of range grid reference" do
          before { @grid_reference = "AA 58132 72695" }

          it "should return false" do
            expect(subject.validate(params)).to eq(false)
          end

          it "should display the locale error message" do
            subject.validate(params)
            expect(error_message)
              .to eq([I18n.t("#{locale_key}.errors.grid_reference.invalid")])
          end
        end

        context "with a short grid reference" do
          before { @grid_reference = "ST 5811 7261" }

          it "should return false" do
            expect(subject.validate(params)).to eq(false)
          end

          it "should display the locale error message" do
            subject.validate(params)
            expect(error_message)
              .to eq([I18n.t("#{locale_key}.errors.grid_reference.invalid")])
          end
        end

        context "with a blank grid reference" do
          before { @grid_reference = "" }

          it "should return false" do
            expect(subject.validate(params)).to eq(false)
          end

          it "should display the locale error message" do
            subject.validate(params)
            expect(error_message)
              .to eq([I18n.t("#{locale_key}.errors.grid_reference.blank")])
          end
        end
      end

      describe "#save" do
        it "should save the grid reference to enrollment.exemption_location" do
          @grid_reference = grid_reference
          subject.validate(params)
          subject.save
          enrollment.reload
          expect(
            enrollment.exemption_location.grid_reference
          ).to eq(@grid_reference)
        end
      end
    end
  end
end
