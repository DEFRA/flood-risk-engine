require "rails_helper"

module FloodRiskEngine

  RSpec.describe Enrollments::PagesController, type: :controller do
    routes { Engine.routes }
    render_views

    context "Given I'm on the Declaration page" do
      let(:enrollment) { FactoryGirl.create(:page_declaration) }

      it "When I click the privacy policy link Then the Privacy Policy page will open in new tab" do
        get :show, id: "privacy_policy", enrollment_id: enrollment

        expect(response.body).to have_text t("pages.privacy_policy.heading_h1")
        expect(response.body).to_not include "translation missing:"
      end

      it "When I click the cookies link Then the Cookies page will open in new tab" do
        get :show, id: "cookies", enrollment_id: enrollment

        expect(response.body).to have_text t("pages.cookies.heading_h1")
        expect(response.body).to_not include "translation missing:"
      end
    end
  end
end
