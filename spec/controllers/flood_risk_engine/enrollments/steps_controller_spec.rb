require "rails_helper"
describe FloodRiskEngine::Enrollments::StepsController, type: :controller do
  routes { FloodRiskEngine::Engine.routes }
  render_views

  let(:enrollment) { FactoryGirl.create(:enrollment) }

  context "grid_reference" do
    let(:step) { "grid_reference" }

    before do
      get :edit, step: step, id: enrollment
    end

    it "uses GridReferenceForm" do
      expect(controller.send(:form)).to be_a(FloodRiskEngine::Steps::GridReferenceForm)
    end

    it "diplays header" do
      header_text = "Where will the activity be located?" # TODO: change to i18n
      expect(response.body).to have_tag :h1, text: /#{header_text}/
    end
  end

  context "applicant contact name" do
    let(:step) { "applicant_contact_name" }

    it "uses ApplicantContactNameForm" do
      get :edit, step: step, id: enrollment
      expect(controller.send(:form)).to be_a(FloodRiskEngine::Steps::ApplicantContactNameForm)
    end
  end

  context "organisation_type" do
    let(:step) { "organisation_type" }

    it "uses OrganisationTypeForm" do
      get :edit, step: step, id: enrollment
      expect(controller.send(:form)).to be_a(FloodRiskEngine::Steps::OrganisationTypeForm)
    end
  end

  context "step unknown" do
    let(:step) { "unknown" }

    it "uses GridReferenceForm" do
      expect do
        get :edit, step: step, id: enrollment
      end.to raise_error(StandardError)
    end
  end
end
