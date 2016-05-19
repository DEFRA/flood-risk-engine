require "rails_helper"

module FloodRiskEngine

  RSpec.describe Enrollments::PagesController, type: :controller do
    routes { Engine.routes }
    render_views

    context "Given I'm on the Declaration page" do
      let(:enrollment) { FactoryGirl.create(:page_declaration) }

      it "When I click the privacy policy link Then the Privacy Policy page will open in the same tab" do
        get :show, id: "privacy_policy", enrollment_id: enrollment

        expect(response.body).to have_tag :h1, text: t("pages.privacy_policy.heading")
        expect(response.body).to_not include "translation missing:"
      end

      it "When I click the privacy policy link Then the Privacy Policy page has a suitable Back link" do
        get :show, id: "privacy_policy", enrollment_id: enrollment

        link_href = "/fre/enrollments/#{enrollment.token}/steps/declaration"

        expect(response.body).to have_tag("a", href: link_href)
      end
    end
  end
end
