require "rails_helper"
describe FloodRiskEngine::Enrollments::StepsController, type: :controller do
  routes { FloodRiskEngine::Engine.routes }
  render_views

  let(:enrollment) { FactoryGirl.create(:enrollment) }

  context "step 1" do
    let(:step) { "step1" }

    before do
      get :edit, step: step, id: enrollment
    end

    it "uses Step1Form" do
      expect(controller.send(:form)).to be_a(FloodRiskEngine::Steps::Step1Form)
    end

    it "diplays header" do
      header_text = "Question 1"
      expect(response.body).to have_tag :h1, text: /#{header_text}/
    end
  end

  context "step 2" do
    let(:step) { "step2" }

    it "uses Step2Form" do
      get :edit, step: step, id: enrollment
      expect(controller.send(:form)).to be_a(FloodRiskEngine::Steps::Step2Form)
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

    it "uses Step1Form" do
      expect do
        get :edit, step: step, id: enrollment
      end.to raise_error(StandardError)
    end
  end
end
