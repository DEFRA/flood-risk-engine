require "rails_helper"

module FloodRiskEngine
  module Enrollments
    RSpec.describe PartnersController, type: :controller do
      routes { Engine.routes }
      render_views
      let(:step) { :partnership_details }
      let(:first_partnership_step) { :partnership }
      let(:address) { FactoryGirl.create(:address) }
      let(:contact) { FactoryGirl.create(:contact, address: address) }
      let(:enrollment) do
        FactoryGirl.create(:enrollment, :with_partnership, step: step)
      end
      let(:partner) do
        FactoryGirl.create(
          :partner,
          contact: contact,
          organisation: enrollment.organisation
        )
      end

      describe "show action" do
        before do
          get :show, id: partner, enrollment_id: enrollment
        end

        it "should render page successfully" do
          expect(response).to have_http_status(:success)
        end

        it "should display partner's name" do
          expect(partner.address.postcode).to eq(address.postcode)
          expect(response.body).to match(contact.full_name)
        end
      end

      describe "edit action" do
        before do
          get :edit, id: partner, enrollment_id: enrollment
        end

        it "should change step to first partnership step" do
          expect(enrollment.reload.step).to eq(first_partnership_step.to_s)
        end

        it "should redirect to start of partnership steps" do
          expect(response).to redirect_to(
            enrollment_step_path(enrollment, first_partnership_step)
          )
        end
      end

      describe "destroy" do
        context "via post" do
          before do
            post :destroy, id: partner, enrollment_id: enrollment
          end

          it "should delete the partner" do
            expect(enrollment.reload.partners.empty?).to eq(true)
          end

          it "should change step to first partnership step" do
            expect(enrollment.reload.step).to eq(first_partnership_step.to_s)
          end

          it "should redirect to start of partnership steps" do
            expect(response).to redirect_to(
              enrollment_step_path(enrollment, first_partnership_step)
            )
          end
        end

        context "via delete" do
          before do
            delete :destroy, id: partner, enrollment_id: enrollment
          end

          it "should delete the partner" do
            expect(enrollment.reload.partners.empty?).to eq(true)
          end

          it "should change step to first partnership step" do
            expect(enrollment.reload.step).to eq(first_partnership_step.to_s)
          end

          it "should redirect to start of partnership steps" do
            expect(response).to redirect_to(
              enrollment_step_path(enrollment, first_partnership_step)
            )
          end
        end

        context "when more than one partner exists" do
          let(:address2) { FactoryGirl.create(:address) }
          let(:contact2) { FactoryGirl.create(:contact, address: address2) }
          let(:partner2) do
            FactoryGirl.create(
              :partner,
              contact: contact2,
              organisation: enrollment.organisation
            )
          end

          before do
            partner2 # ensure 2nd partner exists before action called
            delete :destroy, id: partner, enrollment_id: enrollment
          end

          it "should delete the partner" do
            expect(enrollment.reload.partners.count).to eq(1)
          end

          it "should maintain the current step" do
            expect(enrollment.reload.step).to eq(step.to_s)
          end

          it "should redirect to current step" do
            expect(response).to redirect_to(
              enrollment_step_path(enrollment, step)
            )
          end
        end
      end
    end
  end
end
