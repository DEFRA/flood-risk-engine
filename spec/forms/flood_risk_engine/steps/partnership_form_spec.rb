require "rails_helper"
require_relative "../../../support/shared_examples/form_objects"

module FloodRiskEngine
  module Steps

    RSpec.describe PartnershipForm, type: :form do
      let(:params_key) { :partnership }
      let(:enrollment) { FactoryBot.create(:enrollment, :with_partnership) }
      let(:model_class) { FloodRiskEngine::Contact }
      let(:name) { Faker::Name.name }
      let!(:i18n_scope) { described_class.locale_key }
      let(:form) { described_class.factory(enrollment) }

      subject { form }

      it_behaves_like "a form object"

      it "has redirect? as false" do
        expect(subject.redirect?).to eq(false)
      end

      describe "#validate" do
        it "does not validate when no name supplied" do
          params = { form.params_key => { full_name: "" } }

          expect(form.validate(params)).to eq(false)
          expect(subject.errors.messages[:full_name])
            .to eq([I18n.t(".errors.full_name.blank", scope: i18n_scope)])
        end

        it "does not validate when name with unacceptable chars" do
          params = { form.params_key => { full_name: "Fred *& " } }

          expect(form.validate(params)).to eq(false)
          expect(subject.errors.messages[:full_name])
            .to eq([I18n.t("flood_risk_engine.validation_errors.name.invalid")])
        end

        it "does not validate when name supplied is too long" do
          name = "bb" + ("a" * described_class.max_length)
          params = { form.params_key => { full_name: name } }

          expect(form.validate(params)).to eq(false)
          expect(
            subject.errors.messages[:full_name]
          ).to eq(
            [
              I18n.t(
                ".errors.full_name.too_long",
                max: described_class.max_length,
                scope: i18n_scope
              )
            ]
          )
        end
      end

      describe "#save" do
        let(:params) { { form.params_key => { full_name: name } } }

        before do
          expect(form.validate(params)).to eq(true)
        end

        it "should create a new partner" do
          expect { form.save }.to change { Partner.count }.by(1)
        end

        it "should create a new contact" do
          expect { form.save }.to change { Contact.count }.by(1)
        end

        it "should save the name to the partner" do
          form.save
          expect(Partner.last.full_name).to eq(name)
        end
      end

      describe "#partner_count" do
        it "should return one when creating first partner" do
          expect(form.partner_count).to eq(1)
        end

        context "with an existing partner" do
          before do
            enrollment.organisation.partners.create
          end

          it "should return the existing count of partners plus 1" do
            expect(form.partner_count).to eq(Partner.count + 1)
          end
        end
      end
    end
  end
end
