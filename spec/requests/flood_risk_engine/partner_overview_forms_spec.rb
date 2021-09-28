# frozen_string_literal: true

require "rails_helper"

module FloodRiskEngine
  RSpec.describe "PartnerOverviewForms", type: :request do
    include_examples "GET flexible form", "partner_overview_form"

    include_examples "POST without params form", "partner_overview_form"

    describe "GET back_partner_overview_forms_path" do
      context "when a valid transient registration exists" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "partner_overview_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the business_type form" do
            get back_partner_overview_forms_path(transient_registration[:token])

            expect(response).to have_http_status(302)
            expect(response).to redirect_to(new_business_type_form_path(transient_registration[:token]))
          end
        end
      end

      context "when the transient registration is in the wrong state" do
        let(:transient_registration) do
          create(:new_registration,
                 workflow_state: "declaration_form")
        end

        context "when the back action is triggered" do
          it "returns a 302 response and redirects to the correct form for the state" do
            get back_partner_overview_forms_path(transient_registration[:token])

            expect(response).to have_http_status(302)
            expect(response).to redirect_to(new_declaration_form_path(transient_registration[:token]))
          end
        end
      end
    end

    describe "GET destroy_partner_overview_forms_path" do
      context "when a valid transient registration exists" do
        let!(:transient_registration) do
          create(:new_registration,
                 transient_people: transient_people,
                 workflow_state: "partner_overview_form")
        end

        context "when the destroy action is triggered" do
          context "when there is only one completed partner" do
            let(:transient_people) { [build(:transient_person, :completed)] }

            it "destroys the partner, returns a 302 response and redirects to the partner_name form" do
              destroyable_partner_id = transient_people.first.id
              get destroy_partner_overview_forms_path(transient_registration[:token],
                                                      partner_id: destroyable_partner_id)

              expect { TransientPerson.find(destroyable_partner_id) }.to raise_error(ActiveRecord::RecordNotFound)
              expect(response).to have_http_status(302)
              expect(response).to redirect_to(new_partner_name_form_path(transient_registration[:token]))
            end
          end

          context "when there are multiple completed partners" do
            let(:transient_people) { build_list(:transient_person, 3, :completed) }

            it "destroys the partner, returns a 302 response and redirects to the partner_overview form" do
              destroyable_partner_id = transient_people.first.id
              get destroy_partner_overview_forms_path(transient_registration[:token],
                                                      partner_id: destroyable_partner_id)

              expect { TransientPerson.find(destroyable_partner_id) }.to raise_error(ActiveRecord::RecordNotFound)
              expect(response).to have_http_status(302)
              expect(response).to redirect_to(new_partner_overview_form_path(transient_registration[:token]))
            end
          end
        end
      end
    end
  end
end
