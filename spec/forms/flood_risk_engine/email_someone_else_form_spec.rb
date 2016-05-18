require "rails_helper"
require_relative "../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps
    RSpec.describe EmailSomeoneElseForm, type: :form do
      let(:params_key) { :email_someone_else }
      let(:enrollment) { FactoryGirl.create(:enrollment) }
      let(:model_class) { Contact }
      let(:email_address) { Faker::Internet.safe_email }
      let(:email_address_confirmation) { email_address }

      subject { described_class.factory(enrollment) }
      let(:error_messages) { subject.errors.messages }
      let(:locale_key) { described_class.locale_key }

      it_behaves_like "a form object"

      it { is_expected.to be_a(described_class) }
      it { is_expected.to respond_to(:email_address) }
      it { is_expected.to respond_to(:email_address_confirmation) }

      let(:params) {
        {
          params_key => {
            email_address: email_address,
            email_address_confirmation: email_address_confirmation
          }
        }
      }

      describe "#validate" do
        it "should return true with a valid email and matching confirmation" do
          expect(subject.validate(params)).to eq(true)
        end

        context "when both email address and confirmation are blank" do
          let(:email_address) { "" }
          let(:email_address_confirmation) { "" }

          it "should return true" do
            expect(subject.validate(params)).to eq(true)
          end
        end

        context "with an invalid emails addres" do
          let(:email_address) { "foo@bar" }

          it "should return false" do
            expect(subject.validate(params)).to eq(false)
          end

          it "should display the locale error message" do
            subject.validate(params)
            expect(error_messages[:email_address])
              .to eq([I18n.t("#{locale_key}.errors.email_address.invalid")])
          end
        end

        context "with a blank emails address" do
          let(:email_address) { "" }
          let(:email_address_confirmation) { Faker::Internet.safe_email }

          it "should return false" do
            expect(subject.validate(params)).to eq(false)
          end

          it "should display the locale error message" do
            subject.validate(params)
            expect(error_messages[:email_address])
              .to eq([I18n.t("#{locale_key}.errors.email_address.blank")])
          end
        end

        context "with a blank emails address confirmation" do
          let(:email_address_confirmation) { "" }

          it "should return false" do
            expect(subject.validate(params)).to eq(false)
          end

          it "should display the locale error message" do
            subject.validate(params)
            expect(error_messages[:email_address_confirmation])
              .to eq(
                [
                  I18n.t("#{locale_key}.errors.email_address_confirmation.blank")
                ]
              )
          end
        end

        context "with a miss-matching emails address confirmation" do
          let(:email_address_confirmation) { Faker::Internet.safe_email }

          it "should return false" do
            expect(subject.validate(params)).to eq(false)
          end

          it "should display the locale error message" do
            subject.validate(params)
            expect(error_messages[:email_address_confirmation])
              .to eq(
                [
                  I18n.t("#{locale_key}.errors.email_address_confirmation.invalid")
                ]
              )
          end
        end
      end

      describe "#save" do
        it "should save email address to enrollment.secondary_contact" do
          subject.validate(params)
          subject.save
          enrollment.reload
          expect(enrollment.secondary_contact.email_address).to eq(email_address)
        end
      end
    end
  end
end
