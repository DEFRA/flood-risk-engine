require "rails_helper"
module FloodRiskEngine
  describe Enrollments::StepsController, type: :controller do
    routes { Engine.routes }
    render_views
    let(:enrollment) { FactoryGirl.create(:enrollment, step: step) }

    context "control of steps" do
      let(:steps) { WorkFlow::Definitions.start }

      describe "test assumption" do
        it "WorkFlow.start has more than two steps" do
          expect(steps.length).to be > 2
        end
      end

      context "show action" do
        before do
          get :show, id: step, enrollment_id: enrollment
        end

        describe "current step (step == enrollment.step)" do
          let(:step) { steps[1] }
          it "should render page successfully" do
            expect(response).to have_http_status(:success)
          end
        end

        describe "back step (step == (enrollment.step - 1)" do
          let(:step) { steps[0] }
          let(:enrollment) { FactoryGirl.create(:enrollment, step: steps[1]) }
          it "should render page successfully" do
            expect(response).to have_http_status(:success)
          end
          it "should move enrollment back" do
            expect(enrollment.reload.step).to eq(step.to_s)
          end
        end

        context "mismatches" do
          describe "large (step many steps from enrollment.step)" do
            let(:step) { steps.first }
            let(:enrollment) { FactoryGirl.create(:enrollment, step: steps.last) }
            it "should redirect to enrollment.step" do
              expect(response).to redirect_to(
                "/fre/enrollments/#{enrollment.to_param}/steps/#{steps.last}"
              )
            end
          end

          describe "step too soon (step one after enrollment.step)" do
            let(:step) { steps[2] }
            let(:enrollment) { FactoryGirl.create(:enrollment, step: steps[1]) }
            it "should redirect to enrollment.step" do
              expect(response).to redirect_to(
                "/fre/enrollments/#{enrollment.to_param}/steps/#{steps[1]}"
              )
            end
          end
        end
      end
    end

    context "step unknown" do
      let(:step) { "unknown" }

      it "uses GridReferenceForm" do
        expect do
          get :show, step: step, id: enrollment
        end.to raise_error(StandardError)
      end
    end
  end
end
