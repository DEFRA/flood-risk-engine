require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps
    describe CorrespondenceContactTelephoneForm, type: :form do
      let(:params_key) { :telephone_number }
      let(:enrollment) { FactoryGirl.create(:enrollment) }
      let(:model_class) { Contact }

      subject { described_class.factory(enrollment) }

      it { is_expected.to be_a(described_class) }

      let(:params) do
        {
          correspondence_contact_telephone: {
            telephone_number: @telephone_number
          }
        }
      end

      describe "#validate" do
        let(:error_message) { subject.errors.messages[:telephone_number] }
        let(:locale_key) { described_class.locale_key }

        it "should return true with a valid telephone number" do
          @telephone_number = "03708 506 506"
          expect(subject.validate(params)).to eq(true)
        end

        it "should return true with a valid international number" do
          @telephone_number = "+44 (0) 114 282 5312"
          expect(subject.validate(params)).to eq(true)
        end

        context "with an invalid telephone number" do
          before do
            @telephone_number = "invalid"
          end

          it "should return false" do
            expect(subject.validate(params)).to eq(false)
          end

          it "should display the locale error message" do
            subject.validate(params)
            expect(error_message)
              .to eq([I18n.t("#{locale_key}.errors.telephone_number.invalid")])
          end
        end

        context "with a blank telephone number" do
          before do
            @telephone_number = ""
          end

          it "should return false" do
            expect(subject.validate(params)).to eq(false)
          end

          it "should display the locale error message" do
            subject.validate(params)
            expect(error_message)
              .to eq([I18n.t("#{locale_key}.errors.telephone_number.blank")])
          end
        end
      end

      describe "#save" do
        it "should save telephone number to enrollment.correspondence_contact" do
          @telephone_number = "03708 506 506"
          subject.validate(params)
          subject.save
          enrollment.reload
          expect(
            enrollment.correspondence_contact.telephone_number
          ).to eq(@telephone_number)
        end
      end
    end
  end
end
